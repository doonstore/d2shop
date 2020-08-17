import 'dart:ui';

import 'package:d2shop/state/application_state.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Orders',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
          actions: [
            SizedBox(width: 10),
            IconButton(
              icon: FaIcon(FontAwesomeIcons.retweet),
              onPressed: () {},
              tooltip: 'Tap to view previous',
              color: Colors.black,
            )
          ],
        ),
        // body: SingleChildScrollView(
        //   child: Container(
        //     width: width(context),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         ExpansionTile(
        //           leading: Text(
        //             '23\nAug',
        //             textAlign: TextAlign.center,
        //             style: TextStyle(fontWeight: FontWeight.w400),
        //           ),
        //           trailing: SizedBox(),
        //           subtitle: Text(''),
        //           title: Text(
        //             'Day',
        //             style: TextStyle(fontWeight: FontWeight.w600),
        //           ),
        //           expandedAlignment: Alignment.centerLeft,
        //           children: [
        //             SideItemInfo("DELIVERED"),
        //             Container(
        //               padding: EdgeInsets.all(15),
        //               child: Column(
        //                 children: [Text('Hey')],
        //               ),
        //             )
        //           ],
        //         )
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
