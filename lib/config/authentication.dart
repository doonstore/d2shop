import 'package:d2shop/components/gallery_page.dart';
import 'package:d2shop/state/application_state.dart';
import 'package:flutter/material.dart';

import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d2shop/config/shared_services.dart';
import 'package:d2shop/models/doonstore_user.dart';
import 'package:d2shop/screens/login_screen.dart';
import 'package:d2shop/screens/user_input.dart';
import 'package:d2shop/utils/constants.dart';
import 'package:d2shop/utils/route.dart';
import 'package:d2shop/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<DoonStoreUser> getCurrentUser() async {
  final FirebaseUser firebaseUser = await _auth.currentUser();
  if (firebaseUser == null)
    return null;
  else
    return userRef
        .document(firebaseUser.uid)
        .get()
        .then((value) => DoonStoreUser.fromJson(value.data));
}

Future<void> loginUsingPhoneNumber(BuildContext context, String number) async {
  String code;

  _auth.verifyPhoneNumber(
    phoneNumber: '+91' + number,
    timeout: Duration(seconds: 10),
    verificationCompleted: (AuthCredential credential) async {
      final AuthResult result = await _auth.signInWithCredential(credential);
      redirectUser(result, context);
    },
    verificationFailed: (AuthException e) {
      Utils.showMessage(e.message, error: true);
      print("Error Code: ${e.code}, Error Message: ${e.message}");
    },
    codeSent: (String verificationId, [int]) {
      Utils.showMessage('OTP has been sent to +91-$number');
    },
    codeAutoRetrievalTimeout: (String verificationId) {
      print(
        'codeAutoRetrievalTimeout: True, Showing Alert Dialog to get OTP from the user',
      );
      showModal(
        context: context,
        configuration: FadeScaleTransitionConfiguration(
          barrierDismissible: false,
          transitionDuration: Duration(milliseconds: 300),
        ),
        builder: (context) => AlertDialog(
          title: Text('Enter OTP'),
          content: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'OTP',
            ),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.indigo,
              letterSpacing: 1.2,
              fontWeight: FontWeight.bold,
            ),
            onChanged: (value) => code = value,
          ),
          actionsPadding: EdgeInsets.symmetric(horizontal: 15),
          actions: [
            FlatButton(
              onPressed: () async {
                if (code.length == 6) {
                  AuthCredential credential = PhoneAuthProvider.getCredential(
                      verificationId: verificationId, smsCode: code);
                  final AuthResult result =
                      await _auth.signInWithCredential(credential);
                  redirectUser(result, context);
                } else {
                  Utils.showMessage('OTP should be of 6 digits.', error: true);
                }
              },
              child: Text('Verify & Continue'),
              textColor: Colors.white,
              color: Colors.indigo,
            )
          ],
        ),
      );
    },
  );
}

redirectUser(AuthResult result, BuildContext context) {
  getUser(result.user).then((DoonStoreUser user) {
    if (user != null) {
      Provider.of<ApplicationState>(context, listen: false).setUser(user);
      Utils.showMessage('Successfully Signed In.');
      if (user.displayName.isNotEmpty)
        MyRoute.push(context, GalleryPage(), replaced: true);
      else
        MyRoute.push(context, UserInput(doonStoreUser: user), replaced: true);
    }
  });
}

signOut(BuildContext context) {
  _auth.signOut().then((value) {
    MyRoute.push(context, LoginScreen(), replaced: true);
  });
}

Future<DoonStoreUser> getUser(FirebaseUser user) async {
  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);
  DocumentSnapshot userFromDB = await userRef.document(user.uid).get();
  DoonStoreUser userData;
  if (userFromDB.data == null) {
    userData = DoonStoreUser.fromFirebaseUser(user);
    userRef.document(userData.userId).setData(userData.toMap());
  } else {
    userData = DoonStoreUser.fromJson(userFromDB.data);
    userData.lastLogin = user.metadata.lastSignInTime;
    userRef.document(userData.userId).updateData(userData.toMap());
  }
  await SharedService.setUserLoggedIn();
  return userData;
}
