import 'package:d2shop/screens/my_account.dart';
import 'package:d2shop/screens/view_transactions.dart';
import 'package:d2shop/screens/wallet_screen.dart';
import 'package:d2shop/state/application_state.dart';
import 'package:d2shop/utils/route.dart';
import 'package:d2shop/utils/strings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:d2shop/utils/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: (context, value, child) {
        return Container(
          width: width(context) * 0.80,
          height: height(context),
          color: Colors.white,
          child: SafeArea(
            child: Column(
              children: [
                userProfileHeader(context, value.user?.displayName ?? 'Guest'),
                Divider(
                  color: Colors.black54,
                  indent: 10,
                  endIndent: 10,
                ),
                dataCard(
                  title: Strings.walletBalance,
                  iconData: FontAwesomeIcons.wallet,
                  onTapCallback: () =>
                      MyRoute.push(context, WalletScreen(fromCart: true)),
                  trailing:
                      tralingContainer('$rupeeUniCode ${value.user.wallet}'),
                ),
                dataCard(
                  title: Strings.walletTransactions,
                  iconData: FontAwesomeIcons.history,
                  onTapCallback: () => MyRoute.push(
                    context,
                    ViewTransactions(),
                  ),
                ),
                dataCard(
                  title: Strings.notifications,
                  iconData: FontAwesomeIcons.bell,
                  onTapCallback: () {},
                ),
                dataCard(
                  title: Strings.referAndSave,
                  iconData: FontAwesomeIcons.shareAlt,
                  onTapCallback: () {},
                  trailing: tralingContainer('Code'),
                ),
                dataCard(
                  title: Strings.supportAndFaq,
                  iconData: FontAwesomeIcons.questionCircle,
                  onTapCallback: () {},
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget userProfileHeader(BuildContext context, String name) {
    return ListTile(
      onTap: () => MyRoute.push(context, AccountScreen()),
      leading: FaIcon(FontAwesomeIcons.user, color: kPrimaryColor),
      title: Text(
        name,
        style: GoogleFonts.openSans(
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: FaIcon(FontAwesomeIcons.chevronRight, size: 20),
    );
  }

  Widget dataCard(
      {String title,
      IconData iconData,
      Function onTapCallback,
      Widget trailing}) {
    return ListTile(
      onTap: onTapCallback,
      leading: FaIcon(
        iconData,
        color: kPrimaryColor.withOpacity(0.8),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.1,
        ),
      ),
      trailing: trailing,
    );
  }

  Material tralingContainer(String text) {
    return Material(
      color: kPrimaryColor,
      shape: StadiumBorder(),
      animationDuration: Duration(milliseconds: 300),
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 13.sp,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}
