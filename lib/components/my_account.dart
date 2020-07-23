import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:d2shop/config/authentication.dart';
import 'package:d2shop/screens/user_input.dart';
import 'package:d2shop/state/application_state.dart';
import 'package:d2shop/utils/constants.dart';
import 'package:d2shop/utils/route.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimaryColor.withOpacity(0.7),
            elevation: 0.0,
            centerTitle: true,
            title: Text(
              'My Account',
              style: TextStyle(
                fontSize: 20.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                AccountSectionHeader(),
                SizedBox(height: 10),
                AccountSectionCards(
                  title: 'Profile Details',
                  subtitle:
                      '${value.user.displayName.isNotEmpty ? value.user.displayName + ',' : ''} ${value.user.phone}\n${value.user.email}',
                  leadingIcon: FontAwesomeIcons.userCheck,
                  onTapCallback: () {
                    MyRoute.push(context, UserInput(doonStoreUser: value.user));
                  },
                  isThreeLine: value.user.email.isNotEmpty,
                ),
                Divider(color: Colors.black12, indent: 5, endIndent: 5),
                AccountSectionCards(
                  title: 'My Address',
                  subtitle: 'No address',
                  leadingIcon: FontAwesomeIcons.locationArrow,
                  onTapCallback: () {},
                ),
                Divider(color: Colors.black12, indent: 5, endIndent: 5),
                AccountSectionCards(
                  title: 'Super Wallet',
                  subtitle: '\u20b90 Balance',
                  leadingIcon: FontAwesomeIcons.rupeeSign,
                ),
                Divider(color: Colors.black12, indent: 5, endIndent: 5),
                AccountSectionCards(
                  title: 'Doorbell Settings',
                  subtitle: 'Do not ring the doorbell.',
                  leadingIcon: FontAwesomeIcons.bellSlash,
                  onTapCallback: () {},
                ),
                Divider(color: Colors.black12, indent: 5, endIndent: 5),
                AccountSectionCards(
                  title: 'WhatsApp Notification',
                  subtitle: 'Do not send updates on WhatsApp',
                  leadingIcon: FontAwesomeIcons.whatsapp,
                  onTapCallback: () {},
                ),
                Divider(color: Colors.black12, indent: 5, endIndent: 5),
                AccountSectionCards(
                  title: 'Privacy Policy',
                  leadingIcon: FontAwesomeIcons.infoCircle,
                  onTapCallback: () async {
                    final String url = 'https:www.google.com';
                    if (await canLaunch(url)) launch(url);
                  },
                ),
                Divider(color: Colors.black12, indent: 5, endIndent: 5),
                AccountSectionCards(
                  title: 'Content Policy',
                  leadingIcon: FontAwesomeIcons.infoCircle,
                  onTapCallback: () async {
                    final String url = 'https:www.google.com';
                    if (await canLaunch(url)) launch(url);
                  },
                ),
                Divider(color: Colors.black12, indent: 5, endIndent: 5),
                AccountSectionCards(
                  title: 'Logout',
                  leadingIcon: FontAwesomeIcons.signOutAlt,
                  onTapCallback: () => signOut(context),
                ),
                Divider(color: Colors.black12, indent: 5, endIndent: 5)
              ],
            ),
          ),
        );
      },
    );
  }
}

class AccountSectionHeader extends StatelessWidget {
  const AccountSectionHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApplicationState state = Provider.of<ApplicationState>(context);
    return Container(
      height: height(context) * 0.33,
      width: width(context),
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(0.7),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: width(context) * 0.18,
            backgroundColor: kPrimaryColor.withOpacity(0.7),
            child: Center(
              child: state.user.photoUrl.isEmpty
                  ? FaIcon(
                      FontAwesomeIcons.user,
                      color: Colors.white70,
                      size: width(context) * 0.12,
                    )
                  : Image.network(state.user.photoUrl),
            ),
          ),
          SizedBox(height: 15),
          Text(
            state.user.displayName.isEmpty ? 'Guest' : state.user.displayName,
            style: TextStyle(
              fontSize: 20.sp,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class AccountSectionCards extends StatelessWidget {
  const AccountSectionCards(
      {Key key,
      this.title,
      this.subtitle,
      this.leadingIcon,
      this.onTapCallback,
      this.isThreeLine = false})
      : super(key: key);

  final String title, subtitle;
  final IconData leadingIcon;
  final Function onTapCallback;
  final bool isThreeLine;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
      onTap: onTapCallback,
      leading: FaIcon(
        leadingIcon,
        color: kPrimaryColor.withOpacity(0.7),
      ),
      isThreeLine: isThreeLine,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w700,
          fontSize: 16.sp,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black54,
                fontSize: 13.sp,
              ),
            )
          : null,
      trailing: FaIcon(
        FontAwesomeIcons.chevronRight,
        color: kPrimaryColor.withOpacity(0.7),
      ),
    );
  }
}
