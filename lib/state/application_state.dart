import 'package:d2shop/models/doonstore_user.dart';
import 'package:d2shop/models/shopping_model.dart';
import 'package:d2shop/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ApplicationState extends ChangeNotifier {
  DoonStoreUser user;
  Map<String, Map<String, double>> cart;
  DateTime deliveryDate;
  List<Category> categoryList;

  ApplicationState() {
    cart = Map<String, Map<String, double>>();
    deliveryDate = DateTime.now();
    categoryList = <Category>[];
  }

  addItemToTheCart(Item item) {
    if (cart.containsKey(item.id))
      cart.update(
        item.id,
        (value) => {
          'quantity': value['quantity'] + 1,
          'totalPrice': value['totalPrice'] + item.price
        },
      );
    else
      cart[item.id] = {'quantity': 1, 'totalPrice': item.price};

    notifyListeners();
  }

  removeItemFromTheCart(Item item) {
    if (cart[item.id]['quantity'] > 1)
      cart.update(
        item.id,
        (value) => {
          'quantity': value['quantity'] - 1,
          'totalPrice': value['totalPrice'] - item.price
        },
      );
    else
      cart.remove(item.id);

    notifyListeners();
  }

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
      margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
      color: Colors.transparent,
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
                    '${cart.length} Item(s)',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\u20b9${_getCurrentPrice()}',
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

  double _getCurrentPrice() {
    double val = 0.0;
    cart.forEach((key, value) {
      val += value['totalPrice'];
    });
    return val;
  }
}
