import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowingCart extends StatefulWidget {
  @override
  _ShowingCartState createState() => _ShowingCartState();
}

class _ShowingCartState extends State<ShowingCart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Card(
        color: Colors.teal[400],
        shadowColor: Colors.teal[300],
        elevation: 5,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          leading: FaIcon(FontAwesomeIcons.shoppingBasket),
          title: Text(
            '1 item',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            '\u20b920.00',
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
