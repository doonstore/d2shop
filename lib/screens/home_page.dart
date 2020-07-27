import 'package:animations/animations.dart';
import 'package:d2shop/components/drawer.dart';
import 'package:d2shop/screens/category_screen.dart';
import 'package:d2shop/screens/chat_screen.dart';
import 'package:d2shop/screens/gallery_page.dart';
import 'package:d2shop/screens/wallet_screen.dart';
import 'package:d2shop/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List bottomTabs = [
    ['Home', FontAwesomeIcons.home],
    ['Orders', FontAwesomeIcons.shoppingCart],
    ['Wallet', FontAwesomeIcons.wallet],
    ['Chat', FontAwesomeIcons.comment]
  ];

  List<Widget> _tabs = <Widget>[
    GalleryPage(),
    CategoryScreen(),
    WalletScreen(),
    ChatScreen()
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, height: height(context), width: width(context));
    return Scaffold(
      appBar: AppBar(
        title: Text(bottomTabs[_currentIndex][0]),
        elevation: 0.0,
      ),
      drawer: CustomDrawer(),
      body: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
          return SharedAxisTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.scaled,
            child: child,
          );
        },
        duration: Duration(milliseconds: 400),
        child: _tabs[_currentIndex],
      ),
      bottomNavigationBar: TitledBottomNavigationBar(
        onTap: (int n) => this.setState(() => _currentIndex = n),
        items: bottomTabs
            .map(
              (item) => TitledNavigationBarItem(
                icon: item[1],
                title: Text(
                  item[0],
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            )
            .toList(),
        currentIndex: _currentIndex,
        enableShadow: true,
        indicatorColor: kPrimaryColor,
        activeColor: kPrimaryColor,
      ),
    );
  }
}
