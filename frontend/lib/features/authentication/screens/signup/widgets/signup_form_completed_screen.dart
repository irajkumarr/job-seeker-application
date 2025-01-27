import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/appbar/appbar.dart';
import 'package:frontend/core/utils/device/device_utility.dart';

class SignupFormCompletedScreen extends StatelessWidget {
  const SignupFormCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(KDeviceUtils.getAppBarHeight() + 5.h),
        child: Column(
          children: [
            Appbar(isActionRequired: false),
            
          ],
        ),
      ),
    );
  }
}
