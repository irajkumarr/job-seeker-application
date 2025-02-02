import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/alert_box/snackbar.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/circular_progress_indicator/custom_loading.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:frontend/features/authentication/providers/login_provider.dart';
import 'package:frontend/features/personalization/providers/contact_information_provider.dart';
import 'package:frontend/features/personalization/providers/document_provider.dart';
import 'package:frontend/features/personalization/providers/education_provider.dart';
import 'package:frontend/features/personalization/providers/profile_provider.dart';
import 'package:frontend/features/personalization/providers/reference_provider.dart';
import 'package:frontend/features/personalization/providers/social_account_provider.dart';
import 'package:frontend/features/personalization/providers/training_provider.dart';
import 'package:frontend/features/personalization/providers/user_language_provider.dart';
import 'package:frontend/features/personalization/screens/profile/widgets/expandable_category_skill_section.dart';
import 'package:frontend/features/personalization/screens/profile/widgets/expandable_job_preferred_section.dart';
import 'package:frontend/features/personalization/screens/profile/widgets/expandable_profile_section.dart';
import 'package:frontend/features/personalization/screens/profile/widgets/profile_details_list_tile.dart';
import 'package:frontend/features/personalization/screens/profile/widgets/profile_details_widget.dart';
import 'package:frontend/features/personalization/screens/profile/widgets/profile_without_login.dart';
import 'package:frontend/features/personalization/screens/profile/widgets/show_logout_alert.dart';
import 'package:frontend/features/personalization/screens/profile/widgets/user_icon_with_add_button.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
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
              return Center(
                  child: Text(
                "Profile Data not found",
                style: Theme.of(context).textTheme.titleSmall,
              ));
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
              body: RefreshIndicator(
                backgroundColor: KColors.white,
                color: KColors.primary,
                onRefresh: () async {
                  await Future.delayed(Duration(seconds: 2));
                  await profileProvider.fetchProfile(forceRefresh: true);
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
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
                                  value: profile.profile?[0].personalDetails
                                          ?.gender ??
                                      "_ _ _",
                                  icon: Icons.call_missed_outgoing_outlined),
                              SectionData(
                                  label: 'Age',
                                  value: profile
                                          .profile?[0].personalDetails?.age
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
                                  icon: Icons.accessible_forward_outlined),
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
                          ExpandablePreferredJobLocationSection(
                              height: 135.h,
                              sectionId: 'preferred_job_location_info',
                              title: 'Preferred Job Location',
                              leadingIcon: Icons.check_circle,
                              leadingIconColor: Colors.green,
                              data: [
                                SectionData(
                                  icon: Icons.radio_button_checked,
                                  label: profile.profile![0]
                                          .preferredJobLocation?.district ??
                                      "",
                                  value: profile.profile![0]
                                          .preferredJobLocation?.fullAddress ??
                                      "",
                                ),
                              ]),
                          SizedBox(height: KSizes.sm),
                          ExpandableProfileSection(
                            height: 400.h,
                            sectionId: 'job_preference_info',
                            title: 'Job Preference',
                            leadingIcon: Icons.error_outline_outlined,
                            leadingIconColor: KColors.primary,
                            data: [
                              SectionData(
                                  label: 'Job Level',
                                  value: profile.profile?[0].jobPreference
                                          ?.jobLevel ??
                                      "_ _ _",
                                  icon: Iconsax.level),
                              SectionData(
                                  label: 'Available for',
                                  value: profile.profile?[0].jobPreference
                                          ?.availabilityStatus ??
                                      "_ _ _",
                                  icon: Icons.watch_later_outlined),
                              SectionData(
                                  label: 'Preferred Shift',
                                  value: profile.profile?[0].jobPreference
                                          ?.preferredShift ??
                                      "_ _ _",
                                  icon: Icons.watch_later_outlined),
                              SectionData(
                                  label: 'Current Salary',
                                  value: profile.profile?[0].jobPreference
                                          ?.expectedSalary ??
                                      "_ _ _",
                                  icon: Icons.local_offer_outlined),
                              SectionData(
                                  label: 'Expected Salary',
                                  value: profile.profile?[0].jobPreference
                                          ?.expectedSalary ??
                                      "_ _ _",
                                  icon: Icons.local_offer_outlined),
                              SectionData(
                                  label: 'Career Objectives',
                                  value: profile.profile?[0].jobPreference
                                          ?.careerObjectives ??
                                      "_ _ _",
                                  icon: Icons.star_outline_outlined),
                            ],
                          ),
                          SizedBox(height: KSizes.sm),

                          //more sections experience education come here

                          !profile.experiences!.isEmpty
                              ? ProfileDetailsWidget(
                                  sectionId: "experience_section",
                                  title: "Work Experience",
                                  leadingIcon: Icons.check_circle,
                                  leadingIconColor: Colors.green,
                                  height: 160.h,
                                  data: profile.experiences!.map((exp) {
                                    return {
                                      'icon': Icons.radio_button_checked,
                                      'label':
                                          "${exp.startDate?.year}, ${DateFormat('MMMM').format(exp.startDate!)}",
                                      'value':
                                          "${exp.industry ?? ""}\n${exp.organizationName}\n${exp.designation}\n${exp.jobLevel}\n${exp.jobCategory}\n${exp.location}",
                                      'onEdit': () {},
                                      'onDelete': () {},
                                    };
                                  }).toList(),
                                  onAdd: () {
                                    context
                                        .pushNamed(RoutesConstant.experience);
                                  },
                                )
                              : ProfileDetailListTile(
                                  title: "Work Experience",
                                  onAdd: () {
                                    context
                                        .pushNamed(RoutesConstant.experience);
                                  },
                                ),
                          SizedBox(height: KSizes.sm),
                          !profile.educations!.isEmpty
                              ? ProfileDetailsWidget(
                                  sectionId: "education_section",
                                  title: "Education",
                                  leadingIcon: Icons.check_circle,
                                  leadingIconColor: KColors.success,
                                  isEditShowed: profile.educations!.any(
                                      (education) =>
                                          education.level !=
                                              "Cannot Read and Write" &&
                                          education.level !=
                                              "Can Read and Write"),
                                  height: 160.h,
                                  data: profile.educations!.map((education) {
                                    // Ensure empty or null values are handled properly
                                    final String startYear = (education
                                                .startDate?.year
                                                ?.trim()
                                                .isEmpty ??
                                            true)
                                        ? "N/A"
                                        : education.startDate!.year!;
                                    final String startMonth = (education
                                                .startDate?.month
                                                ?.trim()
                                                .isEmpty ??
                                            true)
                                        ? "N/A"
                                        : education.startDate!.month!;

                                    final String graduationYear = (education
                                                .graduationYear?.year
                                                ?.trim()
                                                .isEmpty ??
                                            true)
                                        ? "N/A"
                                        : education.graduationYear!.year!;
                                    final String graduationMonth = (education
                                                .graduationYear?.month
                                                ?.trim()
                                                .isEmpty ??
                                            true)
                                        ? "N/A"
                                        : education.graduationYear!.month!;

                                    final String institution = (education
                                                .institution
                                                ?.trim()
                                                .isEmpty ??
                                            true)
                                        ? "N/A"
                                        : education.institution!;
                                    final String level =
                                        (education.level?.trim().isEmpty ??
                                                true)
                                            ? "N/A"
                                            : education.level!;
                                    final String board = (education
                                                .educationBoard
                                                ?.trim()
                                                .isEmpty ??
                                            true)
                                        ? "N/A"
                                        : education.educationBoard!;

                                    final String program = (education
                                                .educationProgram
                                                ?.trim()
                                                .isEmpty ??
                                            true)
                                        ? "N/A"
                                        : education.educationProgram!;
                                    final String grade = (education.grade?.marks
                                                ?.trim()
                                                .isEmpty ??
                                            true)
                                        ? ""
                                        : education.grade!.marks!;
                                    final String gradeType = (education
                                                .grade?.type
                                                ?.trim()
                                                .isEmpty ??
                                            true)
                                        ? ""
                                        : education.grade!.type!;

                                    final bool isRestricted =
                                        level == "Cannot Read and Write" ||
                                            level == "Can Read and Write";

                                    return {
                                      'icon': Icons.radio_button_checked,
                                      // Show start date if available, otherwise graduation date, else "N/A"
                                      'label': startYear != "N/A"
                                          ? "$startYear, $startMonth"
                                          : (graduationYear != "N/A"
                                              ? "$graduationYear, $graduationMonth"
                                              : "N/A"),

                                      // Show institution, program, and duration correctly
                                      'value':
                                          "$level\n$program\n$board\n$institution\n$grade $gradeType",

                                      // 'onEdit': () {
                                      //   context.pushNamed(
                                      //       RoutesConstant.education,
                                      //       extra: education);
                                      // },
                                      if (!isRestricted)
                                        'onEdit': () {
                                          context.pushNamed(
                                              RoutesConstant.education,
                                              extra: {
                                                "education": education,
                                                "isRemoved": !isRestricted,
                                              });
                                        },
                                      'onDelete': () async {
                                        await alertDelete(context, () {
                                          Provider.of<EducationProvider>(
                                                  context,
                                                  listen: false)
                                              .deleteEducation(
                                                  context, education.id!,
                                                  () async {
                                            await profileProvider.fetchProfile(
                                                forceRefresh: true);
                                          });
                                        });
                                      },
                                    };
                                  }).toList(),
                                  onAdd: () {
                                    bool hasRestrictedEducation =
                                        profile.educations!.any((education) =>
                                            education.level ==
                                                "Cannot Read and Write" ||
                                            education.level ==
                                                "Can Read and Write");

                                    if (hasRestrictedEducation) {
                                      // Show a snackbar to inform the user
                                      KSnackbar.CustomSnackbar(
                                          context,
                                          "You cannot add more education details with this qualification. Please change your education level first.",
                                          KColors.darkerGrey);
                                      return;
                                    }
                                    context.pushNamed(RoutesConstant.education,
                                        extra: {
                                          "isRemoved": !hasRestrictedEducation,
                                        });
                                  },
                                )
                              : ProfileDetailListTile(
                                  title: "Education",
                                  onAdd: () {
                                    context.pushNamed(RoutesConstant.education);
                                  },
                                ),
                          SizedBox(height: KSizes.sm),
                          !profile.trainings!.isEmpty
                              ? ProfileDetailsWidget(
                                  sectionId: "training_section",
                                  title: "Training",
                                  leadingIcon: Icons.check_circle,
                                  leadingIconColor: Colors.green,
                                  height: 160.h,
                                  data: profile.trainings!.map((training) {
                                    return {
                                      'icon': Icons.radio_button_checked,
                                      'label':
                                          "${training.completionYear?.year}, ${training.completionYear?.month}",
                                      'value':
                                          "${training.name ?? ""}\n${training.institute ?? ""}\n${training.duration?.value ?? ""} ${training.duration?.unit ?? ""}",
                                      'onEdit': () {
                                        context.pushNamed(
                                            RoutesConstant.training,
                                            extra: training);
                                      },
                                      'onDelete': () async {
                                        await alertDelete(context, () {
                                          Provider.of<TrainingProvider>(context,
                                                  listen: false)
                                              .deleteTraining(
                                                  context, training.id!,
                                                  () async {
                                            await profileProvider.fetchProfile(
                                                forceRefresh: true);
                                          });
                                        });
                                      },
                                    };
                                  }).toList(),
                                  onAdd: () {
                                    context.pushNamed(RoutesConstant.training);
                                  }, // Define add function
                                )
                              : ProfileDetailListTile(
                                  title: "Training",
                                  onAdd: () {
                                    context.pushNamed(RoutesConstant.training);
                                  },
                                ),
                          SizedBox(height: KSizes.sm),
                          !profile.languages!.isEmpty
                              ? ProfileDetailsWidget(
                                  sectionId: "language_section",
                                  title: "Language",
                                  leadingIcon: Icons.check_circle,
                                  leadingIconColor: Colors.green,
                                  height: 160.h,
                                  isRating: true,
                                  data: profile.languages!.map((language) {
                                    return {
                                      'icon': Icons.radio_button_checked,
                                      'label': language.name ?? "Unknown",
                                      // 'value':
                                      //  "${language.score ?? ""}",
                                      'value': language.score ?? "",

                                      'onEdit': () {
                                        context.pushNamed(
                                          RoutesConstant.language,
                                          extra: language,
                                        );
                                      },
                                      'onDelete': () async {
                                        await alertDelete(context, () {
                                          Provider.of<UserLanguageProvider>(
                                                  context,
                                                  listen: false)
                                              .deleteLanguage(
                                                  context, language.id!,
                                                  () async {
                                            await profileProvider.fetchProfile(
                                                forceRefresh: true);
                                          });
                                        });
                                      },
                                    };
                                  }).toList(),
                                  onAdd: () {
                                    context.pushNamed(RoutesConstant.language);
                                  }, // Define add function
                                )
                              : ProfileDetailListTile(
                                  title: "Language",
                                  onAdd: () {
                                    context.pushNamed(RoutesConstant.language);
                                  },
                                ),
                          SizedBox(height: KSizes.sm),
                          !profile.documents!.isEmpty
                              ? ProfileDetailsWidget(
                                  sectionId: "document_section",
                                  title: "Document",
                                  leadingIcon: Icons.check_circle,
                                  leadingIconColor: Colors.green,
                                  height: 160.h,
                                  isImage: true,
                                  data: profile.documents!.map((document) {
                                    return {
                                      'icon': Icons.radio_button_checked,
                                      'label': document.category ?? "Unknown",
                                      'value': "${document.file ?? ""}",
                                      'onEdit': () {
                                        context.pushNamed(
                                          RoutesConstant.document,
                                          extra: document,
                                        );
                                      },
                                      'onDelete': () async {
                                        await alertDelete(context, () {
                                          Provider.of<DocumentProvider>(context,
                                                  listen: false)
                                              .deleteDocument(
                                                  documentId: document.id!,
                                                  context: context,
                                                  onSuccess: () async {
                                                    await profileProvider
                                                        .fetchProfile(
                                                            forceRefresh: true);
                                                  });
                                        });
                                      },
                                    };
                                  }).toList(),
                                  onAdd: () {
                                    context.pushNamed(RoutesConstant.document);
                                  }, // Define add function
                                )
                              : ProfileDetailListTile(
                                  title: "Document",
                                  onAdd: () {
                                    context.pushNamed(RoutesConstant.document);
                                  },
                                ),
                          SizedBox(height: KSizes.sm),
                          !profile.socialaccounts!.isEmpty
                              ? ProfileDetailsWidget(
                                  sectionId: "social_account_section",
                                  title: "Social Account",
                                  leadingIcon: Icons.check_circle,
                                  leadingIconColor: Colors.green,
                                  height: 160.h,
                                  data: profile.socialaccounts!
                                      .map((socialaccount) {
                                    return {
                                      'icon': Icons.radio_button_checked,
                                      'label':
                                          socialaccount.platform ?? "Unknown",
                                      'value': "${socialaccount.url ?? ""}",
                                      'onEdit': () {
                                        context.pushNamed(
                                            RoutesConstant.socialAccount,
                                            extra: socialaccount);
                                      },
                                      'onDelete': () async {
                                        await alertDelete(context, () {
                                          Provider.of<SocialAccountProvider>(
                                                  context,
                                                  listen: false)
                                              .deleteSocialAccount(
                                                  context, socialaccount.id!,
                                                  () async {
                                            await profileProvider.fetchProfile(
                                                forceRefresh: true);
                                          });
                                        });
                                      },
                                    };
                                  }).toList(),
                                  onAdd: () {
                                    context.pushNamed(
                                        RoutesConstant.socialAccount);
                                  }, // Define add function
                                )
                              : ProfileDetailListTile(
                                  title: "Social Account",
                                  onAdd: () {
                                    context.pushNamed(
                                        RoutesConstant.socialAccount);
                                  },
                                ),
                          SizedBox(height: KSizes.sm),
                          !profile.emergencycontacts!.isEmpty
                              ? ProfileDetailsWidget(
                                  sectionId: "emergency_contact_section",
                                  title: "Contact Information",
                                  leadingIcon: Icons.check_circle,
                                  leadingIconColor: Colors.green,
                                  height: 160.h,
                                  data: profile.emergencycontacts!
                                      .map((emergencycontact) {
                                    return {
                                      'icon': Icons.radio_button_checked,
                                      'label': emergencycontact.fullName ??
                                          "Unknown",
                                      'value':
                                          "${emergencycontact.phoneNumber?.mobileNumber ?? ""}\n${emergencycontact.relation ?? ""}\n${emergencycontact.address ?? ""}",
                                      'onEdit': () {
                                        context.pushNamed(
                                            RoutesConstant.contactInformation,
                                            extra: emergencycontact);
                                      },
                                      'onDelete': () async {
                                        await alertDelete(context, () {
                                          Provider.of<ContactInformationProvider>(
                                                  context,
                                                  listen: false)
                                              .deleteContactInformation(
                                                  context, emergencycontact.id!,
                                                  () async {
                                            await profileProvider.fetchProfile(
                                                forceRefresh: true);
                                          });
                                        });
                                      },
                                    };
                                  }).toList(),
                                  onAdd: () {
                                    context.pushNamed(
                                        RoutesConstant.contactInformation);
                                  }, // Define add function
                                )
                              : ProfileDetailListTile(
                                  title: "Contact Information",
                                  onAdd: () {
                                    context.pushNamed(
                                        RoutesConstant.contactInformation);
                                  },
                                ),
                          SizedBox(height: KSizes.sm),
                          !profile.references!.isEmpty
                              ? ProfileDetailsWidget(
                                  sectionId: "reference_section",
                                  title: "Reference",
                                  leadingIcon: Icons.check_circle,
                                  leadingIconColor: Colors.green,
                                  height: 160.h,
                                  data: profile.references!.map((reference) {
                                    return {
                                      'icon': Icons.radio_button_checked,
                                      'label':
                                          reference.organization ?? "Unknown",
                                      'value':
                                          "${reference.name ?? ""}\n${reference.email ?? ""}\n${reference.phoneNumber?.mobileNumber ?? ""}",
                                      'onEdit': () {
                                        context.pushNamed(
                                            RoutesConstant.reference,
                                            extra: reference);
                                      },
                                      'onDelete': () async {
                                        await alertDelete(context, () {
                                          Provider.of<ReferenceProvider>(
                                                  context,
                                                  listen: false)
                                              .deleteReference(
                                                  context, reference.id!,
                                                  () async {
                                            await profileProvider.fetchProfile(
                                                forceRefresh: true);
                                          });
                                        });
                                      },
                                    };
                                  }).toList(),
                                  onAdd: () {
                                    context.pushNamed(RoutesConstant.reference);
                                  }, // Define add function
                                )
                              : ProfileDetailListTile(
                                  title: "Reference",
                                  onAdd: () {
                                    context.pushNamed(RoutesConstant.reference);
                                  },
                                ),
                          SizedBox(height: KSizes.defaultSpace),
                        ],
                      ),
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
