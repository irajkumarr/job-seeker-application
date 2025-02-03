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
import 'package:frontend/data/models/profile_detail_model.dart' as profile;
import 'package:frontend/data/models/user_profile_request.dart';
import 'package:frontend/features/authentication/providers/details_provider.dart';
import 'package:frontend/features/authentication/providers/location_provider.dart';
import 'package:frontend/features/authentication/providers/signup_provider.dart';
import 'package:frontend/features/dashboard/providers/category_provider.dart';
import 'package:frontend/features/personalization/providers/profile_provider.dart';
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
  final _formKey = GlobalKey<FormState>();
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

  // @override
  // void initState() {
  //   super.initState();
  //   final profileProvider =
  //       Provider.of<ProfileProvider>(context, listen: false);
  //   final detailProvider = Provider.of<DetailsProvider>(context, listen: false);

  //   final profile = profileProvider.profile?.profile?.isNotEmpty == true
  //       ? profileProvider.profile!.profile![0]
  //       : null;
  //   detailProvider.selectedWorkingStatus =
  //       profile?.jobPreference?.workingStatus;
  //   detailProvider.selectedAvailableFor =
  //       profile?.jobPreference?.availabilityStatus;
  //   detailProvider.selectedPreferredShift =
  //       profile?.jobPreference?.preferredShift;
  //   detailProvider.selectedJobLevel = profile?.jobPreference?.jobLevel;
  //   careerObjectivesController.text =
  //       profile?.jobPreference?.careerObjectives ?? "";
  //   expectedSalaryController.text =
  //       profile?.jobPreference?.expectedSalary ?? "";
  // }

  @override
  Widget build(BuildContext context) {
    final detailProvider = Provider.of<DetailsProvider>(context);
    final signupProvider = Provider.of<SignupProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);
    final locationProvider = Provider.of<LocationProvider>(context);

    bool _validateInputs(BuildContext context, DetailsProvider detailProvider) {
      if (detailProvider.selectedPreferredShift == null ||
          detailProvider.selectedAvailableFor == null ||
          detailProvider.selectedJobLevel == null ||
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

    return FullScreenOverlay(
      isLoading: profileProvider.isLoading,
      child: CustomScreen(
        onPressed: () async {
          if (!_validateInputs(context, detailProvider)) return;
          if (_formKey.currentState!.validate()) {
            // profile.Profile model = profile.Profile(

            JobPreference model = JobPreference(
              workingStatus: detailProvider.selectedWorkingStatus,
              preferredShift: detailProvider.selectedPreferredShift,
              jobLevel: detailProvider.selectedJobLevel,
              availabilityStatus: detailProvider.selectedAvailableFor,
              // expectedSalary: expectedSalaryController.text.trim(),
              careerObjectives: careerObjectivesController.text.trim(),
              // ),
            );
            await profileProvider.updateJobPreference(context, model, () async {
              await profileProvider.fetchProfile(forceRefresh: true);
              detailProvider.reset();
              context.pop();
            });
          }
        },
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
                      Form(
                        key: _formKey,
                        child: Column(
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

                            SalaryInputWidget(
                              title: "Current Salary",
                              selectedCurrency: _selectedCurrentSalaryCurrency,
                              selectedValue: _selectedCurrentSalaryValue,
                              selectedDuration: _selectedCurrentSalaryDuration,
                              amountController: currentSalaryController,
                              onCurrencyChanged: (value) => setState(
                                  () => _selectedCurrentSalaryCurrency = value),
                              onValueChanged: (value) => setState(
                                  () => _selectedCurrentSalaryValue = value),
                              onDurationChanged: (value) => setState(
                                  () => _selectedCurrentSalaryDuration = value),
                              currencies: _currency,
                              values: _value,
                              durations: _duration,
                            ),
                            SizedBox(height: KSizes.md),
                            DottedDivider(),
                            SizedBox(height: KSizes.md),
                            SalaryInputWidget(
                              title: "Expected Salary",
                              selectedCurrency: _selectedExpectedSalaryCurrency,
                              selectedValue: _selectedExpectedSalaryValue,
                              selectedDuration: _selectedExpectedSalaryDuration,
                              amountController: expectedSalaryController,
                              onCurrencyChanged: (value) => setState(() =>
                                  _selectedExpectedSalaryCurrency = value),
                              onValueChanged: (value) => setState(
                                  () => _selectedExpectedSalaryValue = value),
                              onDurationChanged: (value) => setState(() =>
                                  _selectedExpectedSalaryDuration = value),
                              currencies: _currency,
                              values: _value,
                              durations: _duration,
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

class SalaryInputWidget extends StatelessWidget {
  final String title;
  final String? selectedCurrency;
  final String? selectedValue;
  final String? selectedDuration;
  final TextEditingController amountController;
  final Function(String?) onCurrencyChanged;
  final Function(String?) onValueChanged;
  final Function(String?) onDurationChanged;
  final List<String> currencies;
  final List<String> values;
  final List<String> durations;

  const SalaryInputWidget({
    Key? key,
    required this.title,
    required this.selectedCurrency,
    required this.selectedValue,
    required this.selectedDuration,
    required this.amountController,
    required this.onCurrencyChanged,
    required this.onValueChanged,
    required this.onDurationChanged,
    required this.currencies,
    required this.values,
    required this.durations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        SizedBox(height: KSizes.sm),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                value: selectedCurrency,
                dropdownColor: KColors.white,
                icon: Icon(Icons.keyboard_arrow_down_outlined),
                hint: Text('Currency'),
                validator: (value) =>
                    KValidator.validateEmptyText("Currency", value),
                items: currencies
                    .map((currency) => DropdownMenuItem(
                          value: currency,
                          child: Text(currency),
                        ))
                    .toList(),
                onChanged: onCurrencyChanged,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            SizedBox(width: KSizes.sm),
            Expanded(
              child: DropdownButtonFormField<String>(
                value: selectedValue,
                dropdownColor: KColors.white,
                icon: Icon(Icons.keyboard_arrow_down_outlined),
                hint: Text('Value'),
                validator: (value) =>
                    KValidator.validateEmptyText("Value", value),
                items: values
                    .map((value) => DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        ))
                    .toList(),
                onChanged: onValueChanged,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
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
                controller: amountController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: KSizes.fontSizeSm),
                validator: (value) =>
                    KValidator.validateEmptyText("Amount", value),
                decoration: const InputDecoration(
                  labelText: "Amount",
                ),
              ),
            ),
            SizedBox(width: KSizes.sm),
            Expanded(
              child: DropdownButtonFormField<String>(
                value: selectedDuration,
                dropdownColor: KColors.white,
                icon: Icon(Icons.keyboard_arrow_down_outlined),
                hint: Text('Duration'),
                validator: (value) =>
                    KValidator.validateEmptyText("Duration", value),
                items: durations
                    .map((duration) => DropdownMenuItem(
                          value: duration,
                          child: Text(duration),
                        ))
                    .toList(),
                onChanged: onDurationChanged,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
