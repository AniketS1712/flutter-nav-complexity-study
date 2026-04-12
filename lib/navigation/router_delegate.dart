import 'package:flutter/material.dart';
import 'package:nav_complexit_ystudy/screens/login_screen.dart';
import 'package:nav_complexit_ystudy/screens/dashboard_screen.dart';
import 'route_parser.dart';

class AppRouterDelegate extends RouterDelegate<RouteConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RouteConfiguration> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  bool _isLoggedIn = false;
  int _selectedTab = 0;

  AppRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  bool get isLoggedIn => _isLoggedIn;
  int get selectedTab => _selectedTab;

  void login() {
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }

  void setTab(int index) {
    _selectedTab = index;
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
            child: DashboardScreen(
              selectedIndex: _selectedTab,
              onTabSelected: setTab,
            ),
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
