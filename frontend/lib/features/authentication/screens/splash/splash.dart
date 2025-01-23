import 'package:flutter_svg/svg.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/services/notification_service.dart';
import 'package:go_router/go_router.dart';
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
    _splashTimer = Timer(const Duration(seconds: 2), () {
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
      context.goNamed(RoutesConstant.navigationMenu);
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => NavigationMenu()),
      // );
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
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: KColors.primary,
            body: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: KSizes.spaceBtwSections * 1.5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 75.h,
                          width: 75.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: KColors.dark.withAlpha(20),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(22.r),
                            child: SvgPicture.asset(
                              "assets/images/content/rojgari_logo_single.svg",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Image.asset(
                          "assets/images/content/rojgari_logo_name.png",
                          width: 110.w,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Custom Overlay
          Container(
            height: double.infinity,
            width: double.infinity,
            // ignore: deprecated_member_use
            color: KColors.dark.withOpacity(0.7),
          ),
        ],
      ),
    );
  }
}
