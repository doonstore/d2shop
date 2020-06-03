import 'package:firebase_auth/firebase_auth.dart';

class ApplicationState {
  final bottomNavBarTitles = ['Home', 'Categories', 'Account'];
  int bottomNavBarSelectedIndex = 0;
  String appBarTitle = 'Home';
  FirebaseUser user;
}
