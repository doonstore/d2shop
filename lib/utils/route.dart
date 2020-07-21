import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

class MyRoute {
  static Future<void> push(BuildContext context, Widget child,
      {bool replaced = false}) {
    return replaced
        ? Navigator.pushReplacement(context, _builder(child))
        : Navigator.push(context, _builder(child));
  }

  static PageRouteBuilder _builder(Widget child) {
    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeScaleTransition(
        animation: animation,
        child: child,
      ),
    );
  }
}
