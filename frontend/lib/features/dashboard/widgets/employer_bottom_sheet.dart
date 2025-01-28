import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/buttons/custom_button.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:go_router/go_router.dart';

class EmployerBottomSheet extends StatelessWidget {
  EmployerBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: EdgeInsets.symmetric(vertical: KSizes.defaultSpace),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(KSizes.defaultSpace)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag Handle
          Center(
            child: Container(
              width: 30.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: KColors.darkerGrey,
                borderRadius: BorderRadius.circular(KSizes.md),
              ),
            ),
          ),
          const SizedBox(height: KSizes.defaultSpace),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: KSizes.md),
            child: Column(
              children: [
                Text(
                  l10n.are_you_seeking_for_an_employee,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: KSizes.md),
                // Employer go to  button
                CustomButton(
                  text: l10n.switch_to_employer,
                  color: Color(0xffB3512C),
                  onPressed: () {
                    context.pop();
                    context.pushNamed(RoutesConstant.employer);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Usage:
void showEmployerBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isDismissible: true,
    isScrollControlled: true,
    showDragHandle: false,
    sheetAnimationStyle: AnimationStyle(
      duration: Duration(milliseconds: 400),
      reverseDuration: Duration(milliseconds: 400),
    ),
    backgroundColor: KColors.white,
    builder: (context) => EmployerBottomSheet(),
  );
}
