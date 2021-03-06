import 'package:d2shop/config/shared_services.dart';
import 'package:d2shop/models/doonstore_user.dart';
import 'package:d2shop/state/application_state.dart';
import 'package:d2shop/utils/constants.dart';
import 'package:d2shop/utils/strings.dart';
import 'package:d2shop/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class EditUserPrefernces extends StatefulWidget {
  final int value;
  final PreferncesType type;

  const EditUserPrefernces({@required this.type, this.value});

  @override
  _EditUserPreferncesState createState() => _EditUserPreferncesState();
}

class _EditUserPreferncesState extends State<EditUserPrefernces> {
  int _selectedValue;

  @override
  void initState() {
    _selectedValue = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      color: Colors.white,
      child: Container(
        height: height(context) * 0.30,
        width: width(context),
        padding: EdgeInsets.fromLTRB(15, 25, 15, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              widget.type == PreferncesType.DoorBell
                  ? Strings.doorBell
                  : Strings.whatsApp,
              style: GoogleFonts.oxygen(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    widget.type == PreferncesType.DoorBell
                        ? Strings.shouldWeRingBell
                        : Strings.getUpdatesOnWhatsapp,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      btnChoiceSelector("YES", 1),
                      btnChoiceSelector("NO", 0),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Utils.basicBtn(
                    context,
                    text: 'Update',
                    onTap: widget.value != _selectedValue ? submit : null,
                  ),
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.times),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  submit() {
    bool value = _selectedValue != 0 ? true : false;
    String id = Provider.of<ApplicationState>(context).user.userId;
    if (widget.type == PreferncesType.DoorBell) {
      userRef.document(id).updateData({"doorBellStatus": value});
      SharedService.changeDoorBellSettings(value);
      Utils.showMessage("DoorBell Settings Updated Successfully.");
    } else {
      userRef.document(id).updateData({"whatsAppNotificationSetting": value});
      SharedService.changeWhatsappNotificationSettings(value);
      Utils.showMessage("WhatsApp Setting Updated Successfully.");
    }
    Future.delayed(Duration(milliseconds: 300), () {
      Navigator.pop(context);
    });
  }

  Widget btnChoiceSelector(String text, int value) {
    bool enabled = _selectedValue == value;
    return GestureDetector(
      onTap: () => this.setState(() {
        _selectedValue = value;
      }),
      child: Material(
        animationDuration: Duration(milliseconds: 300),
        borderRadius: BorderRadius.circular(5),
        elevation: enabled ? 10.0 : 0.0,
        color: enabled ? kPrimaryColor : Colors.grey[300],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Text(
            text,
            style: TextStyle(color: enabled ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }
}
