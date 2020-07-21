import 'package:d2shop/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(DoonStoreApp());

class DoonStoreApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DoonStore',
      home: LoginScreen(),
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.white,
        dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
