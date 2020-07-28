import 'dart:ui';

import 'package:d2shop/components/address_screnn.dart';
import 'package:d2shop/helper/edit_user_prefernces.dart';
import 'package:d2shop/config/shared_services.dart';
import 'package:d2shop/helper/user_input.dart';
import 'package:d2shop/models/doonstore_user.dart';
import 'package:flutter/material.dart';
import 'package:d2shop/config/authentication.dart';
import 'package:d2shop/state/application_state.dart';
import 'package:d2shop/utils/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  double _value = 1.0;

  bool doorBellSetting = false, whatsAppNotification = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    doorBellSetting = await SharedService.doorBellSetting;
    whatsAppNotification = await SharedService.whatsappNotificationSettings;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: _value == 0.3
                ? kPrimaryColor.withOpacity(0.220)
                : kPrimaryColor.withOpacity(0.7),
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
          body: AnimatedOpacity(
            opacity: _value,
            duration: Duration(milliseconds: 300),
            child: IgnorePointer(
              ignoring: _value == 0.3,
              child: SingleChildScrollView(
                child: Builder(
                  builder: (context) => Column(
                    children: [
                      AccountSectionHeader(),
                      SizedBox(height: 10),
                      AccountSectionCards(
                        title: 'Profile Details',
                        subtitle:
                            '${value.user.displayName.isNotEmpty ? value.user.displayName + ',' : ''} ${value.user.phone}\n${value.user.email}',
                        leadingIcon: FontAwesomeIcons.userCheck,
                        onTapCallback: () {
                          showBottomSheet(
                            context: context,
                            builder: (context) =>
                                UserInput(doonStoreUser: value.user),
                          );
                        },
                        isThreeLine: value.user.email.isNotEmpty,
                      ),
                      Divider(color: Colors.black12, indent: 5, endIndent: 5),
                      AccountSectionCards(
                        title: 'My Address',
                        subtitle: value.user.address != null
                            ? '${getAddress(value.user.address)[0]}\n${getAddress(value.user.address)[1]}, ${getAddress(value.user.address)[2]}'
                            : 'No address',
                        leadingIcon: FontAwesomeIcons.locationArrow,
                        onTapCallback: () {
                          showBottomSheet(
                            context: context,
                            builder: (context) =>
                                AddressScreen(doonStoreUser: value.user),
                          );
                        },
                      ),
                      Divider(color: Colors.black12, indent: 5, endIndent: 5),
                      AccountSectionCards(
                        title: 'Wallet',
                        subtitle: '\u20b90 Balance',
                        leadingIcon: FontAwesomeIcons.rupeeSign,
                      ),
                      Divider(color: Colors.black12, indent: 5, endIndent: 5),
                      AccountSectionCards(
                        title: 'Doorbell Settings',
                        subtitle: doorBellSetting
                            ? 'Ring the bell'
                            : 'Do not ring the doorbell.',
                        leadingIcon: doorBellSetting
                            ? FontAwesomeIcons.bell
                            : FontAwesomeIcons.bellSlash,
                        onTapCallback: () async {
                          setState(() {
                            _value = 0.3;
                          });
                          bool val = await SharedService.doorBellSetting;
                          var controller = showBottomSheet(
                            context: context,
                            builder: (context) => EditUserPrefernces(
                              value: val ? 1 : 0,
                              type: PreferncesType.DoorBell,
                            ),
                          );
                          controller.closed.then((value) => this.setState(() {
                                _value = 1.0;
                              }));
                        },
                      ),
                      Divider(color: Colors.black12, indent: 5, endIndent: 5),
                      AccountSectionCards(
                        title: 'WhatsApp Notification',
                        subtitle: whatsAppNotification
                            ? 'Recieve updates on WhatsApp'
                            : 'Do not send updates on WhatsApp',
                        leadingIcon: FontAwesomeIcons.whatsapp,
                        onTapCallback: () async {
                          setState(() {
                            _value = 0.3;
                          });
                          bool val =
                              await SharedService.whatsappNotificationSettings;
                          var controller = showBottomSheet(
                            context: context,
                            builder: (context) => EditUserPrefernces(
                              value: val ? 1 : 0,
                              type: PreferncesType.WhatsApp,
                            ),
                          );
                          controller.closed.then((value) => this.setState(() {
                                _value = 1.0;
                              }));
                        },
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
              ),
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
