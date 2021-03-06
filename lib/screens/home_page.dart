import 'package:animations/animations.dart';
import 'package:d2shop/components/drawer.dart';
import 'package:d2shop/models/message_model.dart';
import 'package:d2shop/screens/chat_screen.dart';
import 'package:d2shop/screens/gallery_page.dart';
import 'package:d2shop/screens/orders_screen.dart';
import 'package:d2shop/screens/wallet_screen.dart';
import 'package:d2shop/state/application_state.dart';
import 'package:d2shop/utils/constants.dart';
import 'package:d2shop/utils/utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  static GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  List bottomTabs = [
    ['Home', FontAwesomeIcons.home],
    ['Orders', FontAwesomeIcons.shoppingCart],
    ['Wallet', FontAwesomeIcons.wallet],
    ['Support', FontAwesomeIcons.comments]
  ];

  List<Widget> _tabs = <Widget>[
    GalleryPage(globalKey: _globalKey),
    OrdersScreen(),
    WalletScreen(),
    ChatScreen()
  ];

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        Message msg = Message.getMessage(message);
        Utils.showMessage("Title: ${msg.title}, Body: ${msg.body}");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        Message msg = Message.getMessage(message);
        Utils.showMessage("Title: ${msg.title}, Body: ${msg.body}");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        Message msg = Message.getMessage(message);
        Utils.showMessage("Title: ${msg.title}, Body: ${msg.body}");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, height: height(context), width: width(context));
    return Consumer<ApplicationState>(
      builder: (context, value, child) => Scaffold(
        key: _globalKey,
        drawer: CustomDrawer(),
        body: PageTransitionSwitcher(
          transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
            return SharedAxisTransition(
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.horizontal,
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
      ),
    );
  }
}
