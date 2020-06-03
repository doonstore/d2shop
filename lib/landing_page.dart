import 'package:d2shop/main.dart';
import 'package:d2shop/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  final FirebaseUser user;

  HomePage({Key key, @required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(user);
}

class _HomePageState extends State<HomePage> {
  final FirebaseUser user;

  _HomePageState(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('d2shop'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.account_circle),
            tooltip: this.user.displayName,
            onPressed: () {
              print('allooo');
              Fluttertoast.showToast(
                msg: 'Logged in as ${user.displayName}',
                gravity: ToastGravity.BOTTOM,
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            tooltip: 'Logout',
            onPressed: () {
              signOutGoogle().then((v) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) {
                      return MyApp();
                    },
                  ),
                );
              });
            },
          )
        ],
      ),
      body: Container(
        color: Colors.blue[50],
        child: LandingPage(),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Hello World!'));
  }
}

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          title: Text('Business'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          title: Text('School'),
        )
      ],
      selectedItemColor: Colors.amber[800],
      currentIndex: _selectedIndex,
      onTap: _handleTap,
    );
  }

  void _handleTap(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }
}
