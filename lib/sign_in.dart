import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
final databaseReference = Firestore.instance;

Future<FirebaseUser> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);
  var data = {
    "id": user.uid,
    "displayName": user.displayName,
    "email": user.email,
    "phone": user.phoneNumber,
    "photoUrl": user.photoUrl,
    "lastLogin": user.metadata.lastSignInTime,
  };
  databaseReference
      .collection('users')
      .document(user.uid)
      .updateData(data)
      .catchError((ex) {
    databaseReference.collection('users').document(user.uid).setData(data);
  });
  return user;
}

Future<bool> signOutGoogle() async {
  await googleSignIn.signOut();
  return true;
}
