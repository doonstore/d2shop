import 'dart:ui';

import 'package:d2shop/screens/home_page.dart';
import 'package:d2shop/state/application_state.dart';
import 'package:d2shop/utils/route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:d2shop/models/doonstore_user.dart';
import 'package:d2shop/utils/constants.dart';
import 'package:d2shop/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class UserInput extends StatefulWidget {
  final DoonStoreUser doonStoreUser;
  final bool isSettingUp;

  const UserInput({@required this.doonStoreUser, this.isSettingUp = false});

  @override
  _UserInputState createState() => _UserInputState();
}

class _UserInputState extends State<UserInput> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name, _phoneNumber, _emailAddress;
  bool enabled = false;

  @override
  Widget build(BuildContext context) {
    if (widget.isSettingUp)
      return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(title: Text('Profile Setup')),
        body: Column(
          children: [Spacer(), mainWidget()],
        ),
      );
    else
      return Material(
        animationDuration: Duration(milliseconds: 150),
        borderRadius: BorderRadius.circular(20),
        child: mainWidget(),
      );
  }

  updateChanges(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      DoonStoreUser user = widget.doonStoreUser;
      user.displayName = _name;
      user.email = _emailAddress;
      user.phone = _phoneNumber;

      Utils.showMessage('User Profile has been successfully updated.');

      Provider.of<ApplicationState>(context, listen: false).setUser(user);

      await userRef
          .document(widget.doonStoreUser.userId)
          .updateData(user.toMap())
          .then((value) {
        if (widget.isSettingUp)
          MyRoute.push(context, HomePage(), replaced: true);
        else
          Navigator.pop(context);
      });
    }
  }

  Widget mainWidget() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile Details',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              initialValue: widget.doonStoreUser?.displayName ?? '',
              decoration: Utils.inputDecoration(
                'Full Name',
                icon: FaIcon(FontAwesomeIcons.user),
              ),
              textCapitalization: TextCapitalization.words,
              validator: (value) => value.trim().isEmpty
                  ? 'The name field cannot be empty.'
                  : null,
              onSaved: (newValue) => _name = newValue.trim(),
              style: Utils.formTextStyle(),
              onChanged: (value) => value != widget.doonStoreUser.displayName
                  ? this.setState(() {
                      enabled = true;
                    })
                  : this.setState(() {
                      enabled = false;
                    }),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              initialValue: widget.doonStoreUser?.email ?? '',
              decoration: Utils.inputDecoration(
                'Email Address',
                icon: FaIcon(FontAwesomeIcons.envelope),
              ),
              validator: (value) => !value.contains('.com')
                  ? 'Please enter a valid email address.'
                  : null,
              keyboardType: TextInputType.emailAddress,
              onSaved: (newValue) => _emailAddress = newValue.trim(),
              onChanged: (value) => value != widget.doonStoreUser.email
                  ? this.setState(() {
                      enabled = true;
                    })
                  : this.setState(() {
                      enabled = false;
                    }),
              style: Utils.formTextStyle(),
            ),
            SizedBox(height: 10.0),
            // Container(
            //   color: Colors.grey[200],
            //   child: Text(_phoneNumber),
            // ),
            GestureDetector(
              onTap: () => Fluttertoast.showToast(
                  msg: 'You cannot edit the contact number.'),
              child: TextFormField(
                initialValue: widget.doonStoreUser?.phone ?? '',
                enabled: false,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  filled: true,
                  icon: FaIcon(FontAwesomeIcons.phoneAlt),
                  fillColor: Colors.grey[200],
                ),
                onSaved: (newValue) => _phoneNumber = newValue.trim(),
                style: Utils.formTextStyle(),
              ),
            ),
            SizedBox(height: 12),
            RichText(
              text: TextSpan(
                text: 'To change your phone number, ',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black45,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  TextSpan(
                    text: 'contact us',
                    style: TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()..onTap = contactUs,
                  )
                ],
              ),
            ),
            SizedBox(height: 15),
            Utils.basicBtn(
              context,
              text: 'Update Details',
              onTap: enabled ? () => updateChanges(context) : null,
            ),
          ],
        ),
      ),
    );
  }

  contactUs() async {
    if (await canLaunch('mailto:test@gmail.com')) {
      launch('mailto:test@gmail.com');
    }
  }
}
