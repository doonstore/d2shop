import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d2shop/models/doonstore_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
final databaseReference = Firestore.instance;

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

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);
  var userFromDB = await databaseReference
      .collection('users')
      .document(user.uid)
      .snapshots()
      .first;
  DoonStoreUser userData;
  if (userFromDB.data == null) {
    userData = DoonStoreUser.fromFirebaseUser(user);
    databaseReference
        .collection('users')
        .document(userData.userId)
        .setData(userData.toMap());
  } else {
    userData = DoonStoreUser.fromJson(userFromDB.data);
    userData.lastLogin = user.metadata.lastSignInTime;
    databaseReference
        .collection('users')
        .document(userData.userId)
        .updateData(userData.toMap());
  }
  return userData;
}

Future<void> signOutGoogle() async {
  await googleSignIn.signOut();
  return true;
}
