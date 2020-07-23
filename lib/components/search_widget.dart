import 'package:d2shop/components/category_explorer.dart';
import 'package:d2shop/utils/constants.dart';
import 'package:d2shop/utils/route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => MyRoute.push(context, CategoryExplorer()),
      child: Container(
        width: width(context),
        color: kPrimaryColor,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What can we get you?',
              style: GoogleFonts.ptSans(
                fontSize: 18.sp,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 5),
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.search,
                      color: kPrimaryColor.withOpacity(0.7),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Search for milk & groceries...',
                      style: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
