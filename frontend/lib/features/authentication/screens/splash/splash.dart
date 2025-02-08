import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/services/notification_service.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/navigation_menu.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Configuration
  static const int _splashDuration = 2;

  // State variables
  bool _isInitialized = false;
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    if (_isInitialized) return;

    try {
      // Initialize notifications concurrently with splash timer
      await Future.wait([
        _initializeNotifications(),
        Future.delayed(const Duration(seconds: _splashDuration)),
      ]);

      _isInitialized = true;
      _navigateToNextScreen();
    } catch (e) {
      print('Initialization error: $e');
      if (mounted) SystemNavigator.pop();
    }
  }

  Future<void> _initializeNotifications() async {
    final notificationService = NotificationService();

    await notificationService.requestNotificationPermission(context);
    await notificationService.getDeviceToken();
    notificationService.firebaseInit(context);
    notificationService.setupInteractMessage(context);
  }

  void _navigateToNextScreen() {
    if (!mounted || _isNavigating) return;

    _isNavigating = true;
    // context.goNamed(RoutesConstant.navigationMenu);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => NavigationMenu()),
        (route) => true);
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => NavigationMenu()));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: KColors.primary,
        body: Stack(
          fit: StackFit.expand,
          children: [
            // Logo Section
            _buildLogoSection(),

            // Overlay
            Container(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.6),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoSection() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: KSizes.spaceBtwSections * 1.5,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLogoIcon(),
            _buildLogoText(),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoIcon() {
    return Container(
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
    );
  }

  Widget _buildLogoText() {
    return Image.asset(
      "assets/images/content/rojgari_logo_name.png",
      width: 110.w,
      fit: BoxFit.contain,
    );
  }
}
