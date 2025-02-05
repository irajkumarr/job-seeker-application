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
import 'package:frontend/features/personalization/screens/profile/widgets/custom_alert.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProfileSkill extends StatefulWidget {
  const ProfileSkill({super.key});

  @override
  State<ProfileSkill> createState() => _ProfileSkillState();
}

class _ProfileSkillState extends State<ProfileSkill> {
  bool isSkillsChanged = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final profileProvider =
          Provider.of<ProfileProvider>(context, listen: false);
      final categoryProvider =
          Provider.of<CategoryProvider>(context, listen: false);

      await categoryProvider.selectedSkills;

      if (profileProvider.profile?.profile![0].skills != null) {
        categoryProvider.selectedSkills
            .addAll(profileProvider.profile?.profile![0].skills ?? []);
      }
    });
  }

  Future<bool> _onWillPop() async {
    final categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    if (categoryProvider.selectedSkills.isEmpty || !isSkillsChanged) {
      return true;
    } else {
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
    final l10n = AppLocalizations.of(context)!;
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: _onWillPop, // Intercept back button press
      child: FullScreenOverlay(
        isLoading: profileProvider.isLoading,
        child: CustomScreen(
          buttonText: "${l10n.update}",
          isIconShowed: false,
          onPressed: () {
            final selectedSkills = categoryProvider.selectedSkills;
            if (selectedSkills.isEmpty) {
              KSnackbar.CustomSnackbar(
                  context, "Please select at least one skill", KColors.error);
            } else {
              profileProvider.updateSkills(
                context,
                selectedSkills.toList(),
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
                  "${l10n.skill}",
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
                    hintText: "${l10n.search_skill}",
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
                        "${l10n.choose_five_skills_you_have}",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        "${categoryProvider.selectedSkills.length}/5",
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
                        children: categoryProvider.prefferedSkills.map((skill) {
                          final isSelected =
                              categoryProvider.selectedSkills.contains(skill);

                          return GestureDetector(
                            onTap: () {
                              if (categoryProvider.selectedSkills.length >= 5 &&
                                  !isSelected) {
                                KSnackbar.CustomSnackbar(context,
                                    "${l10n.max_limit_reached}", KColors.error);
                              } else {
                                categoryProvider.toggleSkill(skill);
                                setState(() {
                                  isSkillsChanged = true;
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
                                skill,
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
