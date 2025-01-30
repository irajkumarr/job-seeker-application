import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/circular_progress_indicator/custom_loading.dart';
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

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   Provider.of<ProfileProvider>(context, listen: false).fetchProfile();
  // }

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
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomLoading(),
                ],
              );
            }

            if (profileProvider.user == null) {
              return const ProfileWithoutLogin();
            }

            // final user = profileProvider.user!;
            final profile = profileProvider.profile;
            if (profile == null) {
              return Center(child: Text("No profile data found"));
            }

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
                          "${profile.name}",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        SizedBox(height: KSizes.xs),
                        Text(
                          "977-${profile.mobileNumber}",
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
                          height: 500.h,
                          sectionId: 'personal_info',
                          title: 'Personal Information',
                          leadingIcon: Icons.error_outline_outlined,
                          leadingIconColor: KColors.primary,
                          data: [
                            SectionData(
                                label: 'Full Name',
                                value: profile.name ?? "_ _ _",
                                icon: Iconsax.user),
                            SectionData(
                                label: 'Gender',
                                value: profile
                                        .profile?[0].personalDetails?.gender ??
                                    "_ _ _",
                                icon: Icons.call_missed_outgoing_outlined),
                            SectionData(
                                label: 'Age',
                                value: profile.profile?[0].personalDetails?.age
                                        .toString() ??
                                    "_ _ _",
                                icon: Icons.watch_later_outlined),
                            SectionData(
                                label: 'Marital Status',
                                value: profile.profile?[0].personalDetails
                                        ?.maritalStatus ??
                                    "_ _ _",
                                icon: Iconsax.user_tag),
                            SectionData(
                                label: 'Nationality',
                                value: profile.profile?[0].personalDetails
                                        ?.nationality ??
                                    "_ _ _",
                                icon: Icons.language_outlined),
                            SectionData(
                                label: 'Religion',
                                value: profile.profile?[0].personalDetails
                                        ?.religion ??
                                    "_ _ _",
                                icon: Icons.flag_outlined),
                            SectionData(
                                label: 'Email',
                                value: profile
                                        .profile?[0].personalDetails?.email ??
                                    "_ _ _",
                                icon: Icons.email_outlined),
                            SectionData(
                                label: 'Any Disability',
                                value: profile.profile?[0].personalDetails
                                        ?.disability ??
                                    "No",
                                icon: Icons.wheelchair_pickup_outlined),
                          ],
                        ),
                        SizedBox(height: KSizes.sm),
                        ExpandableCategoryAndSkillSection(
                            height: 120.h,
                            sectionId: 'category_info',
                            title: 'Category',
                            leadingIcon: Icons.check_circle,
                            leadingIconColor: Colors.green,
                            data: profile.profile![0].preferredCategories!),
                        SizedBox(height: KSizes.sm),
                        ExpandableCategoryAndSkillSection(
                            height: 300.h,
                            sectionId: 'skill_info',
                            title: 'Skill',
                            leadingIcon: Icons.check_circle,
                            leadingIconColor: Colors.green,
                            data: profile.profile![0].skills!),
                        SizedBox(height: KSizes.sm),
                        ExpandableProfileSection(
                            height: 300.h,
                            sectionId: 'preferred_job_location_info',
                            title: 'Preferred Job Location',
                            leadingIcon: Icons.check_circle,
                            leadingIconColor: Colors.green,
                            data: [
                              SectionData(
                                icon: Icons.play_circle_filled_sharp,
                                label: profile.profile![0].preferredJobLocation
                                        ?.district ??
                                    "",
                                value: profile.profile![0].preferredJobLocation
                                        ?.fullAddress ??
                                    "",
                              )
                            ]),
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

// // expandable_profile_section.dart

// import 'package:flutter/material.dart';
// import 'package:frontend/features/personalization/providers/profile_provider.dart';
// import 'package:provider/provider.dart';

// class ProfileScreen extends StatefulWidget {
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Provider.of<ProfileProvider>(context, listen: false).fetchProfile();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("My Profile")),
//       body: Consumer<ProfileProvider>(
//         builder: (context, profileProvider, child) {
//           if (profileProvider.isLoading) {
//             return Center(child: CircularProgressIndicator());
//           }

//           if (profileProvider.errorMessage.isNotEmpty) {
//             return Center(child: Text(profileProvider.errorMessage));
//           }

//           final profile = profileProvider.profile;
//           if (profile == null) {
//             return Center(child: Text("No profile data found"));
//           }

//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("Name: ${profile.name} ${profile.name}",
//                     style:
//                         TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                 Text("Education: ${profile.educations!.first.level}",
//                     style: TextStyle(fontSize: 16)),
//                 SizedBox(height: 10),
//                 Text("Experiences: ${profile.experiences?.length ?? 0}"),
//                 Text("Documents: ${profile.documents?.length ?? 0}"),
//                 Text("Trainings: ${profile.trainings?.length ?? 0}"),
//                 Text("Social Accounts: ${profile.socialaccounts?.length ?? 0}"),
//                 Text("References: ${profile.references?.length ?? 0}"),
//                 Text("Languages: ${profile.languages?.length ?? 0}"),
//                 Text("Educations: ${profile.educations?.length ?? 0}"),
//                 Text(
//                     "Emergency Contacts: ${profile.emergencycontacts?.length ?? 0}"),
//               ],
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Provider.of<ProfileProvider>(context, listen: false).fetchProfile();
//         },
//         child: Icon(Icons.refresh),
//       ),
//     );
//   }
// }
