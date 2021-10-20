import 'package:c19/Screens/home.dart';
import 'package:c19/Utils/route_side_transition.dart';
import 'package:flutter/material.dart';

class RouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;
    switch(settings.name){
      case '/':
        return RouteSideTransition(widget: const Home(), settings: settings);
      default:
        return RouteSideTransition(widget: Container(), settings: settings);
    }

  }

}