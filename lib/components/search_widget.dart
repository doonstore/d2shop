import 'package:d2shop/utils/constants.dart';
import 'package:d2shop/utils/strings.dart';
import 'package:d2shop/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context),
      color: kPrimaryColor,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 6),
            child: Text(
              Strings.whatCan,
              style: TextStyle(
                fontSize: 18.sp,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 10),
          Utils.searchCard(kPrimaryColor.withOpacity(0.7), context)
        ],
      ),
    );
  }
}
