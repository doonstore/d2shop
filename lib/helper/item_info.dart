import 'package:d2shop/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemInfo extends StatefulWidget {
  @override
  _ItemInfoState createState() => _ItemInfoState();
}

class _ItemInfoState extends State<ItemInfo> {
  int _itemValue = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height(context) * 0.6,
      width: width(context),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(
              'assets/item/2.png',
              height: 200.h,
            ),
          ),
          SizedBox(height: 15),
          Text(
            'Amul Milk (Pure Milk) - 200 Ml',
            style: GoogleFonts.ptSans(
              fontWeight: FontWeight.bold,
              fontSize: 22.sp,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              '20 Pkt',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 14.sp,
                color: Colors.grey,
              ),
            ),
          ),
          Text(
            '20.00',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            ),
          ),
          SizedBox(height: 15),
          FractionallySizedBox(
            widthFactor: 1.0,
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 400),
              transitionBuilder: (child, animation) =>
                  FadeTransition(opacity: animation, child: child),
              child: _itemValue > 0
                  ? Material(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          changeValueButton(false),
                          Text(
                            "$_itemValue",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
                            ),
                          ),
                          changeValueButton(true)
                        ],
                      ),
                    )
                  : btn('ADD', Colors.blue[400],
                      () => this.setState(() => _itemValue++)),
            ),
          ),
        ],
      ),
    );
  }

  changeValueButton(bool increment) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: Colors.grey[200],
      child: IconButton(
        icon: FaIcon(
          increment ? FontAwesomeIcons.plus : FontAwesomeIcons.minus,
          color: increment ? Colors.green : Colors.redAccent,
        ),
        onPressed: () => this.setState(
          () => increment ? _itemValue++ : _itemValue--,
        ),
      ),
    );
  }

  btn(String text, Color color, Function onTap) {
    return FractionallySizedBox(
      widthFactor: 1.0,
      child: GestureDetector(
        onTap: onTap,
        child: Material(
          textStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          color: color,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Center(child: Text(text)),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
