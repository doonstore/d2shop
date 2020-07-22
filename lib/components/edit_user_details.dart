import 'package:d2shop/models/doonstore_user.dart';
import 'package:d2shop/utils/constants.dart';
import 'package:d2shop/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditUserDetails {
  final DoonStoreUser doonStoreUser;

  EditUserDetails({this.doonStoreUser});

  String _name, _email, _phoneNumber;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  mainBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 25.0),
                Column(
                  children: <Widget>[
                    Text(
                      "Profile Details",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  initialValue: doonStoreUser.displayName ?? '',
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    hintText: "Enter your name",
                    icon: FaIcon(FontAwesomeIcons.user),
                    border: InputBorder.none,
                  ),
                  validator: (value) => value.trim().isEmpty
                      ? 'The name field cannot be empty.'
                      : null,
                  onSaved: (newValue) => _name = newValue.trim(),
                ),
                TextFormField(
                  initialValue: doonStoreUser.email ?? '',
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                    hintText: "Enter your email address",
                    icon: FaIcon(FontAwesomeIcons.envelope),
                    border: InputBorder.none,
                  ),
                  validator: (value) => !value.contains('.com')
                      ? 'Please enter a valid email address.'
                      : null,
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (newValue) => _email = newValue.trim(),
                ),
                TextFormField(
                  initialValue: doonStoreUser.phone ?? '',
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    hintText: "Enter your number",
                    icon: FaIcon(FontAwesomeIcons.phoneAlt),
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      !RegExp('[6-9]{1}[0-9]{9}').hasMatch(value)
                          ? 'Please enter a valid number.'
                          : null,
                  onSaved: (newValue) => _phoneNumber = newValue.trim(),
                ),
                Container(
                  width: width(context) * 0.90,
                  height: 50,
                  child: MaterialButton(
                    onPressed: () => updateChanges(context),
                    child: Text(
                      'Update Details',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                      ),
                    ),
                    color: kPrimaryColor,
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  updateChanges(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      Utils.showMessage('Please Wait..');

      doonStoreUser.email = _email;
      doonStoreUser.displayName = _name;
      doonStoreUser.phone = _phoneNumber;

      await userRef
          .document(doonStoreUser.userId)
          .updateData(doonStoreUser.toMap());
      Navigator.pop(context);
    }
  }
}
