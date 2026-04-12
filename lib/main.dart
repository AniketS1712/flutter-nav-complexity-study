import 'package:flutter/material.dart';
import 'package:nav_complexit_ystudy/theme/app_theme.dart';
import 'package:nav_complexit_ystudy/navigation/router_delegate.dart';
import 'package:nav_complexit_ystudy/navigation/route_parser.dart';

void main() {
  runApp(TaskFlowApp());
}

class TaskFlowApp extends StatelessWidget {
  final AppRouterDelegate _routerDelegate = AppRouterDelegate();
  final AppRouteInformationParser _routeInformationParser = AppRouteInformationParser();

  TaskFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'TaskFlow',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
    );
  }
}
