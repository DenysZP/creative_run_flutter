import 'package:creative_run/ui/details/details_screen.dart';
import 'package:creative_run/ui/main/main_screen.dart';
import 'package:creative_run/ui/search/search.dart';
import 'package:creative_run/ui/splash/splash_screen.dart';
import 'package:flutter/material.dart';

const String splash = "splash";
const String home = "home";
const String search = "search";
const String details = "details";

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case splash:
      return _splashRoute();
    case home:
      return MaterialPageRoute(builder: (context) => MainScreen());
    case search:
      return MaterialPageRoute(builder: (context) => SearchScreen());
    case details:
      return MaterialPageRoute(builder: (context) => DetailsScreen(settings.arguments));
    default:
      return _splashRoute();
  }
}

Route<SplashScreen> _splashRoute() =>
    MaterialPageRoute(builder: (context) => SplashScreen());
