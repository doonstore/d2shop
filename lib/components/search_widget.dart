import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      color: Colors.lightBlue,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(15, 20, 0, 5),
              child: Text(
                "What can we get you?",
                textScaleFactor: 2.0,
                style: TextStyle(fontSize: 8.0, color: Colors.white),
              ),
            ),
            Card(
              semanticContainer: true,
              borderOnForeground: true,
              margin: EdgeInsets.fromLTRB(10.0, 1.0, 10.0, 1.0),
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      child: Icon(
                        Icons.search,
                        color: Colors.black54,
                      ),
                      onTap: () {
                        Fluttertoast.showToast(msg: 'Search Pressed...');
                      },
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search for milk & groceries..."),
                        onSubmitted: (String item) {},
                      ),
                    )
                  ],
                ),
              ),
            ),
          ]),
    );
    throw UnimplementedError();
  }
}