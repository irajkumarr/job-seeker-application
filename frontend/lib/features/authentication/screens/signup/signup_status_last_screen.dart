import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/custom_screen/custom_screen.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/features/authentication/providers/details_provider.dart';
import 'package:provider/provider.dart';

class SignupStatusLastScreen extends StatelessWidget {
  const SignupStatusLastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final detailProvider = Provider.of<DetailsProvider>(context);

    return CustomScreen(
      onPressed: () {
        final foreignEmployment = detailProvider.foreignEmploymentAsBool;
        print('Submitting Foreign Employment (bool): $foreignEmployment');
      },
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
                                    if (detailProvider.selectedWorkingStatus ==
                                        workingStatus) {
                                      detailProvider
                                          .setSelectedWorkingStatus(null);
                                    } else {
                                      detailProvider.setSelectedWorkingStatus(
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
                                      borderRadius: BorderRadius.circular(20),
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
                                          .setSelectedIsForeignEmployment(null);
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
                                      borderRadius: BorderRadius.circular(20),
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
    );
  }
}
