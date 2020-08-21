import 'package:d2shop/models/shopping_model.dart';

class ItemCart {
  int quantity;
  double totalPrice;
  Item item;

  ItemCart({this.item, this.quantity, this.totalPrice});

  factory ItemCart.fromJson(Map<String, dynamic> json) {
    return ItemCart(
      item: json['item'],
      quantity: json['quantity'],
      totalPrice: json['totalPrice'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'item': item,
      'totalPrice': totalPrice,
      'quantity': quantity,
    };
  }
}
