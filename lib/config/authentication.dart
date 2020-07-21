import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d2shop/components/gallery_page.dart';
import 'package:d2shop/models/doonstore_user.dart';
import 'package:d2shop/utils/constants.dart';
import 'package:d2shop/utils/route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<DoonStoreUser> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;

  return await getUser(user);
}

Future<void> signOutGoogle() async {
  await googleSignIn.signOut();
  return true;
}

Future<void> loginUsingPhoneNumber(BuildContext context, String number) async {
  String verificationID;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  _auth.verifyPhoneNumber(
    phoneNumber: '+91' + number,
    timeout: Duration(seconds: 60),
    verificationCompleted: (AuthCredential credential) async {
      final AuthResult result = await _auth.signInWithCredential(credential);
      getUser(result.user).then((value) {
        if (value != null) MyRoute.push(context, GalleryPage());
      });
    },
    verificationFailed: (AuthException e) {
      FlutterError(e.message);
      print("Error Code: ${e.code}, Error Message: ${e.message}");
    },
    codeSent: (String verificationId, [int]) async {
      String smsCode;
      showBottomSheet(
        context: context,
        builder: (context) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: width(context),
              height: height(context) * 0.40,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 10),
                  Form(
                    key: formKey,
                    child: TextFormField(
                      validator: (value) => value.length != 6
                          ? 'OTP length should be of 6 digits'
                          : null,
                      keyboardType: TextInputType.number,
                      onSaved: (newValue) => smsCode = newValue.trim(),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: MaterialButton(
                          onPressed: () {
                            if (formKey.currentState.validate())
                              formKey.currentState.save();
                          },
                          child: Text('Verify & Continue'),
                          color: Colors.teal,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      );

      final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      final AuthResult result = await _auth.signInWithCredential(credential);

      getUser(result.user).then((value) {
        if (value != null) MyRoute.push(context, GalleryPage());
      });
    },
    codeAutoRetrievalTimeout: (String verificationId) {
      verificationID = verificationId;
      print(verificationID);
    },
  );
}

Future<DoonStoreUser> getUser(FirebaseUser user) async {
  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

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
  return userData;
}
