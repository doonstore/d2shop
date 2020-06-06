import 'package:d2shop/components/category_list_widget.dart';
import 'package:d2shop/components/item_list_widget.dart';
import 'package:d2shop/state/application_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'search_widget.dart';
import '../config/authentication.dart';

class GalleryPage extends StatefulWidget {
  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  var state = ApplicationState();
  //var _childWidgets;

 /* _GalleryPageState() {
    _childWidgets = [ItemListWidget(state: state), CategoryList(state: state)];
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body: new SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                SearchWidget(),
                new Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new GestureDetector(
                        onTap: () {
                          Fluttertoast.showToast(msg: "Heelo");
                        },
                        child: new Text(
                          'Date Section',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ]),
                new Container(
                  margin: EdgeInsets.only(
                      left: 5.0, right: 0.0, top: 115.0, bottom: 0.0),
                ),
                new Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new GestureDetector(
                        onTap: () {
                          Fluttertoast.showToast(msg: "Heelo");
                        },
                        child: new Text(
                          'Featured Section',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ]),
                new Container(
                  margin: EdgeInsets.only(
                      left: 5.0, right: 0.0, top: 115.0, bottom: 0.0),
                ),
                new Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new GestureDetector(
                        onTap: () {
                          Fluttertoast.showToast(msg: "Heelo");
                        },
                        child: new Text(
                          'Categories',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ]),
              ],
            ),
          )),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                  state.user == null ? 'Anonymous' : state.user.displayName),
              accountEmail: Text(state.user == null
                  ? 'anonymous@nomail.com'
                  : state.user.email),
              currentAccountPicture: CircleAvatar(
                backgroundColor:
                Theme.of(context).platform == TargetPlatform.iOS
                    ? Colors.blue
                    : Colors.white,
                child: getDisplayPicture(),
              ),
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: Text('Category'),
              onTap: () {
                Fluttertoast.showToast(msg: 'Category pressed');
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('My Orders'),
              onTap: () {
                Fluttertoast.showToast(msg: 'Order pressed');
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('View Cart'),
              onTap: () {
                Fluttertoast.showToast(msg: 'Cart pressed');
              },
            ),
            ListTile(
              leading: Icon(Icons.help_outline),
              title: Text('Help'),
              onTap: () {
                Fluttertoast.showToast(msg: 'Help pressed');
              },
            ),
            getUserActionTile()
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text('Categories'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            title: Text('Account'),
          )
        ],
        selectedItemColor: Colors.blueAccent,
        currentIndex: state.bottomNavBarSelectedIndex,
        onTap: (index) {
          setState(() {
            state.bottomNavBarSelectedIndex = index;
            state.appBarTitle =
            state.bottomNavBarTitles[state.bottomNavBarSelectedIndex];
          });
          Fluttertoast.showToast(msg: "${state.appBarTitle} pressed");
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.shopping_cart),
        onPressed: () {
          Fluttertoast.showToast(
            msg: 'Show shopping cart!',
            toastLength: Toast.LENGTH_SHORT,
          );
        },
      ),
    );
  }

  Widget getDisplayPicture() {
    if (state.user == null) {
      return Text(
        "A",
        style: TextStyle(fontSize: 40.0),
      );
    } else {
      return Container(
        width: 190.0,
        height: 190.0,
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
