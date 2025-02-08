import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/buttons/custom_button.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/features/dashboard/providers/category_provider.dart';
import 'package:frontend/features/dashboard/providers/job_provider.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void showCategoryBottomSheet(
  BuildContext context,
  VoidCallback onPressed,
) {
  final l10n = AppLocalizations.of(context)!;
  final categoryProvider =
      Provider.of<CategoryProvider>(context, listen: false);
  showModalBottomSheet(
    context: context, sheetAnimationStyle: AnimationStyle(
      duration: Duration(milliseconds: 700),
      reverseDuration: Duration(milliseconds: 700),
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
                  'Select Preferred Job Category',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontSize: 20.sp,
                      ),
                ),
                SizedBox(height: KSizes.xs),
                Text(
                  'Select your desired job category to get specific information',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: KColors.black,
                      ),
                ),
              ],
            ),
          ),
          SizedBox(height: KSizes.defaultSpace),
          categoryProvider.categories == null ||
                  categoryProvider.categories!.isEmpty
              ? SizedBox()
              : Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: categoryProvider.categories?.length ?? 0,
                            itemBuilder: (context, index) {
                              final category =
                                  categoryProvider.categories![index];
                              return Column(
                                children: [
                                  ListTile(
                                    onTap: () {},
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: KSizes.md),
                                    title: Text(
                                      category.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: KSizes.md),
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
