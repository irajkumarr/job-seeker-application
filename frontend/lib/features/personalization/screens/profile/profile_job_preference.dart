import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/alert_box/snackbar.dart';
import 'package:frontend/common/widgets/custom_screen/custom_screen.dart';
import 'package:frontend/common/widgets/loaders/full_screen_overlay.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/divider/dotted_divider.dart';
import 'package:frontend/data/models/user_profile_request.dart';
import 'package:frontend/features/authentication/providers/details_provider.dart';
import 'package:frontend/features/authentication/providers/location_provider.dart';
import 'package:frontend/features/authentication/providers/signup_provider.dart';
import 'package:frontend/features/dashboard/providers/category_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProfileJobPreference extends StatelessWidget {
  const ProfileJobPreference({super.key});

  @override
  Widget build(BuildContext context) {
    final detailProvider = Provider.of<DetailsProvider>(context);
    final signupProvider = Provider.of<SignupProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final locationProvider = Provider.of<LocationProvider>(context);

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

    return PopScope(
      canPop: false,
      child: FullScreenOverlay(
        isLoading: signupProvider.isLoading,
        child: CustomScreen(
          onPressed: () {},
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
                        Text(
                          "Job Preference",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        SizedBox(height: KSizes.defaultSpace),
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
                            SizedBox(height: KSizes.md),
                            DottedDivider(),
                            SizedBox(height: KSizes.md),
                            //Preferred Shift
                            
                           

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
