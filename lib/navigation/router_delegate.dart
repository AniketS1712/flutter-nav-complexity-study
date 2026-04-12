import 'package:flutter/material.dart';
import 'package:nav_complexit_ystudy/screens/login_screen.dart';
import 'package:nav_complexit_ystudy/screens/dashboard_screen.dart';
import 'package:nav_complexit_ystudy/screens/project_details_screen.dart';
import 'package:nav_complexit_ystudy/screens/task_detail_screen.dart';
import 'route_parser.dart';

class AppRouterDelegate extends RouterDelegate<RouteConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RouteConfiguration> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  bool _isLoggedIn = false;
  int _selectedTab = 0;
  String? _selectedProjectId;
  String? _selectedTaskId;

  AppRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  bool get isLoggedIn => _isLoggedIn;
  int get selectedTab => _selectedTab;
  String? get selectedProjectId => _selectedProjectId;
  String? get selectedTaskId => _selectedTaskId;

  void login() {
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    _selectedProjectId = null;
    _selectedTaskId = null;
    notifyListeners();
  }

  void setTab(int index) {
    _selectedTab = index;
    notifyListeners();
  }

  void selectProject(String id) {
    _selectedProjectId = id;
    notifyListeners();
  }

  void selectTask(String id) {
    _selectedTaskId = id;
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
        else ...[
          MaterialPage(
            key: const ValueKey('DashboardScreen'),
            child: DashboardScreen(
              selectedIndex: _selectedTab,
              onTabSelected: setTab,
            ),
          ),
          if (_selectedProjectId != null)
            MaterialPage(
              key: ValueKey('ProjectDetailsScreen-$_selectedProjectId'),
              child: ProjectDetailsScreen(projectName: 'Project $_selectedProjectId'),
            ),
          if (_selectedTaskId != null)
            MaterialPage(
              key: ValueKey('TaskDetailScreen-$_selectedTaskId'),
              child: const TaskDetailScreen(),
            ),
        ]
      ],
      // ignore: deprecated_member_use
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        if (_selectedTaskId != null) {
          _selectedTaskId = null;
          notifyListeners();
          return true;
        }
        if (_selectedProjectId != null) {
          _selectedProjectId = null;
          notifyListeners();
          return true;
        }
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(RouteConfiguration configuration) async {
    if (!_isLoggedIn) {
       _selectedProjectId = null;
       _selectedTaskId = null;
       return;
    }
    
    if (configuration.projectId != null) {
      _selectedProjectId = configuration.projectId;
      _selectedTaskId = null;
    } else if (configuration.taskId != null) {
      _selectedTaskId = configuration.taskId;
      _selectedProjectId = null;
    } else {
      _selectedProjectId = null;
      _selectedTaskId = null;
    }
  }

  @override
  RouteConfiguration? get currentConfiguration {
    if (!_isLoggedIn) return RouteConfiguration.login();
    if (_selectedTaskId != null) return RouteConfiguration.task(_selectedTaskId);
    if (_selectedProjectId != null) return RouteConfiguration.project(_selectedProjectId);
    return RouteConfiguration.home();
  }
}
