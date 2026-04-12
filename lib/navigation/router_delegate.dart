import 'package:flutter/material.dart';
import 'package:nav_complexit_ystudy/screens/login_screen.dart';
import 'package:nav_complexit_ystudy/screens/dashboard_screen.dart';
import 'route_parser.dart';

class AppRouterDelegate extends RouterDelegate<RouteConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RouteConfiguration> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  bool _isLoggedIn = false;

  AppRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  bool get isLoggedIn => _isLoggedIn;

  void login() {
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        if (!_isLoggedIn)
          const MaterialPage(
            key: ValueKey('LoginScreen'),
            child: LoginScreen(),
          )
        else
          MaterialPage(
            key: const ValueKey('DashboardScreen'),
            child: DashboardScreen(),
          ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(RouteConfiguration configuration) async {}
}
