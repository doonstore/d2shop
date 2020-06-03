import 'package:d2shop/main.dart';
import 'package:d2shop/sign_in.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  final String userName;

  const FirstScreen({Key key, @required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.blue[50],
      child: Center(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              child: Text('Signed In As ' + userName,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[900],
                  ))),
          Container(
            child: OutlineButton(
                onPressed: () {
                  signOutGoogle().then((v) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return MyApp();
                        },
                      ),
                    );
                  });
                },
                child: Text('Sign Out')),
          ),
        ],
      )),
    ));
  }
}
