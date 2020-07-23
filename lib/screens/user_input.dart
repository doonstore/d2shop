import 'dart:ui';

import 'package:d2shop/state/application_state.dart';
import 'package:flutter/material.dart';
import 'package:d2shop/models/doonstore_user.dart';
import 'package:d2shop/utils/constants.dart';
import 'package:d2shop/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class UserInput extends StatefulWidget {
  final DoonStoreUser doonStoreUser;

  const UserInput({@required this.doonStoreUser});

  @override
  _UserInputState createState() => _UserInputState();
}

class _UserInputState extends State<UserInput> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name, _phoneNumber, _emailAddress;
  bool enabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Image.asset('assets/images/login.png', fit: BoxFit.cover),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                border: Border.all(
                  color: kPrimaryColor,
                  width: 2,
                ),
              ),
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
                      onChanged: (value) =>
                          value != widget.doonStoreUser.displayName
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
                    TextFormField(
                      initialValue: widget.doonStoreUser?.phone ?? '',
                      enabled: false,
                      decoration: Utils.inputDecoration(
                        'Phone Number',
                        icon: FaIcon(FontAwesomeIcons.phoneAlt),
                      ),
                      onSaved: (newValue) => _phoneNumber = newValue.trim(),
                      style: Utils.formTextStyle(),
                    ),
                    SizedBox(height: 15),
                    Container(
                      width: width(context) * 0.90,
                      height: 50,
                      child: RaisedButton(
                        onPressed:
                            enabled ? () => updateChanges(context) : null,
                        disabledColor: Colors.grey.shade300,
                        textColor: Colors.white,
                        disabledTextColor: Colors.black,
                        animationDuration: Duration(milliseconds: 300),
                        child: Text(
                          'Update Details',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        color: kPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
          .then((value) => Navigator.pop(context));
    }
  }
}
