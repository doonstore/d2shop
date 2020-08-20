import 'package:d2shop/models/doonstore_user.dart';
import 'package:d2shop/state/application_state.dart';
import 'package:d2shop/utils/constants.dart';
import 'package:d2shop/utils/utils.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  final DoonStoreUser doonStoreUser;
  const AddressScreen({@required this.doonStoreUser});
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<String> itemList =
      List<String>.generate(10, (index) => 'Apartment #$index');

  String _apartment, _block, _houseNo;
  int addressType = 0;

  void submit() {
    if (_apartment != null) {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();

        DoonStoreUser user =
            Provider.of<ApplicationState>(context, listen: false).user;
        Map<String, dynamic> address = {
          'Apartment': _apartment,
          'Block': _block,
          'House No': _houseNo
        };

        widget.doonStoreUser.address = address;

        userRef.document(user.userId).updateData(user.toMap()).then((value) {
          Utils.showMessage('Your address has been successfully updated');
          Provider.of<ApplicationState>(context, listen: false).setUser(user);
          Navigator.pop(context);
        });
      }
    } else
      Utils.showMessage('Please select apartment', error: true);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      child: mainWidget(),
    );
  }

  Widget mainWidget() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Residency Type',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                residentalTypeChooser(addressType == 0, 0, 'Apartment'),
                SizedBox(width: 4),
                residentalTypeChooser(addressType == 1, 1, 'Individual House')
              ],
            ),
            SizedBox(height: 15),
            DropdownSearch<String>(
              hint: 'Apartment / Society',
              label: 'Apartment / Society',
              showSearchBox: true,
              items: itemList,
              searchBoxDecoration: Utils.inputDecoration('Search..', hint: ''),
              validator: (value) =>
                  value == null ? 'Please select a value' : null,
              onSaved: (newValue) => _apartment = newValue,
              onChanged: (value) => _apartment = value,
              selectedItem: _apartment ?? '--Select--',
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: widget.doonStoreUser.address.isNotEmpty
                        ? getAddress(widget.doonStoreUser.address)[1]
                        : '',
                    decoration: Utils.inputDecoration('Tower / Block'),
                    style: Utils.formTextStyle(),
                    validator: (value) =>
                        value.trim().isEmpty ? 'This field is required.' : null,
                    onSaved: (newValue) => _block = newValue.trim(),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    initialValue: widget.doonStoreUser.address.isNotEmpty
                        ? getAddress(widget.doonStoreUser.address)[2]
                        : '',
                    decoration: Utils.inputDecoration('Flat / House No.'),
                    style: Utils.formTextStyle(),
                    validator: (value) =>
                        value.trim().isEmpty ? 'This field is required.' : null,
                    onSaved: (newValue) => _houseNo = newValue.trim(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Utils.basicBtn(context, text: 'Confirm', onTap: submit)
          ],
        ),
      ),
    );
  }

  Expanded residentalTypeChooser(bool condition, int value, String text) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (value == 1)
            Utils.showMessage("Feature not available.", basic: true);
        },
        child: Material(
          animationDuration: Duration(milliseconds: 150),
          elevation: condition ? 8 : 0,
          color: value == 0 ? kPrimaryColor : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            height: 50,
            child: Center(
              child: Text(
                text,
                style: GoogleFonts.oxygen(
                  fontWeight: FontWeight.w800,
                  color: value == 0 ? Colors.white : Colors.black,
                  fontSize: 15.sp,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
