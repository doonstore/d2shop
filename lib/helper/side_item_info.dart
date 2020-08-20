import 'package:d2shop/utils/constants.dart';
import 'package:flutter/material.dart';

class SideItemInfo extends StatelessWidget {
  final String text;
  const SideItemInfo(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: kPrimaryColor, width: 2),
        borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}
