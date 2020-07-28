import 'package:d2shop/models/doonstore_user.dart';
import 'package:d2shop/models/shopping_model.dart';
import 'package:d2shop/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ApplicationState extends ChangeNotifier {
  DoonStoreUser user;
  Map<String, int> cart = Map();
  DateTime deliveryDate = DateTime.now();
  List<Category> categoryList = <Category>[];

  setUser(DoonStoreUser doonStoreUser) {
    this.user = doonStoreUser;
    notifyListeners();
  }

  setDeliveryDate(DateTime dateTime) {
    this.deliveryDate = dateTime;
    notifyListeners();
  }

  setCategoryList(List<Category> dataList) {
    this.categoryList = dataList;
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
