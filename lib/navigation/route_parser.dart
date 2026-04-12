import 'package:flutter/material.dart';

class RouteConfiguration {
  final bool isUnknown;
  final bool isHome;
  final bool isLogin;
  final String? projectId;
  final String? taskId;

  RouteConfiguration.home() : isUnknown = false, isHome = true, isLogin = false, projectId = null, taskId = null;
  RouteConfiguration.login() : isUnknown = false, isHome = false, isLogin = true, projectId = null, taskId = null;
  RouteConfiguration.unknown() : isUnknown = true, isHome = false, isLogin = false, projectId = null, taskId = null;
  RouteConfiguration.project(this.projectId) : isUnknown = false, isHome = false, isLogin = false, taskId = null;
  RouteConfiguration.task(this.taskId) : isUnknown = false, isHome = false, isLogin = false, projectId = null;
}

class AppRouteInformationParser extends RouteInformationParser<RouteConfiguration> {
  @override
  Future<RouteConfiguration> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = routeInformation.uri;

    if (uri.pathSegments.isEmpty) {
      return RouteConfiguration.home();
    }

    if (uri.pathSegments.length == 1) {
      if (uri.pathSegments[0] == 'login') return RouteConfiguration.login();
    }

    if (uri.pathSegments.length == 2) {
      if (uri.pathSegments[0] == 'project') {
        return RouteConfiguration.project(uri.pathSegments[1]);
      }
      if (uri.pathSegments[0] == 'task') {
        return RouteConfiguration.task(uri.pathSegments[1]);
      }
    }

    return RouteConfiguration.unknown();
  }

  @override
  RouteInformation? restoreRouteInformation(RouteConfiguration configuration) {
    if (configuration.isUnknown) {
      return RouteInformation(uri: Uri.parse('/404'));
    }
    if (configuration.isHome) {
      return RouteInformation(uri: Uri.parse('/'));
    }
    if (configuration.isLogin) {
      return RouteInformation(uri: Uri.parse('/login'));
    }
    if (configuration.projectId != null) {
      return RouteInformation(uri: Uri.parse('/project/${configuration.projectId}'));
    }
    if (configuration.taskId != null) {
      return RouteInformation(uri: Uri.parse('/task/${configuration.taskId}'));
    }
    return null;
  }
}
