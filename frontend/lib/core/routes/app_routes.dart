import 'package:flutter/material.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/features/authentication/screens/splash/splash.dart';
import 'package:frontend/features/dashboard/screens/job_details/job_details_screen.dart';
import 'package:frontend/navigation_menu.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppRoutes {
  final box = GetStorage();
  late GoRouter router = GoRouter(
    initialLocation: "/navigationMenu",
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        name: RoutesConstant.splash,
        path: "/",
        pageBuilder: (context, state) {
          return MaterialPage(
            child: SplashScreen(),
          );
        },
      ),
      GoRoute(
        name: RoutesConstant.navigationMenu,
        path: "/navigationMenu",
        pageBuilder: (context, state) {
          return MaterialPage(
            child: NavigationMenu(),
          );
        },
      ),
      GoRoute(
        name: RoutesConstant.jobDetails,
        path: "/jobDetails",
        pageBuilder: (context, state) {
          final jobId = state.extra as String;
          return MaterialPage(
            child: JobDetailsScreen(jobId: jobId),
          );
        },
      ),
    ],
    errorPageBuilder: (context, state) {
      return MaterialPage(
        child: Scaffold(
          body: Center(
            child: Text("Route not found"),
          ),
        ),
      );
    },
  );
}
