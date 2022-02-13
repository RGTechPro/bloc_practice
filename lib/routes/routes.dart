import 'package:bloc_practice/screens/home_page.dart';
import 'package:bloc_practice/screens/second_screen.dart';
import 'package:bloc_practice/screens/third_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  Route onGenerateRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => MyHomePage(title: 'First Screen'));
      
      case '/second':
        return MaterialPageRoute(
            builder: (_) => SecondScreen(title: 'Second Screen'));
       
      case '/third':
        return MaterialPageRoute(
            builder: (_) => ThirdScreen(title: 'Third Screen'));
      default:
        return   MaterialPageRoute(
            builder: (_) => Container());
    }
  }
}
