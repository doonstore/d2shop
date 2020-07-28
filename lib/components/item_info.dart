import 'package:d2shop/models/shopping_model.dart';
import 'package:d2shop/state/application_state.dart';
import 'package:d2shop/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ItemInfo extends StatefulWidget {
  final Item item;
  const ItemInfo({@required this.item});

  @override
  _ItemInfoState createState() => _ItemInfoState();
}

class _ItemInfoState extends State<ItemInfo> {
  // int _itemValue = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: (context, value, child) => ListTile(
        leading: Image.asset(widget.item.photoUrl),
        title: Text(
          widget.item.name,
          style: GoogleFonts.ptSans(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '\u20b9${widget.item.price} (${widget.item.quantityValue} ${widget.item.quantityUnit})',
          style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),
        ),
        trailing: value.cart.containsKey(widget.item.id)
            ? FractionallySizedBox(
                widthFactor: 0.40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Material(
                      color: Colors.grey[200],
                      elevation: 1,
                      shadowColor: kPrimaryColor,
                      shape: rounded(30),
                      animationDuration: Duration(milliseconds: 300),
                      child: IconButton(
                        iconSize: 15,
                        color: Colors.black,
                        icon: Icon(FontAwesomeIcons.minus),
                        onPressed: () =>
                            value.removeItemFromTheCart(widget.item),
                      ),
                    ),
                    Text(
                      '${value.cart[widget.item.id]['quantity'].toInt()}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Material(
                      elevation: 1,
                      animationDuration: Duration(milliseconds: 300),
                      shadowColor: kPrimaryColor,
                      color: Colors.grey[200],
                      shape: rounded(30),
                      child: IconButton(
                        iconSize: 15,
                        color: Colors.black,
                        icon: Icon(FontAwesomeIcons.plus),
                        onPressed: () => value.addItemToTheCart(widget.item),
                      ),
                    ),
                  ],
                ),
              )
            : OutlineButton.icon(
                onPressed: () => value.addItemToTheCart(widget.item),
                borderSide: BorderSide(color: kPrimaryColor),
                shape: rounded(20),
                icon: FaIcon(
                  FontAwesomeIcons.plus,
                  size: 15,
                  color: kPrimaryColor,
                ),
                textColor: kPrimaryColor,
                label: Text('Add'),
              ),
      ),
    );
  }
}
