import 'package:d2shop/state/application_state.dart';
import 'package:d2shop/utils/constants.dart';
import 'package:d2shop/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CalenderWidget extends StatelessWidget {
  const CalenderWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: (context, value, child) => Container(
        color: kPrimaryColor.withOpacity(0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  DateTime dateTime = DateTime.now().add(Duration(days: index));
                  String date = DateFormat.MEd().format(dateTime);

                  bool selectedValue = value.deliveryDate.day == dateTime.day;

                  return GestureDetector(
                    onTap: () {
                      value.setDeliveryDate(
                        DateTime.now().add(Duration(days: index)),
                      );
                      Utils.showMessage('Delivery Date: $date', basic: true);
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin:
                          selectedValue ? EdgeInsets.all(4) : EdgeInsets.zero,
                      decoration: BoxDecoration(
                        color: selectedValue
                            ? kPrimaryColor
                            : kPrimaryColor.withOpacity(0.1),
                        borderRadius: selectedValue
                            ? BorderRadius.circular(8)
                            : BorderRadius.zero,
                      ),
                      width: width(context) * 0.14,
                      child: Center(
                        child: Text(
                          date,
                          style: GoogleFonts.stylish(
                            fontSize: selectedValue ? 19.sp : 16.sp,
                            color: selectedValue ? Colors.white : Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                },
                itemCount: 7,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 15),
              child: Text(
                'Noting scheduled for tomorrow',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: kPrimaryColor.withOpacity(0.7),
                    child: FaIcon(
                      FontAwesomeIcons.plus,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Add item',
                    style: GoogleFonts.ptSans(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor.withOpacity(0.7),
                      letterSpacing: 1.1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
