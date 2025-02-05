import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:frontend/common/widgets/alert_box/snackbar.dart';
import 'package:frontend/common/widgets/buttons/custom_button.dart';
import 'package:frontend/core/utils/circular_progress_indicator/custom_loading.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/features/dashboard/providers/category_provider.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:provider/provider.dart';

class PreferredCategorySection extends StatelessWidget {
  const PreferredCategorySection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final categoryProvider = Provider.of<CategoryProvider>(context);
    return Column(
      children: [
        Column(
          children: [
            SizedBox(height: KSizes.defaultSpace),
            Text(
              "${l10n.select_preferred_category}",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
            ),
            SizedBox(height: KSizes.xs),
            Text(
              "${l10n.choose_five_jobs_of_your_choice}",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: KColors.darkerGrey,
                    fontSize: 17.sp,
                  ),
            ),
            SizedBox(height: KSizes.defaultSpace),
          ],
        ),

        // Category and Counter
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: KSizes.md),
          child: SizedBox(
            height: categoryProvider.isMinimizedCategory ? null : 400.h,
            child: GestureDetector(
              onTap: categoryProvider.selectedCategories.length >= 1
                  ? () {
                      categoryProvider.toggleMinimizedCategory();
                    }
                  : null,
              child: Card(
                color: KColors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: KSizes.sm, vertical: KSizes.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Counter
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${l10n.category}",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          Text(
                            "${categoryProvider.selectedCategories.length}/5",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                      if (categoryProvider.isLoading) CustomLoading(),
                      if (!categoryProvider.isMinimizedCategory &&
                          !categoryProvider.isLoading) ...[
                        SizedBox(height: KSizes.md),
                        // Search Bar
                        TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: KSizes.defaultSpace),
                            suffixIcon: Padding(
                              padding: EdgeInsets.all(KSizes.sm),
                              child: Container(
                                width: 40.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                  color: KColors.primary,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Icon(
                                  AntDesign.search1,
                                  color: KColors.white,
                                ),
                              ),
                            ),
                            hintText: "${l10n.search_category}",
                            border: const OutlineInputBorder().copyWith(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: const BorderSide(
                                  width: 1, color: KColors.lightBackground),
                            ),
                            enabledBorder: const OutlineInputBorder().copyWith(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: const BorderSide(
                                  width: 1, color: KColors.lightBackground),
                            ),
                            focusedBorder: const OutlineInputBorder().copyWith(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: const BorderSide(
                                  width: 1, color: KColors.primary),
                            ),
                          ),
                        ),
                        SizedBox(height: KSizes.md),
                        // Categories
                        Expanded(
                          child: Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children:
                                categoryProvider.categories!.map((category) {
                              final isSelected = categoryProvider
                                  .selectedCategories
                                  .contains(category.name);

                              return GestureDetector(
                                onTap: () {
                                  if (categoryProvider
                                              .selectedCategories.length >=
                                          5 &&
                                      !isSelected) {
                                    KSnackbar.CustomSnackbar(context,
                                        "${l10n.max_limit_reached}", KColors.error);
                                  } else {
                                    categoryProvider
                                        .toggleCategory(category.name);
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 8.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? KColors.secondary
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: isSelected
                                          ? KColors.primary
                                          : KColors.grey,
                                    ),
                                  ),
                                  child: Text(
                                    category.name,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(height: KSizes.md),
                        // Next Button
                        categoryProvider.selectedCategories.length >= 1
                            ? CustomButton(
                                text: "${l10n.next}",
                                onPressed: () {
                                  categoryProvider.toggleMinimizedCategory();
                                },
                              )
                            : SizedBox(),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
