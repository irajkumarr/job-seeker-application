import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/services/notification_service.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import '../../../../../core/utils/constants/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isInitializing = false;
  Timer? _splashTimer;
  bool _timerCompleted = false;
  bool _initializationCompleted = false;

  @override
  void initState() {
    super.initState();
    _startSplashTimer();
    _initializeApp();
  }

  void _startSplashTimer() {
    _splashTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _timerCompleted = true;
        });
        _checkNavigate();
      }
    });
  }

  void _checkNavigate() {
    if (_timerCompleted && _initializationCompleted && mounted) {
      // final box = GetStorage();
      // final isLanguageSelected = box.read('isLanguageSelected') ?? false;
      // final isFirstTime = box.read('isFirstTime') ?? true;

      // // Determine the next route
      // if (!isLanguageSelected) {
      //   GoRouter.of(context).go('/language');
      // } else if (isFirstTime) {
      //   GoRouter.of(context).go('/onboarding');
      // } else {
      //   GoRouter.of(context).go('/navigationMenu');
      // }
    }
  }

  @override
  void dispose() {
    _splashTimer?.cancel();
    super.dispose();
  }

  Future<void> _initializeApp() async {
    if (_isInitializing) return;
    _isInitializing = true;

    try {
      // Initialize notifications
      final NotificationService notificationService = NotificationService();
      await notificationService.requestNotificationPermission(context);
      await notificationService.getDeviceToken();
      notificationService.firebaseInit(context);
      notificationService.setupInteractMessage(context);

      // Check authentication
      // final box = GetStorage();
      // String? token = box.read("token");

      // if (token != null && mounted) {
      // final authProvider = Provider.of<AuthProvider>(context, listen: false);
      // await authProvider.getUserInfo();
      // }

      // Mark initialization as complete and check for navigation
      if (mounted) {
        setState(() {
          _initializationCompleted = true;
        });
        _checkNavigate();
      }
    } catch (e) {
      print("Initialization error: $e");
      if (mounted) {
        SystemNavigator.pop();
      }
    } finally {
      _isInitializing = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: KColors.primary,
        body: Center(
          child: Padding(
            padding:
                EdgeInsets.symmetric(vertical: KSizes.spaceBtwSections * 1.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(height: 85.h),
                    Container(
                      decoration: BoxDecoration(
                        color: KColors.white,
                        borderRadius: BorderRadius.circular(22.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(22.r),
                        child: Image.asset(
                          "assets/icons/mero kirana.png",
                          height: 150.h,
                          width: 150.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 27,
                      width: 27,
                      child: CircularProgressIndicator(
                        color: KColors.white,
                        strokeWidth: 3,
                      ),
                    ),
                    SizedBox(height: KSizes.defaultSpace),
                    Text(
                      "Version: 1.0.1",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: KColors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
