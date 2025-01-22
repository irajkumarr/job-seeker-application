import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/success_screen/success.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppRoutes {
  final box = GetStorage();
  late GoRouter router = GoRouter(
    initialLocation: "/",
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        name: RoutesConstant.splash,
        path: "/",
        pageBuilder: (context, state) {
          return MaterialPage(
            child: Scaffold(),
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
