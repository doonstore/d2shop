import 'package:cached_network_image/cached_network_image.dart';
import 'package:d2shop/models/shopping_model.dart';
import 'package:d2shop/state/application_state.dart';
import 'package:d2shop/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ItemInfo extends StatelessWidget {
  final Item item;
  final bool isCart;
  const ItemInfo({@required this.item, this.isCart = false});

  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: (context, value, child) {
        return ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          leading: CachedNetworkImage(imageUrl: item.photoUrl),
          title: Text(
            item.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            '$rupeeUniCode${item.price} (${item.quantityValue} ${item.quantityUnit})',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          trailing: !isCart
              ? value.cart.containsKey(item.id)
                  ? FractionallySizedBox(
                      widthFactor: 0.37,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: IconButton(
                              icon: FaIcon(
                                FontAwesomeIcons.minus,
                                color: kPrimaryColor,
                                size: 15,
                              ),
                              onPressed: () =>
                                  value.removeItemFromTheCart(item),
                            ),
                          ),
                          Text(
                            '${value.cart[item.id]['quantity']}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          Flexible(
                            child: IconButton(
                              icon: FaIcon(
                                FontAwesomeIcons.plus,
                                color: kPrimaryColor,
                                size: 15,
                              ),
                              onPressed: () => value.addItemToTheCart(item),
                            ),
                          ),
                        ],
                      ),
                    )
                  : OutlineButton.icon(
                      onPressed: () => value.addItemToTheCart(item),
                      borderSide: BorderSide(color: kPrimaryColor),
                      shape: rounded(20),
                      icon: FaIcon(
                        FontAwesomeIcons.plus,
                        size: 15,
                        color: kPrimaryColor,
                      ),
                      textColor: kPrimaryColor,
                      label: Text('Add'),
                    )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    '${item.price} * ${value.cart[item.id]['quantity']} = ${item.price * value.cart[item.id]['quantity']}',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
        );
      },
    );
  }
}
