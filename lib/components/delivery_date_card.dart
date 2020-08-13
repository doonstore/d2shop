import 'package:d2shop/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DeliveryDate extends StatelessWidget {
  const DeliveryDate({
    Key key,
    this.desc,
    @required this.dateTime,
  }) : super(key: key);

  final DateTime dateTime;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor.withOpacity(0.2),
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          Text(
            '${dateTime.day}\n${DateFormat.MMM().format(dateTime).toUpperCase()}',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          Expanded(
            child: ListTile(
              title: Text(
                '${DateFormat.MMMMEEEEd().format(dateTime).split(',').first}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              subtitle: Text(
                desc,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
