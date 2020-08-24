import 'package:d2shop/config/firestore_services.dart';
import 'package:d2shop/models/apartment_model.dart';
import 'package:d2shop/models/doonstore_user.dart';
import 'package:d2shop/state/application_state.dart';
import 'package:d2shop/utils/constants.dart';
import 'package:d2shop/utils/strings.dart';
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

  List<String> apartmentList;

  String _apartment, _block, _houseNo;
  int addressType = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    List<ApartmentModel> _list = await FirestoreServices().apartments;
    if (_list != null && _list.length > 1)
      setState(() {
        apartmentList = _list.map((e) => e.value).toList();
      });
    else
      apartmentList = ["Dummy Data"];
  }

  void submit() {
    if (_apartment != null) {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();

        DoonStoreUser user =
            Provider.of<ApplicationState>(context, listen: false).user;

        widget.doonStoreUser.address =
            addressToJson(_apartment, _block, _houseNo);

        userRef.document(user.userId).updateData(user.toMap()).then((value) {
          Utils.showMessage('Your address has been successfully updated');
          Provider.of<ApplicationState>(context, listen: false).setUser(user);
          Navigator.pop(context);
        });
      }
    } else
      Utils.showMessage('Please select an apartment', error: true);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.residencyType,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  residentalTypeChooser(addressType == 0, 0, Strings.apartment),
                  SizedBox(width: 4),
                  residentalTypeChooser(addressType == 1, 1, Strings.house)
                ],
              ),
              SizedBox(height: 15),
              DropdownSearch<String>(
                hint: Strings.apartmentOrSociety,
                label: Strings.apartmentOrSociety,
                showSearchBox: true,
                items: apartmentList,
                searchBoxDecoration:
                    Utils.inputDecoration('Search..', hint: ''),
                validator: (value) =>
                    value == null ? Strings.selectValue : null,
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
                      decoration: Utils.inputDecoration(Strings.towerOrBlock),
                      style: Utils.formTextStyle(),
                      validator: (value) =>
                          value.trim().isEmpty ? Strings.fieldRequired : null,
                      onSaved: (newValue) => _block = newValue.trim(),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      initialValue: widget.doonStoreUser.address.isNotEmpty
                          ? getAddress(widget.doonStoreUser.address)[2]
                          : '',
                      decoration: Utils.inputDecoration(Strings.flatOrHouse),
                      style: Utils.formTextStyle(),
                      validator: (value) =>
                          value.trim().isEmpty ? Strings.fieldRequired : null,
                      onSaved: (newValue) => _houseNo = newValue.trim(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Utils.basicBtn(context, text: Strings.confirm, onTap: submit)
            ],
          ),
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
                  fontWeight: FontWeight.w600,
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
