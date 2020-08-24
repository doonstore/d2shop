import 'package:d2shop/components/category_explorer.dart';
import 'package:d2shop/state/application_state.dart';
import 'package:d2shop/utils/constants.dart';
import 'package:d2shop/utils/route.dart';
import 'package:d2shop/utils/strings.dart';
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
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  DateTime dateTime = DateTime.now().add(Duration(days: index));
                  final String date = DateFormat.MEd().format(dateTime);
                  final String day = date.split(',').first;
                  final String dateValue = DateFormat.d().format(dateTime);

                  bool selectedValue = value.deliveryDate.day == dateTime.day;

                  return GestureDetector(
                    onTap: () {
                      if (index == 0)
                        return;
                      else
                        value.setDeliveryDate(
                          DateTime.now().add(Duration(days: index)),
                        );
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 400),
                      margin:
                          selectedValue ? EdgeInsets.all(2) : EdgeInsets.zero,
                      decoration: BoxDecoration(
                        color: selectedValue
                            ? kPrimaryColor
                            : kPrimaryColor.withOpacity(0.1),
                        borderRadius: selectedValue
                            ? BorderRadius.circular(5)
                            : BorderRadius.zero,
                      ),
                      width: width(context) * 0.14,
                      child: Center(
                        child: Text(
                          '$dateValue' +
                              (dateTime.day == DateTime.now().day
                                  ? '\nToday'
                                  : '\n$day'),
                          style: GoogleFonts.ptSans(
                            fontSize: selectedValue ? 15.sp : 13.sp,
                            color:
                                selectedValue ? Colors.white : Colors.black87,
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
                Strings.nothingScheduled,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => MyRoute.push(context, CategoryExplorer()),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Material(
                      shape: CircleBorder(),
                      color: kPrimaryColor,
                      elevation: 4.0,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: FaIcon(
                          FontAwesomeIcons.plus,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      Strings.addItem,
                      style: GoogleFonts.ptSans(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: kPrimaryColor,
                        letterSpacing: 1.1,
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
}
