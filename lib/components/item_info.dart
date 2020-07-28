import 'package:d2shop/models/shopping_model.dart';
import 'package:d2shop/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return ListTile(
      leading: Image.asset(widget.item.photoUrl),
      title: Text(
        widget.item.name,
        style: GoogleFonts.ptSans(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        '\u20b9${widget.item.price}',
        style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),
      ),
      trailing: OutlineButton.icon(
        onPressed: () {},
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
    );
  }
}
