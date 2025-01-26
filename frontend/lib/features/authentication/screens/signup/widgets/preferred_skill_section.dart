import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:frontend/common/widgets/buttons/custom_button.dart';
import 'package:frontend/core/utils/circular_progress_indicator/custom_loading.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/features/dashboard/providers/category_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PreferredSkillSection extends StatelessWidget {
  const PreferredSkillSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    return Column(
      children: [
        Column(
          children: [
            SizedBox(height: KSizes.defaultSpace),
            Text(
              "What skills do you have",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
            ),
            SizedBox(height: KSizes.xs),
            Text(
              "Choose five skills you have",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: KColors.darkerGrey,
                    fontSize: 17.sp,
                  ),
            ),
            SizedBox(height: KSizes.defaultSpace),
          ],
        ),

        // skill and Counter
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: KSizes.md),
          child: SizedBox(
            height: categoryProvider.isMinimizedSkill ||
                    !categoryProvider.isMinimizedCategory
                ? null
                : 430.h,
            child: GestureDetector(
              onTap: categoryProvider.selectedSkills.length >= 1
                  ? () {
                      categoryProvider.toggleMinimizedSkill();
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
                            "Skill",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          Text(
                            "${categoryProvider.selectedSkills.length}/5",
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
                      if (!categoryProvider.isMinimizedSkill &&
                          categoryProvider.isMinimizedCategory) ...[
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
                            hintText: "Search Category",
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
                                categoryProvider.prefferedSkills.map((skill) {
                              final isSelected = categoryProvider.selectedSkills
                                  .contains(skill);

                              return GestureDetector(
                                onTap: () {
                                  if (categoryProvider.selectedSkills.length >=
                                          5 &&
                                      !isSelected) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(KSizes.md),
                                        ),
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: KColors.error,
                                        content: Text("Max limit reached"),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  } else {
                                    categoryProvider.toggleSkill(skill);
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
                                    skill,
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
                        categoryProvider.selectedSkills.length >= 1
                            ? CustomButton(
                                text: "Next",
                                onPressed: () {
                                  categoryProvider.toggleMinimizedSkill();
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
