import 'package:d2shop/models/coupon_model.dart';
import 'package:d2shop/models/doonstore_user.dart';
import 'package:d2shop/models/item_cart_model.dart';
import 'package:d2shop/models/shopping_model.dart';
import 'package:d2shop/screens/cart_screen.dart';
import 'package:d2shop/utils/constants.dart';
import 'package:d2shop/utils/route.dart';
import 'package:d2shop/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ApplicationState extends ChangeNotifier {
  DoonStoreUser user;
  Map<String, ItemCart> cart;
  DateTime deliveryDate;
  List<Category> categoryList;
  CouponModel couponModel;
  double discount = 0.0;

  ApplicationState() {
    cart = Map<String, ItemCart>();
    deliveryDate = DateTime.now().add(Duration(days: 1));
    categoryList = <Category>[];
    couponModel = CouponModel();
  }

  addItemToTheCart(Item item) {
    if (cart.containsKey(item.id))
      cart.update(
        item.id,
        (value) => ItemCart(
          quantity: value.quantity + 1,
          totalPrice: value.totalPrice + item.price,
          item: item,
        ),
      );
    else
      cart[item.id] = ItemCart(quantity: 1, totalPrice: item.price, item: item);

    notifyListeners();
  }

  removeItemFromTheCart(Item item, {bool full = false}) {
    if (full)
      cart.remove(item.id);
    else {
      if (cart[item.id].quantity > 1)
        cart.update(
          item.id,
          (value) => ItemCart(
            quantity: value.quantity - 1,
            totalPrice: value.totalPrice - item.price,
            item: item,
          ),
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

  setCoupon(CouponModel model) {
    this.couponModel = model;
    discount = getCurrentPrice() * (model.benifitValue / 100);
    notifyListeners();
  }

  removeCoupon() {
    this.couponModel = null;
    discount = 0.0;
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
    deliveryDate = DateTime.now().add(Duration(days: 1));
    couponModel = CouponModel();
    notifyListeners();
  }

  num getWalletAmount() {
    return user.wallet - getCurrentPrice();
    // if (user.wallet > getCurrentPrice())
    //   return user.wallet - getCurrentPrice();
    // else
    //   return 0;
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
                      style: GoogleFonts.ptSans(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '$rupeeUniCode${getCurrentPrice()}',
                      style: GoogleFonts.overpass(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Text(
                  Strings.proceedToCart,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
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
      val += value.totalPrice;
    });
    return val;
  }
}
