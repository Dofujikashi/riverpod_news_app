import 'package:flutter/material.dart';
import 'package:riverpod_news_app/screens/search_results_screen.dart';

PageRouteBuilder getPageRoute(bool isComingFromSearchHistory) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => SearchResultsScreen(
      isComingFromSearchHistory: isComingFromSearchHistory,
    ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}
