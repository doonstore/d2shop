import 'package:d2shop/components/category_list_widget.dart';
import 'package:d2shop/components/my_account.dart';
import 'package:d2shop/state/application_state.dart';
import 'package:d2shop/utils/constants.dart';
import 'package:d2shop/utils/route.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'drawer.dart';
import 'search_widget.dart';

class GalleryPage extends StatefulWidget {
  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  _GalleryPageState();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, height: height(context), width: width(context));
    return Consumer<ApplicationState>(
      builder: (context, state, child) {
        return Scaffold(
          appBar: AppBar(
            bottomOpacity: 0.0,
            elevation: 0.0,
            title: Text(state.appBarTitle),
          ),
          drawer: CustomDrawer(),
          body: ListView(
            children: <Widget>[
              SearchWidget(state: state),
              Container(
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    DatePicker(
                      DateTime.now(),
                      initialSelectedDate: DateTime.now(),
                      selectionColor: kPrimaryColor,
                      selectedTextColor: Colors.white,
                      onDateChange: (date) {
                        setState(() {
                          state.deliveryDate = date;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Container(
                height: 100,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Fluttertoast.showToast(msg: "Hello");
                      },
                      child: Text(
                        'Featured Section',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CategoryList.name(state),
            ],
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
              if (state.bottomNavBarSelectedIndex == 2) {
                if (state.user != null) {
                  MyRoute.push(context, AccountScreen());
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
      },
    );
  }
}
