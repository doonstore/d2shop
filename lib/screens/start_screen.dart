import 'dart:async';

import 'package:d2shop/screens/home_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:d2shop/state/application_state.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';
import '../utils/constants.dart';
import '../utils/route.dart';
import '../models/doonstore_user.dart';
import '../config/authentication.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  FirebaseMessaging _firebaseMessaging;
  @override
  void initState() {
    super.initState();
    _firebaseMessaging = FirebaseMessaging();
    init();
  }

  init() async {
    DoonStoreUser user = await getCurrentUser();

    if (user != null)
      Timer(Duration(milliseconds: 300), () async {
        if (user.token == null)
          await _firebaseMessaging.getToken().then((value) {
            user.token = value;
            userRef
                .document(user.userId)
                .updateData(user.toMap())
                .then((value) => _firebaseMessaging.subscribeToTopic("notify"));
          });

        Provider.of<ApplicationState>(context, listen: false).setUser(user);
        MyRoute.push(context, HomePage(), replaced: true);
      });
    else
      MyRoute.push(context, LoginScreen(), replaced: true);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    ScreenUtil.init(context, height: size.height, width: size.width);

    return Scaffold(
      body: Center(
        child: SpinKitWave(
          color: kPrimaryColor,
          size: 50,
        ),
      ),
    );
  }
}
