import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/alert_box/snackbar.dart';
import 'package:frontend/common/widgets/custom_screen/custom_screen.dart';
import 'package:frontend/common/widgets/loaders/full_screen_overlay.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/data/models/user_profile_request.dart';
import 'package:frontend/features/authentication/providers/details_provider.dart';
import 'package:frontend/features/authentication/providers/location_provider.dart';
import 'package:frontend/features/authentication/providers/signup_provider.dart';
import 'package:frontend/features/dashboard/providers/category_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignupStatusLastScreen extends StatelessWidget {
  const SignupStatusLastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final detailProvider = Provider.of<DetailsProvider>(context);
    final signupProvider = Provider.of<SignupProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final locationProvider = Provider.of<LocationProvider>(context);
    // void _submitProfile(BuildContext context) async {
    //   final profile = UserProfileRequest(
    //     preferredCategories: categoryProvider.selectedCategories.toList(),
    //     skills: categoryProvider.selectedSkills.toList(),
    //     preferredJobLocation: PreferredJobLocation(
    //       province: locationProvider.selectedProvince?.name ?? '',
    //       district: locationProvider.selectedDistrict?.name ?? '',
    //       municipality: locationProvider.selectedMunicipality?.name ?? '',
    //       fullAddress: locationProvider.selectedStreet ?? '',
    //     ),
    //     personalDetails: PersonalDetails(
    //       age: detailProvider.ageCounter,
    //       experience: detailProvider.experienceCounter,
    //       gender: detailProvider.selectedGender ?? "",
    //       maritalStatus: "Single",
    //       nationality: "Nepali",
    //       religion: "Hindu",
    //       email: "test@example.com",
    //       disability: Disability(hasDisability: false, details: ""),
    //       workingStatus: detailProvider.selectedWorkingStatus ?? "",
    //       foreignEmployment: ForeignEmployment(
    //           hasWorkedAboroad: detailProvider.foreignEmploymentAsBool ?? false,
    //           details: ""),
    //     ),
    //     jobPreference: JobPreference(
    //       jobLevel: "",
    //       availabilityStatus: "",
    //       preferredShift: "",
    //       expectedSalary: detailProvider.selectedSalary ?? "",
    //       careerObjectives: "",
    //     ),
    //   );

    //   final success = await signupProvider.createProfile(profile);
    //   if (!context.mounted) return;
    //   if (success) {
    //     // ScaffoldMessenger.of(context).showSnackBar(
    //     //   SnackBar(content: Text("Profile created successfully!")),
    //     // );
    //     // KSnackbar.CustomSnackbar(
    //     //     context, "Profile created successfully!", Colors.green);
    //   } else {
    //     // ScaffoldMessenger.of(context).showSnackBar(
    //     //   SnackBar(
    //     //       content: Text(
    //     //           signupProvider.errorMessage ?? "Profile creation failed")),
    //     // );
    //     // KSnackbar.CustomSnackbar(
    //     //     context,
    //     //     signupProvider.errorMessage ?? "Profile creation failed",
    //     //     KColors.error);
    //   }
    // }
    bool _validateInputs(BuildContext context, DetailsProvider detailProvider) {
      if (detailProvider.selectedIsForeignEmployment == null ||
          detailProvider.selectedWorkingStatus == null) {
        KSnackbar.CustomSnackbar(
          context,
          "Please select required fields",
          KColors.error,
        );
        return false;
      }
      return true;
    }

    Future<void> _submitProfile(BuildContext context) async {
      final detailProvider =
          Provider.of<DetailsProvider>(context, listen: false);
      final signupProvider =
          Provider.of<SignupProvider>(context, listen: false);
      final categoryProvider =
          Provider.of<CategoryProvider>(context, listen: false);
      final locationProvider =
          Provider.of<LocationProvider>(context, listen: false);

      if (!_validateInputs(context, detailProvider)) return;

      final profile = UserProfileRequest(
        preferredCategories: categoryProvider.selectedCategories.toList(),
        skills: categoryProvider.selectedSkills.toList(),
        preferredJobLocation: PreferredJobLocation(
          province: locationProvider.selectedProvince?.name ?? '',
          district: locationProvider.selectedDistrict?.name ?? '',
          municipality: locationProvider.selectedMunicipality?.name ?? '',
          fullAddress: locationProvider.selectedStreet ?? '',
        ),
        personalDetails: PersonalDetails(
          age: detailProvider.ageCounter,
          experience: detailProvider.experienceCounter,
          gender: detailProvider.selectedGender!.toLowerCase(),
          maritalStatus: "single",
          nationality: "Nepali",
          religion: "Hindu",
          email: "test@example.com",
          disability: Disability(hasDisability: false, details: ""),
          workingStatus: detailProvider.selectedWorkingStatus ?? "",
          foreignEmployment: ForeignEmployment(
            hasWorkedAboroad: detailProvider.foreignEmploymentAsBool ?? false,
            details: "",
          ),
        ),
        jobPreference: JobPreference(
          jobLevel: "entry",
          availabilityStatus: "immediate",
          preferredShift: "any",
          expectedSalary: detailProvider.selectedSalary ?? "",
          careerObjectives: "",
        ),
      );

      final success = await signupProvider.createProfile(profile);
      if (!context.mounted) return;

      KSnackbar.CustomSnackbar(
        context,
        success
            ? "Profile created successfully!"
            : (signupProvider.errorMessage ?? "Profile creation failed"),
        success ? Colors.green : KColors.error,
      );

      if (success) {
        context.goNamed(RoutesConstant.signupFormCompleted);
      }
    }

    return PopScope(
      canPop: false,
      child: FullScreenOverlay(
        isLoading: signupProvider.isLoading,
        child: CustomScreen(
          // onPressed: () {
          //   if (detailProvider.selectedIsForeignEmployment == null ||
          //       detailProvider.selectedWorkingStatus == null) {
          //     KSnackbar.CustomSnackbar(
          //         context, "Please select required fields", KColors.error);
          //   }
          //   //api calling
          //   _submitProfile(context);
          //   context.goNamed(RoutesConstant.signupFormCompleted);
          // },
          onPressed: () => _submitProfile(context),
          isProgressBarShowed: true,
          progressBarWidth: 300.w,
          child: Column(
            children: [
              SizedBox(height: KSizes.defaultSpace),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: KSizes.md),
                child: Column(
                  children: [
                    // main
                    Column(
                      children: [
                        //working status, have been to foreign employment
                        Column(
                          children: [
                            //working status
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Working Status",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            color: KColors.darkGrey,
                                          ),
                                    ),
                                    Text(
                                      " *",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            color: KColors.error,
                                          ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: KSizes.md),
                                Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: detailProvider.workingStatus
                                      .map((workingStatus) {
                                    final isSelected =
                                        detailProvider.selectedWorkingStatus ==
                                            workingStatus;

                                    return GestureDetector(
                                      onTap: () {
                                        if (detailProvider
                                                .selectedWorkingStatus ==
                                            workingStatus) {
                                          detailProvider
                                              .setSelectedWorkingStatus(null);
                                        } else {
                                          detailProvider
                                              .setSelectedWorkingStatus(
                                                  workingStatus);
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 8.0),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? KColors.secondary
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                            color: isSelected
                                                ? KColors.primary
                                                : KColors.grey,
                                          ),
                                        ),
                                        child: Text(
                                          workingStatus,
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                            SizedBox(height: KSizes.defaultSpace),
                            //foreign employment
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Have you been to foreign employement?",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            color: KColors.darkGrey,
                                          ),
                                    ),
                                    Text(
                                      " *",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            color: KColors.error,
                                          ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: KSizes.md),
                                Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: detailProvider.isForeignEmployment
                                      .map((foreignEmployment) {
                                    final isSelected = detailProvider
                                            .selectedIsForeignEmployment ==
                                        foreignEmployment;

                                    return GestureDetector(
                                      onTap: () {
                                        if (detailProvider
                                                .selectedIsForeignEmployment ==
                                            foreignEmployment) {
                                          detailProvider
                                              .setSelectedIsForeignEmployment(
                                                  null);
                                        } else {
                                          detailProvider
                                              .setSelectedIsForeignEmployment(
                                                  foreignEmployment);
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 8.0),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? KColors.secondary
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                            color: isSelected
                                                ? KColors.primary
                                                : KColors.grey,
                                          ),
                                        ),
                                        child: Text(
                                          foreignEmployment,
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),

                            SizedBox(height: KSizes.defaultSpace),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
