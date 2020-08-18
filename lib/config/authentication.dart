import 'package:d2shop/screens/home_page.dart';
import 'package:d2shop/helper/user_input.dart';
import 'package:d2shop/state/application_state.dart';
import 'package:flutter/material.dart';

import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d2shop/models/doonstore_user.dart';
import 'package:d2shop/screens/login_screen.dart';
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
  String code, verifyId;

  _auth.verifyPhoneNumber(
    phoneNumber: '+91' + number,
    timeout: Duration(seconds: 20),
    verificationCompleted: (AuthCredential credential) async {
      final AuthResult result = await _auth.signInWithCredential(credential);
      redirectUser(result, context);
    },
    verificationFailed: (AuthException e) {
      Utils.showMessage(e.message, error: true);
      print("Error Code: ${e.code}, Error Message: ${e.message}");
    },
    codeSent: (String verificationId, [int]) {
      verifyId = verificationId;
      Utils.showMessage('OTP has been sent to +91-$number');
    },
    codeAutoRetrievalTimeout: (String verificationId) {
      verifyId = verificationId;
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
            decoration: InputDecoration(labelText: 'OTP'),
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
                  Navigator.pop(context);
                  AuthCredential credential = PhoneAuthProvider.getCredential(
                      verificationId: verifyId, smsCode: code);
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
      Utils.showMessage('Successfully Signed In.');

      if (user.displayName.isEmpty)
        MyRoute.push(context, UserInput(doonStoreUser: user, isSettingUp: true),
            replaced: true);
      else {
        Provider.of<ApplicationState>(context, listen: false).setUser(user);
        MyRoute.push(context, HomePage(), replaced: true);
      }
    }
  }).catchError((e) {
    Utils.showMessage('Error: $e', error: true);
  });
}

signOut(BuildContext context) {
  _auth.signOut().then((value) {
    MyRoute.push(context, LoginScreen(), replaced: true);
  }).catchError((e) {
    Utils.showMessage('Error: $e', error: true);
  });
}

Future<DoonStoreUser> getUser(FirebaseUser user) async {
  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);
  DocumentSnapshot userFromDB = await userRef.document(user.uid).get();
  DoonStoreUser userData;
  if (userFromDB.data == null) {
    userData = DoonStoreUser.fromFirebase(user);
    userRef.document(userData.userId).setData(userData.toMap());
  } else {
    userData = DoonStoreUser.fromJson(userFromDB.data);
    userData.lastLogin = user.metadata.lastSignInTime.toString();
    userRef.document(userData.userId).updateData(userData.toMap());
  }
  return userData;
}
