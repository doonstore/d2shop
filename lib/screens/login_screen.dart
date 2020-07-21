import 'package:flutter/material.dart';

import 'package:d2shop/components/gallery_page.dart';
import 'package:d2shop/config/authentication.dart';
import 'package:d2shop/models/doonstore_user.dart';
import 'package:d2shop/utils/constants.dart';
import 'package:d2shop/utils/route.dart';
import 'package:d2shop/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController numberTEC = TextEditingController();

  bool isLoading = false, isTyping = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Container(
          width: width(context),
          height: height(context),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              headContainer(context),
              phoneVerificationArea(),
              sendOTPButton(),
              divider(),
              SizedBox(height: 5),
              GoogleSignInButton()
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

  Widget sendOTPButton() {
    if (isLoading)
      return Utils.loadingWidget(context);
    else
      return Container(
        width: width(context) * 0.90,
        child: ElevatedButton.icon(
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
          icon: Text('Send OTP'),
          label: FaIcon(FontAwesomeIcons.comment, size: 30),
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(vertical: 5),
            ),
          ),
        ),
      );
  }

  Container phoneVerificationArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
          SizedBox(height: 10),
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
            onTap: () {
              setState(() {
                isTyping = true;
              });
            },
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

  Flexible headContainer(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipPath(
          clipper: isTyping ? null : BackgroundClipper(),
          child: AnimatedContainer(
            duration: Duration(seconds: 1),
            width: width(context),
            padding: EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal[300], Colors.teal],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
              borderRadius: isTyping ? BorderRadius.circular(18) : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    'assets/category/2.png',
                    width: width(context) * (isTyping ? 0.40 : 0.80),
                  ),
                ),
                Text(
                  'Sample Heading #1',
                  style: GoogleFonts.montserrat(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Sample Description #1',
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
      ),
    );
  }
}

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context) * 0.90,
      child: OutlineButton.icon(
        onPressed: () {
          signInWithGoogle().then((DoonStoreUser user) {
            Utils.showMessage('Welcome back, ${user.displayName}');
            MyRoute.push(context, GalleryPage());
          });
        },
        highlightColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        padding: EdgeInsets.symmetric(vertical: 7),
        icon: Image.asset('assets/google_logo.png', height: 30, width: 30),
        label: Text('Sign in using Google'),
      ),
    );
  }
}

class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double roundnessFactor = 20.0;

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
    path.lineTo(size.width, roundnessFactor + 20);

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
