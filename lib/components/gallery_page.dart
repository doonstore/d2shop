import 'package:d2shop/components/category_list_widget.dart';
import 'package:d2shop/components/my_account.dart';
import 'package:d2shop/state/application_state.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'drawer.dart';
import 'search_widget.dart';

class GalleryPage extends StatefulWidget {
  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  var state = ApplicationState();

  _GalleryPageState() {
    CategoryList(state: state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        bottomOpacity: 0.0,
        elevation: 0.0,
        title: Text(state.appBarTitle),
      ),
      body: new SingleChildScrollView(
          child: Container(
        child: Column(
          children: <Widget>[
            // Home Page - Search Widget - It takes us to the Categories
            SearchWidget(state: state),
            new Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new GestureDetector(
                    onTap: () {
                      Fluttertoast.showToast(msg: "Heelo");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SearchWidget(state: state)));
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
      drawer: DrawerWidget(state: state),
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
          if (state.bottomNavBarSelectedIndex == 2) {
            if (state.user != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AccountScreen(state: state),
                ),
              );
            } else {
              Fluttertoast.showToast(
                msg: "Please login to view accounts page",
                toastLength: Toast.LENGTH_SHORT,
              );
            }
          }
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
}
