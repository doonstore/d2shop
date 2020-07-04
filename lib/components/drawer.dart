import 'package:d2shop/config/authentication.dart';
import 'package:d2shop/state/application_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'my_account.dart';

class DrawerWidget extends StatefulWidget {
  final ApplicationState state;

  DrawerWidget({this.state});

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState(state);
}

class _DrawerWidgetState extends State<DrawerWidget> {
  ApplicationState state;

  _DrawerWidgetState(this.state);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: <Widget>[
        new ListTile(
            leading: getDisplayPicture(),
            title:
                new Text(state.user == null ? "Guest" : state.user.displayName),
            trailing: new Icon(Icons.arrow_forward_ios),
            onTap: () {
              if (state.user != null) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AccountScreen(state: state)));
              }
            }),
        new Divider(),
        new ListTile(
          leading: Icon(Icons.timer),
          title: new Text("Order History"),
          onTap: () {
            Fluttertoast.showToast(msg: "Order History");
          },
        ),
        new ListTile(
          leading: Icon(Icons.account_balance_wallet),
          title: new Text("Wallet"),
          onTap: () {
            Fluttertoast.showToast(msg: "Wallet");
          },
        ),
        new ListTile(
          leading: Icon(Icons.help),
          title: new Text("Support & FAQs"),
          onTap: () {
            Fluttertoast.showToast(msg: "Support & FAQs");
          },
        ),
        getUserActionTile(),
      ]),
    );
  }

  Widget getDisplayPicture() {
    if (state.user == null) {
      return Text(
        "G",
        style: TextStyle(fontSize: 30.0),
      );
    } else {
      return Container(
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(state.user.photoUrl),
          ),
        ),
      );
    }
  }

  Widget getUserActionTile() {
    if (state.user == null) {
      return SignInButton(
        Buttons.Google,
        text: 'Sign in with Google',
        onPressed: () {
          signInWithGoogle().then((v) {
            setState(() {
              state.user = v;
            });
          });
        },
      );
    } else {
      return ListTile(
        leading: Icon(Icons.exit_to_app),
        title: Text('Sign Out'),
        onTap: () {
          signOutGoogle().then((value) {
            setState(() {
              state.user = null;
            });
          });
        },
      );
    }
  }
}
