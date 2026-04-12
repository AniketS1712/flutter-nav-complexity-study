import 'package:flutter/material.dart';
import 'package:nav_complexit_ystudy/theme/app_theme.dart';
import 'package:nav_complexit_ystudy/screens/login_screen.dart';
import 'package:nav_complexit_ystudy/screens/dashboard_screen.dart';
import 'package:nav_complexit_ystudy/screens/project_details_screen.dart';
import 'package:nav_complexit_ystudy/screens/task_detail_screen.dart';
import 'package:nav_complexit_ystudy/navigation/routes.dart';
import 'package:nav_complexit_ystudy/models/project.dart';
import 'package:nav_complexit_ystudy/models/task.dart';

void main() {
  runApp(const TaskFlowApp());
}

class TaskFlowApp extends StatelessWidget {
  const TaskFlowApp({super.key});

  bool get isAuthenticated => true; // Mock Auth State

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TaskFlow',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: AppRoutes.login,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case AppRoutes.login:
            return MaterialPageRoute(builder: (_) => const LoginScreen());
          case AppRoutes.dashboard:
            if (!isAuthenticated) {
              return MaterialPageRoute(builder: (_) => const LoginScreen());
            }
            return MaterialPageRoute(builder: (_) => const DashboardScreen());
          case AppRoutes.projectDetails:
            if (settings.arguments is Project) {
              final project = settings.arguments as Project;
              return MaterialPageRoute(
                builder: (_) => ProjectDetailsScreen(project: project),
              );
            }
            return _errorRoute();
          case AppRoutes.taskDetails:
            if (settings.arguments is Task) {
              final task = settings.arguments as Task;
              return MaterialPageRoute(
                builder: (_) => TaskDetailScreen(task: task),
              );
            }
            return _errorRoute();
          default:
            return _errorRoute();
        }
      },
    );
  }

  Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Page not found')),
      ),
    );
  }
}
