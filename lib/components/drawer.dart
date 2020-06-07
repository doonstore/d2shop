import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:d2shop/state/application_state.dart';
import 'my_account.dart';

class AppDrawer extends StatefulWidget {
  final ApplicationState state;
  AppDrawer({this.state});

  @override
  _AppDrawerState createState() => _AppDrawerState(state);
}

class _AppDrawerState extends State<AppDrawer> {
  ApplicationState state;

  _AppDrawerState(this.state);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
          children: <Widget>[
            new ListTile(
                leading: Icon(Icons.person),
                title: new Text("Abhishek"),
                trailing: new Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Account_Screen()));
                }),
            new Divider(),
            new ListTile(
              leading: Icon(Icons.timer),
              title: new Text("Order History"),
              onTap: (){
                Fluttertoast.showToast(msg: "Order History");
              },
            ),
            new ListTile(
              leading: Icon(Icons.account_balance_wallet),
              title: new Text("Wallet"),
              onTap: (){
                Fluttertoast.showToast(msg: "Wallet");
              },
            ),
            new ListTile(
              leading: Icon(Icons.help),
              title: new Text("Support & FAQ's"),
              onTap: (){
                Fluttertoast.showToast(msg: "Wallet");
              },
            )

          ]),
    );
  }
}
