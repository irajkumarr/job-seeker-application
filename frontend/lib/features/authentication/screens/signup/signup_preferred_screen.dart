import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/appbar/appbar.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';

class SignupPreferredScreen extends StatelessWidget {
  const SignupPreferredScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(KDeviceUtils.getAppBarHeight()),
          child: Appbar(isActionRequired: false)),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: KSizes.md).copyWith(
          bottom: KSizes.md,
        ),
        child: Column(
          children: [
            SizedBox(height: KSizes.defaultSpace),
            Text(
              "Select Preferred Category",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
            ),
            SizedBox(height: KSizes.xs),
            Text(
              "Choose up to five jobs of your choice.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: KColors.darkerGrey,
                    fontSize: 17.sp,
                  ),
            ),
            SizedBox(height: KSizes.defaultSpace),
          ],
        ),
      ),
    );
  }
}
