import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:frontend/data/models/login_model.dart';
import 'package:frontend/features/authentication/providers/login_provider.dart';
import 'package:frontend/features/personalization/providers/profile_provider.dart';
import 'package:frontend/features/personalization/screens/profile/widgets/expandable_profile_section.dart';
import 'package:frontend/features/personalization/screens/profile/widgets/profile_without_login.dart';
import 'package:frontend/features/personalization/screens/profile/widgets/user_icon_with_add_button.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Consumer<LoginProvider>(
      builder: (context, loginProvider, child) {
        final String? token = loginProvider.box.read("token");

        if (token == null) {
          return const ProfileWithoutLogin();
        }

        return Consumer<ProfileProvider>(
          builder: (context, profileProvider, child) {
            if (profileProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (profileProvider.user == null) {
              return const ProfileWithoutLogin();
            }

            final user = profileProvider.user!;

            return Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(KDeviceUtils.getAppBarHeight()),
                child: Material(
                  elevation: 0.2,
                  child: AppBar(
                    title: Text(
                      l10n.profile,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontSize: 22),
                    ),
                    actions: [
                      IconButton(
                        onPressed: () {
                          context.pushNamed(RoutesConstant.profileSettings);
                        },
                        icon: const Icon(Icons.settings_outlined),
                      ),
                      SizedBox(width: KSizes.xs),
                    ],
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: KSizes.md, vertical: KSizes.md),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        UserIconWithAddButton(),
                        SizedBox(height: KSizes.md),
                        Text(
                          "${user.name}",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        SizedBox(height: KSizes.xs),
                        Text(
                          "977-${user.mobileNumber}",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        SizedBox(height: KSizes.defaultSpace),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text("Jobs Applied"),
                                SizedBox(height: KSizes.xs),
                                Text(
                                  "0",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: KColors.primary,
                                      ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text("Profile Visits"),
                                SizedBox(height: KSizes.xs),
                                Text(
                                  "0",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: KColors.primary,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: KSizes.sm),
                        Divider(color: KColors.grey),
                        SizedBox(height: KSizes.md),
                        ExpandableProfileSection(
                          sectionId: 'personal_info',
                          title: 'Personal Information',
                          leadingIcon: Icons.person_outline,
                          leadingIconColor: KColors.primary,
                          user: user,
                        ),
                        SizedBox(height: KSizes.sm),
                        ExpandableProfileSection(
                          sectionId: 'category_info',
                          title: 'Category',
                          leadingIcon: Icons.check_circle,
                          leadingIconColor: Colors.green,
                          user: user,
                        ),
                        SizedBox(height: KSizes.sm),
                        ExpandableProfileSection(
                          sectionId: 'skill_info',
                          title: 'Skill',
                          leadingIcon: Icons.check_circle,
                          leadingIconColor: Colors.green,
                          user: user,
                        ),
                        SizedBox(height: KSizes.sm),
                        ExpandableProfileSection(
                          sectionId: 'preferred_job_location_info',
                          title: 'Preferred Job Location',
                          leadingIcon: Icons.check_circle,
                          leadingIconColor: Colors.green,
                          user: user,
                        ),
                        SizedBox(height: KSizes.sm),
                        ExpandableProfileSection(
                          sectionId: 'job_preference_info',
                          title: 'Job Preference',
                          leadingIcon: Icons.check_circle,
                          leadingIconColor: Colors.green,
                          user: user,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class ProfileDetailListTile extends StatelessWidget {
  const ProfileDetailListTile({
    super.key,
    required this.title,
    required this.leadingIcon,
    required this.onTap,
    required this.leadingIconColor,
  });
  final String title;
  final IconData leadingIcon;
  final Color leadingIconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      horizontalTitleGap: 10.w,
      contentPadding:
          EdgeInsets.symmetric(vertical: KSizes.xs, horizontal: KSizes.md),
      tileColor: KColors.secondaryBackground,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(KSizes.sm)),
      leading: Icon(
        leadingIcon,
        color: leadingIconColor,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              fontSize: 18.sp,
            ),
      ),
      trailing: Icon(Icons.keyboard_arrow_down_sharp),
    );
  }
}

// expandable_profile_section.dart
