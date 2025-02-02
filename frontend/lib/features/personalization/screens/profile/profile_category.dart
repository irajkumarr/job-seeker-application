import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:frontend/common/widgets/alert_box/snackbar.dart';
import 'package:frontend/common/widgets/custom_screen/custom_screen.dart';
import 'package:frontend/common/widgets/loaders/full_screen_overlay.dart';
import 'package:frontend/core/utils/circular_progress_indicator/custom_loading.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/features/dashboard/providers/category_provider.dart';
import 'package:frontend/features/personalization/providers/profile_provider.dart';
import 'package:frontend/features/personalization/screens/profile/widgets/show_logout_alert.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProfileCategory extends StatefulWidget {
  const ProfileCategory({super.key});

  @override
  State<ProfileCategory> createState() => _ProfileCategoryState();
}

class _ProfileCategoryState extends State<ProfileCategory> {
  bool isCategoriesChanged = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final profileProvider =
          Provider.of<ProfileProvider>(context, listen: false);
      final categoryProvider =
          Provider.of<CategoryProvider>(context, listen: false);
      await categoryProvider.fetchCategories();

      if (profileProvider.profile?.profile![0].preferredCategories != null) {
        categoryProvider.selectedCategories.addAll(
            profileProvider.profile?.profile![0].preferredCategories ?? []);
      }
    });
  }

  Future<bool> _onWillPop() async {
    final categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    if (categoryProvider.selectedCategories.isEmpty || !isCategoriesChanged) {
      return true; // Allow back navigation if no changes are made
    } else {
      // Show dialog to confirm if changes were not saved
      return await alertEditChange(
        context,
        () {
          categoryProvider.reset();
          context.pop(true);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);

    return WillPopScope(
      onWillPop: _onWillPop, // Intercept back button press
      child: FullScreenOverlay(
        isLoading: profileProvider.isLoading,
        child: CustomScreen(
          buttonText: "Update",
          onPressed: () {
            final selectedCategories = categoryProvider.selectedCategories;
            if (selectedCategories.isEmpty) {
              KSnackbar.CustomSnackbar(context,
                  "Please select at least one category", KColors.error);
            } else {
              profileProvider.updatePreferredCategories(
                context,
                selectedCategories.toList(),
                () {
                  context.pop();
                  profileProvider.fetchProfile(forceRefresh: true);
                  categoryProvider.reset();
                },
              );
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: KSizes.md, vertical: KSizes.defaultSpace),
            child: Column(
              children: [
                Text(
                  "Category",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: KSizes.md),
                TextField(
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: KSizes.defaultSpace),
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
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide:
                          BorderSide(width: 1, color: KColors.lightBackground),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide:
                          BorderSide(width: 1, color: KColors.lightBackground),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(width: 1, color: KColors.primary),
                    ),
                  ),
                ),
                SizedBox(height: KSizes.md),

                // Counter
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: KSizes.sm),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Choose up to five jobs of your choice.",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        "${categoryProvider.selectedCategories.length}/5",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: KSizes.md),

                categoryProvider.isLoading
                    ? CustomLoading()
                    : Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: categoryProvider.categories!.map((category) {
                          final isSelected = categoryProvider.selectedCategories
                              .contains(category.name);

                          return GestureDetector(
                            onTap: () {
                              if (categoryProvider.selectedCategories.length >=
                                      5 &&
                                  !isSelected) {
                                KSnackbar.CustomSnackbar(context,
                                    "Max limit reached", KColors.error);
                              } else {
                                categoryProvider.toggleCategory(category.name);
                                setState(() {
                                  isCategoriesChanged = true;
                                });
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
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
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                SizedBox(height: KSizes.md),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
