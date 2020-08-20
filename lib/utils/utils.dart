import 'package:d2shop/components/category_explorer.dart';
import 'package:d2shop/utils/constants.dart';
import 'package:d2shop/utils/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Utils {
  static Future<bool> showMessage(String message,
      {bool error = false, bool basic = false}) {
    return Fluttertoast.showToast(
      msg: message,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
      gravity: basic ? ToastGravity.BOTTOM : ToastGravity.CENTER,
      backgroundColor: error ? Colors.red : basic ? Colors.black : Colors.green,
    );
  }

  static AppBar appBar(BuildContext context,
      {@required String title,
      Color color,
      Color backgroudColor,
      List<Widget> actions}) {
    return AppBar(
      title: Text(
        title,
        style: GoogleFonts.stylish(
          letterSpacing: 1.1,
          color: color ?? Colors.white,
          fontSize: 20.sp,
          fontWeight: FontWeight.w800,
        ),
      ),
      leading: IconButton(
        icon: FaIcon(FontAwesomeIcons.chevronLeft),
        onPressed: () => Navigator.pop(context),
        color: color ?? Colors.white,
      ),
      centerTitle: true,
      backgroundColor: backgroudColor ?? kPrimaryColor,
      actions: actions,
      elevation: 0.0,
    );
  }

  static Widget loadingWidget(BuildContext context) {
    return Container(
      height: 50,
      width: width(context),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Loading, Please Wait...',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.1,
            ),
          ),
          SizedBox(width: 10),
          SpinKitThreeBounce(color: Colors.white, size: 30),
        ],
      ),
    );
  }

  static Widget searchCard(Color color, BuildContext context) {
    return GestureDetector(
      onTap: () => MyRoute.push(context, CategoryExplorer()),
      child: Card(
        shape: rounded(8),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              FaIcon(FontAwesomeIcons.search, color: color),
              SizedBox(width: 10),
              Text(
                'Search for milk & groceries...',
                style: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  static InputDecoration inputDecoration(String label,
      {String hint, Widget icon}) {
    return InputDecoration(
      labelText: label,
      hintText: hint != null ? hint : "Enter your ${label.toLowerCase()}",
      icon: icon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      isDense: true,
    );
  }

  static TextStyle formTextStyle() {
    return TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWeight.w600,
    );
  }

  static Widget basicBtn(BuildContext context, {String text, Function onTap}) {
    return Container(
      width: width(context) * 0.90,
      height: 50,
      child: RaisedButton(
        onPressed: onTap,
        disabledColor: Colors.grey.shade300,
        textColor: Colors.white,
        disabledTextColor: Colors.black,
        animationDuration: Duration(milliseconds: 300),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        color: kPrimaryColor,
      ),
    );
  }
}
