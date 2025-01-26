import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/appbar/appbar.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:frontend/features/authentication/screens/signup/widgets/preferred_category_section.dart';
import 'package:frontend/features/authentication/screens/signup/widgets/preferred_skill_section.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupPreferredScreen extends StatelessWidget {
  const SignupPreferredScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(KDeviceUtils.getAppBarHeight() + 5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Appbar(isActionRequired: false),
            Row(
              children: [
                Container(
                  color: KColors.primary,
                  height: 5.h,
                  width: 75.w,
                ),
                Expanded(
                  child: Container(
                    color: KColors.grey,
                    height: 5.h,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Category section
            PreferredCategorySection(),
            SizedBox(height: KSizes.defaultSpace),
            // Skill section
            PreferredSkillSection(),
          ],
        ),
      ),
    );
  }
}
