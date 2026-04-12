import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nav_complexit_ystudy/screens/login_screen.dart';
import 'package:nav_complexit_ystudy/screens/dashboard_screen.dart';
import 'package:nav_complexit_ystudy/screens/profile_screen.dart';
import 'package:nav_complexit_ystudy/screens/project_details_screen.dart';
import 'package:nav_complexit_ystudy/screens/task_detail_screen.dart';
import 'package:nav_complexit_ystudy/models/project.dart';
import 'package:nav_complexit_ystudy/models/task.dart';

bool isAuthenticated = false;

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  redirect: (context, state) {
    if (!isAuthenticated && state.matchedLocation != '/') {
      return '/';
    }
    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return DashboardScreen(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/dashboard',
              builder: (context, state) => ProjectsListScreen(),
              routes: [
                GoRoute(
                  name: 'project_details',
                  path: 'project/:projectId',
                  builder: (context, state) {
                    final project = state.extra as Project?;
                    return ProjectDetailsScreen(
                      projectName: project?.name ?? 'Project ${state.pathParameters['projectId']}',
                    );
                  },
                  routes: [
                    GoRoute(
                      name: 'task_details',
                      path: 'task/:taskId',
                      builder: (context, state) {
                        final task = state.extra as Task?;
                        return TaskDetailScreen(
                          taskTitle: task?.title ?? 'Task ${state.pathParameters['taskId']}',
                          status: task?.status ?? 'No Status',
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) => const Scaffold(
                body: Center(child: Text('Settings Placeholder')),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);
