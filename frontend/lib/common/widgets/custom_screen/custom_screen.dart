import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/appbar/appbar.dart';
import 'package:frontend/common/widgets/buttons/custom_button.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:frontend/l10n/l10n.dart';

class CustomScreen extends StatelessWidget {
  final Widget child;
  final String? buttonText;
  final VoidCallback onPressed;
  final bool isProgressBarShowed;
  final double? progressBarWidth;

  const CustomScreen(
      {super.key,
      required this.child,
      this.buttonText,
      required this.onPressed,
      this.isProgressBarShowed = false,
      this.progressBarWidth});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: isProgressBarShowed
              ? Size.fromHeight(KDeviceUtils.getAppBarHeight() + 5.h)
              : Size.fromHeight(KDeviceUtils.getAppBarHeight()),
          child: Column(
            children: [
              Appbar(isActionRequired: false),
              !isProgressBarShowed
                  ? SizedBox()
                  : Row(
                      children: [
                        Container(
                          color: KColors.primary,
                          height: 5.h,
                          width: progressBarWidth,
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
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(child: child),
            ),

            // Divider line
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.grey.shade300,
                    width: 1,
                  ),
                ),
              ),
            ),

            // Next button - always at bottom
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                  horizontal: KSizes.md, vertical: KSizes.sm),
              child: CustomButton(
                text: buttonText ?? l10n.next,
                isIconShowed: true,
                icon: Icons.arrow_forward,
                onPressed: onPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
