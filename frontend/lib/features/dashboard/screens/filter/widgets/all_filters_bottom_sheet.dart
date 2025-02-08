import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/buttons/custom_button.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/features/dashboard/providers/category_provider.dart';
import 'package:frontend/features/dashboard/providers/job_provider.dart';
import 'package:frontend/features/dashboard/screens/filter/widgets/category_bottom_sheet.dart';
import 'package:frontend/features/dashboard/screens/filter/widgets/experience_bottom_sheet.dart';
import 'package:frontend/features/dashboard/screens/filter/widgets/location_bottom_sheet.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void showAllFiltersBottomSheet(
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
      height: MediaQuery.of(context).size.height * 0.50,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: KSizes.md),
            child: Column(
              children: [
                Text(
                  'All Filters',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontSize: 20.sp,
                      ),
                ),
                SizedBox(height: KSizes.xs),
                Text(
                  'Select the preferred job filters to make the job search easy and quick.',
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  FilterTile(
                    title: "Job Category",
                    onTap: () {
                      context.pop();
                      showCategoryBottomSheet(
                        context,
                        () {},
                      );
                    },
                  ),
                  FilterTile(
                    title: "Job Location",
                    onTap: () {
                      context.pop();
                      showLocationBottomSheet(
                        context,
                        () {},
                      );
                    },
                  ),
                  FilterTile(
                    title: "Experience",
                    onTap: () {
                      context.pop();
                      showExperienceBottomSheet(
                        context,
                        () {},
                      );
                    },
                  ),
                  FilterTile(
                    title: "Salary",
                    onTap: () {},
                  ),
                  FilterTile(
                    title: "Education",
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class FilterTile extends StatelessWidget {
  const FilterTile({
    super.key,
    required this.title,
    required this.onTap,
  });
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          contentPadding: EdgeInsets.symmetric(horizontal: KSizes.md),
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          trailing: Icon(
            Icons.keyboard_arrow_right_outlined,
            size: KSizes.iconMd,
            color: KColors.darkerGrey,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: KSizes.md),
          child: Divider(
            height: 1,
            color: KColors.grey,
          ),
        ),
      ],
    );
  }
}
