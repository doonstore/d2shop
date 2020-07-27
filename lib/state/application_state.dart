import 'package:d2shop/models/doonstore_user.dart';
import 'package:d2shop/models/shopping_model.dart';
import 'package:d2shop/repository/shopping_repository.dart';
import 'package:d2shop/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ApplicationState extends ChangeNotifier {
  final bottomNavBarTitles = ['Home', 'Categories', 'Account'];
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

  Widget showCart() {
    return Container(
      height: 60,
      color: Colors.white,
      child: Card(
        color: kPrimaryColor,
        shape: rounded(10),
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            children: [
              FaIcon(FontAwesomeIcons.shoppingBag, color: Colors.white),
              Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '1 Item',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\u20b920.0',
                    style: GoogleFonts.stylish(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Text(
                'Proceed to cart',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 10),
              FaIcon(
                FontAwesomeIcons.angleRight,
                color: Colors.white,
                size: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
