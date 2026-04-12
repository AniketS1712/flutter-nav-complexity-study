import 'package:flutter/material.dart';

class RouteConfiguration {
  final bool isUnknown;

  RouteConfiguration.unknown() : isUnknown = true;
  RouteConfiguration.home() : isUnknown = false;
}

class AppRouteInformationParser extends RouteInformationParser<RouteConfiguration> {
  @override
  Future<RouteConfiguration> parseRouteInformation(RouteInformation routeInformation) async {
    return RouteConfiguration.home();
  }
}
