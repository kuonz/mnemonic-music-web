import 'package:flutter/material.dart';
import 'package:mnemonic_music_web/pages/index.dart';
import 'package:mnemonic_music_web/pages/login.dart';

final Map<String, Function> routes = {
  "/index": (BuildContext context, {Object arguments}) => IndexPage(arguments: arguments),
  "/login": (BuildContext context, {Object arguments}) => Login(arguments: arguments)
};

Route onGenerateRoute(RouteSettings settings) {
  final String routeName = settings.name;
  final Function routeController = routes[routeName];
  final Object routeArguments = settings.arguments;

  Route route;

  if (routeController != null) {
    route = MaterialPageRoute(
      builder: (context) => routeController(context, arguments: routeArguments)
    );
  }

  return route;
}