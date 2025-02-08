import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/buttons/custom_button.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:go_router/go_router.dart';

void showExperienceBottomSheet(
  BuildContext context,
  VoidCallback onPressed,
) {
  final l10n = AppLocalizations.of(context)!;
  showModalBottomSheet(
    context: context,
    sheetAnimationStyle: AnimationStyle(
      duration: Duration(milliseconds: 600),
      reverseDuration: Duration(milliseconds: 600),
    ),
    isScrollControlled: true, // Allow the sheet to be as large as needed
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(KSizes.md),
      ),
    ),
    builder: (context) => Container(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: KSizes.md),
            child: Column(
              children: [
                Text(
                  'Select years of work experience',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontSize: 20.sp,
                      ),
                ),
                SizedBox(height: KSizes.xs),
                Text(
                  'Choose the number of years you have worked on your related job',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: KColors.black,
                      ),
                ),
              ],
            ),
          ),
          SizedBox(height: KSizes.defaultSpace),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 11,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              onTap: () {},
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: KSizes.md),
                              title: Text(
                                index == 0
                                    ? "No experience"
                                    : index == 10
                                        ? "10 years or More"
                                        : "$index year${index > 1 ? 's' : ''}",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: KSizes.md),
                              child: Divider(
                                height: 1,
                                color: KColors.grey,
                              ),
                            ),
                          ],
                        );
                      })
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
