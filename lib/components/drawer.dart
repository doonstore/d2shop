import 'package:d2shop/components/my_account.dart';
import 'package:d2shop/state/application_state.dart';
import 'package:d2shop/utils/route.dart';
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
                  title: 'My Subscriptions',
                  iconData: FontAwesomeIcons.retweet,
                  onTapCallback: () {},
                ),
                dataCard(
                  title: 'Super Wallet',
                  iconData: FontAwesomeIcons.wallet,
                  onTapCallback: () {},
                  trailing: tralingContainer('\u20b9 2'),
                ),
                dataCard(
                    title: 'Wallet Transactions',
                    iconData: FontAwesomeIcons.history,
                    onTapCallback: () {}),
                dataCard(
                  title: 'Refer and Save',
                  iconData: FontAwesomeIcons.shareAlt,
                  onTapCallback: () {},
                  trailing: tralingContainer('Code'),
                ),
                dataCard(
                  title: 'Support & FAQs',
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
        style: GoogleFonts.ptSans(
          fontSize: 17.sp,
          color: Colors.black87,
          fontWeight: FontWeight.w700,
        ),
      ),
      trailing: FaIcon(
        FontAwesomeIcons.chevronRight,
        size: 20,
        color: Colors.black,
      ),
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
          fontWeight: FontWeight.w700,
          letterSpacing: 1.1,
        ),
      ),
      trailing: trailing,
    );
  }

  Container tralingContainer(String text) {
    return Container(
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
