import 'package:d2shop/models/doonstore_user.dart';
import 'package:d2shop/models/shopping_model.dart';
import 'package:d2shop/screens/cart_screen.dart';
import 'package:d2shop/utils/constants.dart';
import 'package:d2shop/utils/route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ApplicationState extends ChangeNotifier {
  DoonStoreUser user;
  Map<String, Map<String, dynamic>> cart;
  DateTime deliveryDate;
  List<Category> categoryList;

  ApplicationState() {
    cart = Map<String, Map<String, dynamic>>();
    deliveryDate = DateTime.now();
    categoryList = <Category>[];
  }

  addItemToTheCart(Item item) {
    if (cart.containsKey(item.id))
      cart.update(
        item.id,
        (value) => {
          'quantity': value['quantity'] + 1,
          'totalPrice': value['totalPrice'] + item.price,
          'item': item
        },
      );
    else
      cart[item.id] = {'quantity': 1, 'totalPrice': item.price, 'item': item};

    notifyListeners();
  }

  removeItemFromTheCart(Item item, {bool full = false}) {
    if (full)
      cart.remove(item.id);
    else {
      if (cart[item.id]['quantity'] > 1)
        cart.update(
          item.id,
          (value) => {
            'quantity': value['quantity'] - 1,
            'totalPrice': value['totalPrice'] - item.price,
            'item': item
          },
        );
      else
        cart.remove(item.id);
    }

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

  clearCart() {
    cart.clear();
    notifyListeners();
  }

  Widget showCart(BuildContext context) {
    return InkWell(
      onTap: () => MyRoute.push(context, CartScreen()),
      child: Container(
        height: 55,
        margin: EdgeInsets.fromLTRB(12, 0, 12, 10),
        color: Colors.transparent,
        child: Card(
          color: kPrimaryColor,
          shape: rounded(6),
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                FaIcon(FontAwesomeIcons.shoppingBag, color: Colors.white),
                Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${cart.length} Item${cart.length > 1 ? '(s)' : ''}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '$rupeeUniCode${getCurrentPrice()}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Text(
                  'Proceed to cart',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
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
      ),
    );
  }

  double getCurrentPrice() {
    double val = 0.0;
    cart.forEach((key, value) {
      val += value['totalPrice'];
    });
    return val;
  }
}
