import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/alert_box/snackbar.dart';
import 'package:frontend/common/widgets/custom_screen/custom_screen.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/features/authentication/providers/details_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class PersonalDetailsScreen extends StatelessWidget {
  const PersonalDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final detailProvider = Provider.of<DetailsProvider>(context);
    return PopScope(
      canPop: false,
      child: CustomScreen(
        onPressed: () {
          if (detailProvider.selectedGender == null ||
              detailProvider.selectedSalary == null ||
              detailProvider.selectedEducationQualification == null) {
            KSnackbar.CustomSnackbar(
                context, "Please select required fields", KColors.error);
          }
          context.goNamed(RoutesConstant.statusDetails);
        },
        isProgressBarShowed: true,
        progressBarWidth: 225.w,
        child: Column(
          children: [
            SizedBox(height: KSizes.defaultSpace),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: KSizes.md),
              child: Column(
                children: [
                  Column(
                    children: [
                      SizedBox(height: KSizes.defaultSpace),
                      Text(
                        "Fill in your personal details",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                      ),
                      SizedBox(height: KSizes.xs),
                      Text(
                        "Fill your complete details",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: KColors.darkerGrey,
                              fontSize: 17.sp,
                            ),
                      ),
                      SizedBox(height: KSizes.defaultSpace),
                    ],
                  ),
                  // main
                  Column(
                    children: [
                      Consumer<DetailsProvider>(
                        builder: (context, detailProvider, child) {
                          return Column(
                            children: [
                              CounterWithTextWidget(
                                text: "Age",
                                value: detailProvider.ageCounter
                                    .toStringAsFixed(0),
                                incrementPressed:
                                    detailProvider.incrementAgeCounter,
                                decrementPressed:
                                    detailProvider.decrementAgeCounter,
                              ),
                              SizedBox(height: KSizes.defaultSpace),
                              CounterWithTextWidget(
                                text: "Work experience (in years)",
                                value: detailProvider.experienceCounter
                                    .toStringAsFixed(0),
                                incrementPressed:
                                    detailProvider.incrementExperienceCounter,
                                decrementPressed:
                                    detailProvider.decrementExperienceCounter,
                              ),
                              SizedBox(height: KSizes.md),
                              Divider(
                                color: KColors.grey,
                              )
                            ],
                          );
                        },
                      ),

                      SizedBox(height: KSizes.md),
                      //Gender education salary
                      Column(
                        children: [
                          //gender
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Gender",
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
                                children: detailProvider.gender.map((gender) {
                                  final isSelected =
                                      detailProvider.selectedGender == gender;

                                  return GestureDetector(
                                    onTap: () {
                                      if (detailProvider.selectedGender ==
                                          gender) {
                                        detailProvider.setSelectedGender(null);
                                      } else {
                                        detailProvider
                                            .setSelectedGender(gender);
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
                                        gender,
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
                          //education qualification
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Education Qualification",
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
                                children: detailProvider.educationQualification
                                    .map((educationQualification) {
                                  final isSelected = detailProvider
                                          .selectedEducationQualification ==
                                      educationQualification;

                                  return GestureDetector(
                                    onTap: () {
                                      if (detailProvider
                                              .selectedEducationQualification ==
                                          educationQualification) {
                                        detailProvider
                                            .setSelectedEducationQualification(
                                                null);
                                      } else {
                                        detailProvider
                                            .setSelectedEducationQualification(
                                                educationQualification);
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
                                        educationQualification,
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
                          //salary
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Expected Salary",
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
                                children: detailProvider.salary.map((salary) {
                                  final isSelected =
                                      detailProvider.selectedSalary == salary;

                                  return GestureDetector(
                                    onTap: () {
                                      if (detailProvider.selectedSalary ==
                                          salary) {
                                        detailProvider.setSelectedSalary(null);
                                      } else {
                                        detailProvider
                                            .setSelectedSalary(salary);
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
                                        salary,
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
    );
  }
}

class CounterWithTextWidget extends StatelessWidget {
  const CounterWithTextWidget({
    super.key,
    required this.text,
    required this.value,
    required this.incrementPressed,
    required this.decrementPressed,
    this.isRequired = true,
  });
  final String text;
  final String value;
  final VoidCallback incrementPressed;
  final VoidCallback decrementPressed;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            !isRequired
                ? SizedBox()
                : Text(
                    " *",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: KColors.error,
                        ),
                  ),
          ],
        ),
        Row(
          spacing: KSizes.md,
          children: [
            InkWell(
              onTap: decrementPressed,
              borderRadius: BorderRadius.circular(30),
              child: Container(
                padding: EdgeInsets.all(KSizes.xs - 2),
                decoration: BoxDecoration(
                  color: KColors.secondaryBackground,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  Icons.remove,
                  size: 18,
                  color: KColors.darkGrey,
                ),
              ),
            ),
            Container(
              width: 35.w,
              height: 30.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(KSizes.sm),
                  border: Border.all(
                    color: KColors.black,
                  )),
              child: Center(
                child: Text(
                  value,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            InkWell(
              onTap: incrementPressed,
              borderRadius: BorderRadius.circular(30),
              child: Container(
                padding: EdgeInsets.all(KSizes.xs - 2),
                decoration: BoxDecoration(
                  color: KColors.secondaryBackground,
                  border: Border.all(color: KColors.buttonSecondary),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  Icons.add,
                  size: 18,
                  color: KColors.black,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
