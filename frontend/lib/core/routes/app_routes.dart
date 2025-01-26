import 'package:flutter/material.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/features/authentication/screens/login/login.dart';
import 'package:frontend/features/authentication/screens/password_confimation/forgot_password.dart';
import 'package:frontend/features/authentication/screens/signup/signup.dart';
import 'package:frontend/features/authentication/screens/signup/signup_password_screen.dart';
import 'package:frontend/features/authentication/screens/signup/signup_preferred_location_screen.dart';
import 'package:frontend/features/authentication/screens/signup/signup_preferred_screen.dart';
import 'package:frontend/features/authentication/screens/splash/splash.dart';
import 'package:frontend/features/dashboard/screens/job_details/job_details_screen.dart';
import 'package:frontend/navigation_menu.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppRoutes {
  final box = GetStorage();
  late GoRouter router = GoRouter(
    initialLocation: "/signupPreferredLocation",
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
      GoRoute(
        name: RoutesConstant.login,
        path: "/login",
        pageBuilder: (context, state) {
          return MaterialPage(
            child: LoginScreen(),
          );
        },
      ),
      GoRoute(
        name: RoutesConstant.signup,
        path: "/signup",
        pageBuilder: (context, state) {
          return MaterialPage(
            child: SignupScreen(),
          );
        },
      ),
      GoRoute(
        name: RoutesConstant.signupPassword,
        path: "/signupPassword",
        pageBuilder: (context, state) {
          return MaterialPage(
            child: SignupPasswordScreen(),
          );
        },
      ),
      GoRoute(
        name: RoutesConstant.signupPreferred,
        path: "/signupPreferred",
        pageBuilder: (context, state) {
          return MaterialPage(
            child: SignupPreferredScreen(),
          );
        },
      ),
      GoRoute(
        name: RoutesConstant.signupPreferredLocation,
        path: "/signupPreferredLocation",
        pageBuilder: (context, state) {
          return MaterialPage(
            child: SignupPreferredLocationScreen(),
          );
        },
      ),
      GoRoute(
        name: RoutesConstant.forgotPassword,
        path: "/forgotPassword",
        pageBuilder: (context, state) {
          return MaterialPage(
            child: ForgetPasswordScreen(),
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
