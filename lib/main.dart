import 'package:d2shop/screens/start_screen.dart';
import 'package:d2shop/themes/theme.dart';
import 'package:flutter/material.dart';

import 'package:d2shop/state/application_state.dart';
import 'package:d2shop/utils/constants.dart';
import 'package:provider/provider.dart';

void main() => runApp(DoonStoreApp());

class DoonStoreApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ApplicationState>(
      create: (context) => ApplicationState(),
      child: MaterialApp(
        title: 'DoonStore',
        home: StartScreen(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          bottomSheetTheme: bottomSheetThemeData,
          dialogTheme: dialogTheme,
          cardTheme: cardTheme,
          buttonTheme: buttonThemeData,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          platform: TargetPlatform.android,
        ),
      ),
    );
  }
}
