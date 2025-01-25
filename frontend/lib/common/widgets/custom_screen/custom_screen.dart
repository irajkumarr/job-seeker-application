import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/appbar/appbar.dart';
import 'package:frontend/common/widgets/buttons/custom_button.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:frontend/l10n/l10n.dart';

class CustomScreen extends StatelessWidget {
  final Widget child;
  final String? buttonText;
  final VoidCallback onPressed;

  const CustomScreen(
      {super.key,
      required this.child,
      this.buttonText,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(KDeviceUtils.getAppBarHeight()),
        child: Appbar(isActionRequired: false),
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
    );
  }
}
