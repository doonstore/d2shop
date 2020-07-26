import 'package:flutter/material.dart';

import 'package:d2shop/state/application_state.dart';
import 'package:d2shop/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:d2shop/screens/home_page.dart';

void main() => runApp(DoonStoreApp());

class DoonStoreApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ApplicationState>(
      create: (context) => ApplicationState(),
      child: MaterialApp(
        title: 'DoonStore',
        home: HomePage(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          bottomSheetTheme: BottomSheetThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          dialogTheme: DialogTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          cardTheme: CardTheme(
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          buttonTheme: ButtonThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          platform: TargetPlatform.android,
        ),
      ),
    );
  }
}
