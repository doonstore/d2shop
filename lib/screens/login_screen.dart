import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/authentication.dart';
import '../utils/utils.dart';
import '../utils/constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController numberTEC = TextEditingController();
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              headContainer(
                context,
                heading: 'Sample Heading #1',
                description: 'Sample Description',
              ),
              SizedBox(height: 15),
              phoneVerificationArea(),
              sendOTPButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget sendOTPButton() {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 400),
      transitionBuilder: (child, animation) =>
          FadeTransition(opacity: animation, child: child),
      child: isLoading
          ? Utils.loadingWidget(context)
          : Container(
              width: width(context) * 0.90,
              height: 45,
              margin: EdgeInsets.symmetric(vertical: 7),
              child: MaterialButton(
                elevation: 7,
                onPressed: () {
                  final String number = numberTEC.text;

                  if (number.isNotEmpty && number.length == 10) {
                    if (RegExp('[6-9]{1}[0-9]{9}').hasMatch(number)) {
                      setState(() {
                        isLoading = true;
                      });
                      loginUsingPhoneNumber(context, number);
                    }
                  } else
                    Utils.showMessage(
                      'Please enter a valid phone number',
                      error: true,
                    );
                },
                textColor: Colors.white,
                child: Text('Send OTP'),
                color: Colors.teal,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
    );
  }

  Container phoneVerificationArea() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Login to continue',
            style: GoogleFonts.ptSans(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 15),
          TextFormField(
            controller: numberTEC,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Enter Phone Number',
              hintText: 'Enter your phone number',
              helperText: 'We will send you OTP on this number',
              prefixText: '+91',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              icon: FaIcon(FontAwesomeIcons.phoneAlt),
            ),
            maxLength: 10,
            maxLengthEnforced: true,
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 16.sp,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
            enabled: !isLoading,
          ),
        ],
      ),
    );
  }

  Widget headContainer(BuildContext context,
      {String heading, String description}) {
    return Expanded(
      child: ClipPath(
        clipper: BackgroundClipper(),
        child: Container(
          width: width(context),
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal[300], Colors.teal],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(),
              Expanded(
                flex: 2,
                child: Center(child: Image.asset('assets/category/2.png')),
              ),
              Text(
                heading,
                style: GoogleFonts.montserrat(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row divider() {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.teal,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Text('OR'),
        ),
        Expanded(
          child: Divider(
            color: Colors.teal,
          ),
        ),
      ],
    );
  }
}

class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double roundnessFactor = 30.0;

    path.moveTo(0, size.height * 0.33);
    path.lineTo(0, size.height - roundnessFactor);

    path.quadraticBezierTo(0, size.height, roundnessFactor, size.height);
    path.lineTo(size.width - roundnessFactor, size.height);

    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width,
      size.height - roundnessFactor,
    );
    path.lineTo(size.width, roundnessFactor + 10);

    path.quadraticBezierTo(
      size.width,
      0,
      size.width - roundnessFactor * 2,
      roundnessFactor - 10,
    );
    path.lineTo(roundnessFactor, size.height * 0.33 + 10.0);

    path.quadraticBezierTo(
      0,
      size.height * 0.33 + roundnessFactor,
      0,
      size.height * 0.33 + roundnessFactor * 2,
    );

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
