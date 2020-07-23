import 'package:d2shop/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static Future<bool> showMessage(String message,
      {bool error = false, bool basic = false}) {
    return Fluttertoast.showToast(
      msg: message,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor:
          error ? Colors.red : basic ? kPrimaryColor : Colors.green,
      fontSize: 15.sp,
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
}
