import 'package:d2shop/models/DoonStoreUser.dart';

class ApplicationState {
  final bottomNavBarTitles = ['Home', 'Categories', 'Account'];
  int bottomNavBarSelectedIndex = 0;
  String appBarTitle = 'Home';
  DoonStoreUser user;
}
