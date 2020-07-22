import 'dart:async';

import 'package:d2shop/components/gallery_page.dart';
import 'package:d2shop/config/authentication.dart';
import 'package:d2shop/config/shared_services.dart';
import 'package:d2shop/screens/login_screen.dart';
import 'package:d2shop/utils/route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  bool isOldUser = false, isUserSignedIn = false;

  @override
  void initState() {
    super.initState();
    // init();
  }

  init() async {
    isUserSignedIn = await isSignedIn();
    isOldUser = await SharedService.isOldUser;

    if (isUserSignedIn || isOldUser)
      Timer(Duration(milliseconds: 300), () {
        MyRoute.push(context, GalleryPage(), replaced: true);
      });
    else
      MyRoute.push(context, LoginScreen(), replaced: true);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    ScreenUtil.init(context, height: size.height, width: size.width);

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue[100],
              radius: MediaQuery.of(context).size.width * 0.35,
              child: Text('App Logo'),
            ),
            SizedBox(height: 15),
            Text(
              'App Name',
              style: GoogleFonts.ptSans(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 15),
            Text(
              'App Description',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
