import 'package:flutter/material.dart';

import 'edit_user_details.dart';

class AddressScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Address();
}

class Address extends State<AddressScreen> {

  String appartmentName = "XYZ Apartment";

  @override
  Widget build(BuildContext context) {
    Color hexToColor(String code) {
      return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    }
    return new Scaffold(
      appBar: new AppBar(
        title: Text(
          'My Address',
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Padding(padding: EdgeInsets.only(top: 10.0)),
            Container(
              child: new Text(
                'Apartment / Society*',
                textAlign: TextAlign.left,
                style: new TextStyle(
                    color: Colors.grey, fontSize: 15.0),
              ),
            ),
            new Padding(padding: EdgeInsets.only(top: 5.0)),
            Container(
              width: 362,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Select the apartment"
                  ),
                  autofocus: false,
                ),
            ),
            new Padding(padding: EdgeInsets.only(top: 10.0)),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Text(
                  'Tower / Block*',
                 // textAlign: TextAlign.left,
                  style: new TextStyle(
                      color: Colors.grey, fontSize: 15.0),
                ),
                new Padding(padding: EdgeInsets.only(left: 80.0)),
                new Text(
                  'Flat / HouseNo*',
                  // textAlign: TextAlign.left,
                  style: new TextStyle(
                      color: Colors.grey, fontSize: 15.0),
                )
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
              Container(
              width: 150,
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Select the block..."
                ),
                autofocus: false,
              ),
            ),
                new Padding(padding: EdgeInsets.only(left: 30.0)),
                Container(
                  width: 180,
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Select the apartment"
                    ),
                    autofocus: false,
                  ),
                ),
              ],
            ),
            new Padding(padding: EdgeInsets.only(top: 40.0)),
           RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () {},
                color: Colors.lightBlueAccent,
                child: Text("Update Details",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0)),
              ),
          ],
        ),
      ),
    );
  }
}
