import 'package:d2shop/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DeliveryDate extends StatelessWidget {
  const DeliveryDate(
      {Key key, this.desc, @required this.dateTime, this.backroundColor = true})
      : super(key: key);

  final DateTime dateTime;
  final String desc;
  final backroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backroundColor ? kPrimaryColor.withOpacity(0.2) : Colors.white,
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
              subtitle: desc.isNotEmpty
                  ? Text(
                      desc,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    )
                  : null,
            ),
          )
        ],
      ),
    );
  }
}
