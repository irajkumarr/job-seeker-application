import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/alert_box/snackbar.dart';
import 'package:frontend/common/widgets/custom_screen/custom_screen.dart';
import 'package:frontend/common/widgets/loaders/full_screen_overlay.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/divider/dotted_divider.dart';
import 'package:frontend/core/utils/validators/validation.dart';
import 'package:frontend/data/models/user_profile_request.dart';
import 'package:frontend/features/authentication/providers/details_provider.dart';
import 'package:frontend/features/authentication/providers/location_provider.dart';
import 'package:frontend/features/authentication/providers/signup_provider.dart';
import 'package:frontend/features/dashboard/providers/category_provider.dart';
import 'package:frontend/features/personalization/screens/profile/widgets/text_editor_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProfileJobPreference extends StatefulWidget {
  const ProfileJobPreference({super.key});

  @override
  State<ProfileJobPreference> createState() => _ProfileJobPreferenceState();
}

class _ProfileJobPreferenceState extends State<ProfileJobPreference> {
  String? _selectedCurrentSalaryCurrency;
  String? _selectedExpectedSalaryCurrency;
  String? _selectedCurrentSalaryValue;
  String? _selectedExpectedSalaryValue;
  String? _selectedCurrentSalaryDuration;
  String? _selectedExpectedSalaryDuration;
  final expectedSalaryController = TextEditingController();
  final currentSalaryController = TextEditingController();
  final careerObjectivesController = TextEditingController();
  // List of months
  final List<String> _currency = ["NPR."];
  final List<String> _value = [
    "Above",
    "Equals",
    "Below",
  ];
  final List<String> _duration = [
    "per Hour",
    "per Day",
    "per Week",
    "per Month",
    "per Year",
  ];

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
          buttonText: "Submit",
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
                        //working status, preferred shift, job level, available for come here
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Preferred Shift",
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
                                  children: detailProvider.preferredShift
                                      .map((shift) {
                                    final isSelected =
                                        detailProvider.selectedPreferredShift ==
                                            shift;

                                    return GestureDetector(
                                      onTap: () {
                                        if (detailProvider
                                                .selectedPreferredShift ==
                                            shift) {
                                          detailProvider
                                              .setSelectedPreferredShift(null);
                                        } else {
                                          detailProvider
                                              .setSelectedPreferredShift(shift);
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
                                          shift,
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
                            //job level
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Job Level",
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
                                  children:
                                      detailProvider.jobLevel.map((jobLevel) {
                                    final isSelected =
                                        detailProvider.selectedJobLevel ==
                                            jobLevel;

                                    return GestureDetector(
                                      onTap: () {
                                        if (detailProvider.selectedJobLevel ==
                                            jobLevel) {
                                          detailProvider
                                              .setSelectedJobLevel(null);
                                        } else {
                                          detailProvider
                                              .setSelectedJobLevel(jobLevel);
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
                                          jobLevel,
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
                            //avalilble for
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Available For",
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
                                  children: detailProvider.availableFor
                                      .map((availableFor) {
                                    final isSelected =
                                        detailProvider.selectedAvailableFor ==
                                            availableFor;

                                    return GestureDetector(
                                      onTap: () {
                                        if (detailProvider
                                                .selectedAvailableFor ==
                                            availableFor) {
                                          detailProvider
                                              .setSelectedAvailableFor(null);
                                        } else {
                                          detailProvider
                                              .setSelectedAvailableFor(
                                                  availableFor);
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
                                          availableFor,
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Current Salary",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                SizedBox(height: KSizes.sm),
                                Row(
                                  children: [
                                    Expanded(
                                      child: DropdownButtonFormField<String>(
                                        value: _selectedCurrentSalaryCurrency,
                                        dropdownColor: KColors.white,
                                        icon: Icon(
                                            Icons.keyboard_arrow_down_outlined),
                                        hint: Text('Currency'),
                                        validator: (value) =>
                                            KValidator.validateEmptyText(
                                                "Currency", value),
                                        items: _currency
                                            .map((currency) => DropdownMenuItem(
                                                  value: currency,
                                                  child: Text(currency),
                                                ))
                                            .toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedCurrentSalaryCurrency =
                                                value;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 12),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: KSizes.sm),
                                    Expanded(
                                      child: DropdownButtonFormField<String>(
                                        value: _selectedCurrentSalaryValue,
                                        dropdownColor: KColors.white,
                                        icon: Icon(
                                            Icons.keyboard_arrow_down_outlined),
                                        hint: Text('Value'),
                                        validator: (value) =>
                                            KValidator.validateEmptyText(
                                                "Value", value),
                                        items: _value
                                            .map((value) => DropdownMenuItem(
                                                  value: value,
                                                  child: Text(value),
                                                ))
                                            .toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedCurrentSalaryValue = value;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 12),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: KSizes.md),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: currentSalaryController,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.number,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                fontSize: KSizes.fontSizeSm),
                                        validator: (value) =>
                                            KValidator.validateEmptyText(
                                                "Amount", value),
                                        decoration: const InputDecoration(
                                          labelText: "Amount",
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: KSizes.sm),
                                    Expanded(
                                      child: DropdownButtonFormField<String>(
                                        value: _selectedCurrentSalaryDuration,
                                        dropdownColor: KColors.white,
                                        icon: Icon(
                                            Icons.keyboard_arrow_down_outlined),
                                        hint: Text('Duration'),
                                        validator: (value) =>
                                            KValidator.validateEmptyText(
                                                "Duration", value),
                                        items: _duration
                                            .map((duration) => DropdownMenuItem(
                                                  value: duration,
                                                  child: Text(duration),
                                                ))
                                            .toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedCurrentSalaryDuration =
                                                value;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 12),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: KSizes.md),
                            DottedDivider(),
                            SizedBox(height: KSizes.md),
                            //expected salary
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Expected Salary",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                SizedBox(height: KSizes.sm),
                                Row(
                                  children: [
                                    Expanded(
                                      child: DropdownButtonFormField<String>(
                                        value: _selectedExpectedSalaryCurrency,
                                        dropdownColor: KColors.white,
                                        icon: Icon(
                                            Icons.keyboard_arrow_down_outlined),
                                        hint: Text('Currency'),
                                        validator: (value) =>
                                            KValidator.validateEmptyText(
                                                "Currency", value),
                                        items: _currency
                                            .map((currency) => DropdownMenuItem(
                                                  value: currency,
                                                  child: Text(currency),
                                                ))
                                            .toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedExpectedSalaryCurrency =
                                                value;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 12),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: KSizes.sm),
                                    Expanded(
                                      child: DropdownButtonFormField<String>(
                                        value: _selectedExpectedSalaryValue,
                                        dropdownColor: KColors.white,
                                        icon: Icon(
                                            Icons.keyboard_arrow_down_outlined),
                                        hint: Text('Value'),
                                        validator: (value) =>
                                            KValidator.validateEmptyText(
                                                "Value", value),
                                        items: _value
                                            .map((value) => DropdownMenuItem(
                                                  value: value,
                                                  child: Text(value),
                                                ))
                                            .toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedExpectedSalaryValue =
                                                value;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 12),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: KSizes.md),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: expectedSalaryController,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.number,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                fontSize: KSizes.fontSizeSm),
                                        validator: (value) =>
                                            KValidator.validateEmptyText(
                                                "Amount", value),
                                        decoration: const InputDecoration(
                                          labelText: "Amount",
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: KSizes.sm),
                                    Expanded(
                                      child: DropdownButtonFormField<String>(
                                        value: _selectedExpectedSalaryDuration,
                                        dropdownColor: KColors.white,
                                        icon: Icon(
                                            Icons.keyboard_arrow_down_outlined),
                                        hint: Text('Duration'),
                                        validator: (value) =>
                                            KValidator.validateEmptyText(
                                                "Duration", value),
                                        items: _duration
                                            .map((duration) => DropdownMenuItem(
                                                  value: duration,
                                                  child: Text(duration),
                                                ))
                                            .toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedExpectedSalaryDuration =
                                                value;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 12),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: KSizes.md),
                            DottedDivider(),
                            SizedBox(height: KSizes.md),
                            TextEditorWidget(
                              title: "Career Objectives",
                              controller: careerObjectivesController,
                            ),
                            SizedBox(height: KSizes.defaultSpace * 10),
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
