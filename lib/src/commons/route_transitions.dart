// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class RouteTransition {
  RouteTransition(this.context);
  BuildContext context;

  Route slideTransition(Widget page, Offset offset) {
    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 200),
      reverseTransitionDuration: Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) {
        return page;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = offset;
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
