import 'package:d2shop/components/calender_widget.dart';
import 'package:d2shop/components/my_account.dart';
import 'package:d2shop/state/application_state.dart';
import 'package:d2shop/utils/constants.dart';
import 'package:d2shop/utils/route.dart';
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
            title: Text(state.appBarTitle),
            elevation: 0.0,
          ),
          drawer: CustomDrawer(),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchWidget(),
                CalenderWidget(),
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Text(
                    'Featured',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                    ),
                  ),
                ),
                Container(
                  height: 180,
                  child: ListView.builder(
                    itemBuilder: (context, index) => Container(
                      margin: EdgeInsets.only(left: index == 0 ? 15 : 8),
                      width: width(context) * 0.60,
                      color: Colors.grey[100],
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          'https://uploads-ssl.webflow.com/5a9ee6416e90d20001b20038/5dfb574eb0741828a44a3c55_reddit-banner-size%20(1).png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ],
            ),
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
        );
      },
    );
  }
}
