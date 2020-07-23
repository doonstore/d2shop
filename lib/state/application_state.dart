import 'package:d2shop/models/doonstore_user.dart';
import 'package:d2shop/models/shopping_model.dart';
import 'package:d2shop/repository/shopping_repository.dart';
import 'package:flutter/material.dart';

class ApplicationState extends ChangeNotifier {
  final bottomNavBarTitles = ['Home', 'Categories', 'Account'];
  int bottomNavBarSelectedIndex = 0;
  String appBarTitle = 'Home';
  DoonStoreUser user;
  List<Item> itemList;
  Map<String, int> cart = Map();
  List<Category> categoryList;
  DateTime deliveryDate = DateTime.now();

  ApplicationState() {
    getItems().then((value) {
      itemList = value;
      for (Item item in itemList) {
        cart[item.id] = 0;
      }
    });
    getCategories().then((value) => categoryList = value);
  }

  setUser(DoonStoreUser doonStoreUser) {
    this.user = doonStoreUser;
    notifyListeners();
  }

  setDeliveryDate(DateTime dateTime) {
    this.deliveryDate = dateTime;
    notifyListeners();
  }
}
