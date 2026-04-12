import 'package:go_router/go_router.dart';
import 'package:nav_complexit_ystudy/screens/login_screen.dart';
import 'package:nav_complexit_ystudy/screens/dashboard_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => DashboardScreen(),
    ),
  ],
);
