import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/alert_box/snackbar.dart';
import 'package:frontend/common/widgets/custom_screen/custom_screen.dart';
import 'package:frontend/common/widgets/loaders/full_screen_overlay.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/divider/dotted_divider.dart';
import 'package:frontend/core/utils/validators/validation.dart';
import 'package:frontend/data/models/user_profile_request.dart';
import 'package:frontend/features/authentication/providers/details_provider.dart';
import 'package:frontend/features/authentication/providers/location_provider.dart';
import 'package:frontend/features/authentication/providers/signup_provider.dart';
import 'package:frontend/features/authentication/screens/signup/personal_details_screen.dart';
import 'package:frontend/features/dashboard/providers/category_provider.dart';
import 'package:frontend/features/personalization/providers/profile_provider.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProfilePersonalInformation extends StatefulWidget {
  const ProfilePersonalInformation({super.key});

  @override
  State<ProfilePersonalInformation> createState() =>
      _ProfilePersonalInformationState();
}

class _ProfilePersonalInformationState
    extends State<ProfilePersonalInformation> {
  String? _selectedCurrentSalaryCurrency;
  String? _selectedExpectedSalaryCurrency;
  String? _selectedCurrentSalaryValue;
  String? _selectedExpectedSalaryValue;
  String? _selectedCurrentSalaryDuration;
  String? _selectedExpectedSalaryDuration;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
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

  bool _haveDisability = false;

  @override
  void initState() {
    super.initState();
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    final detailProvider = Provider.of<DetailsProvider>(context, listen: false);

    final profile = profileProvider.profile?.profile?.isNotEmpty == true
        ? profileProvider.profile!.profile![0]
        : null;
    detailProvider.selectedGender = profile?.personalDetails?.gender;
    detailProvider.selectedMaritalStatus =
        profile?.personalDetails?.maritalStatus;
    detailProvider.selectedNationality = profile?.personalDetails?.nationality;
    detailProvider.ageCounter = profile?.personalDetails?.age ?? 16;
    detailProvider.selectedReligion = profile?.personalDetails?.religion;
    detailProvider.selectedDisability =
        profile?.personalDetails?.disability?.details;
    _haveDisability =
        profile?.personalDetails?.disability?.hasDisability ?? false;
    _emailController.text = profile?.personalDetails?.email ?? "";
    _nameController.text = profileProvider.profile?.name ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final detailProvider = Provider.of<DetailsProvider>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);
    final l10n = AppLocalizations.of(context)!;
    bool _validateInputs(BuildContext context, DetailsProvider detailProvider) {
      if (detailProvider.selectedGender == null ||
          detailProvider.selectedMaritalStatus == null ||
          detailProvider.selectedNationality == null ||
          detailProvider.selectedNationality == null ||
          detailProvider.selectedReligion == null) {
        KSnackbar.CustomSnackbar(
          context,
          "${l10n.please_select_required_fields}",
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
            PersonalDetails model = PersonalDetails(
              age: detailProvider.ageCounter,
              experience: profileProvider
                      .profile?.profile?[0].personalDetails?.experience ??
                  0,
              gender: detailProvider.selectedGender,
              religion: detailProvider.selectedReligion ?? "",
              nationality: detailProvider.selectedNationality ?? "",
              maritalStatus: detailProvider.selectedMaritalStatus ?? "",
              email: _emailController.text.trim(),
              disability: Disability(
                hasDisability: _haveDisability,
                details: detailProvider.selectedDisability ?? "",
              ),
              foreignEmployment: ForeignEmployment(
                hasWorkedAboroad: profileProvider.profile?.profile?[0]
                        .personalDetails?.foreignEmployment?.hasWorkedAboroad ??
                    false,
                details: profileProvider.profile?.profile?[0].personalDetails
                        ?.foreignEmployment?.details ??
                    "",
              ),
            );
            print(detailProvider.selectedReligion);
            try {
              await profileProvider.updateName(
                  context, _nameController.text.trim(), () {});
              await profileProvider.updatePersonalInformation(context, model,
                  () async {
                await profileProvider.fetchProfile(forceRefresh: true);
                detailProvider.reset();
                context.pop();
              });
            } catch (error) {
              print("Error updating profile: $error");
            }
          }
        },
        buttonText: "${l10n.submit}",
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
                        "${l10n.personal_information}",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      SizedBox(height: KSizes.defaultSpace),
                      //working status, preferred shift, job level, available for come here
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // text field for name
                            //name
                            TextFormField(
                              controller: _nameController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontSize: KSizes.fontSizeSm),
                              validator: (value) =>
                                  KValidator.validateEmptyText(
                                      "${l10n.full_name}", value),
                              decoration: InputDecoration(
                                labelText: "${l10n.full_name}",
                              ),
                            ),
                            SizedBox(height: KSizes.md),
                            DottedDivider(),
                            SizedBox(height: KSizes.md),
                            //gender
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${l10n.gender}",
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
                                  children: detailProvider.gender.map((gender) {
                                    final isSelected =
                                        detailProvider.selectedGender == gender;

                                    return GestureDetector(
                                      onTap: () {
                                        if (detailProvider.selectedGender ==
                                            gender) {
                                          detailProvider
                                              .setSelectedGender(null);
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
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                            SizedBox(height: KSizes.md),
                            DottedDivider(),
                            SizedBox(height: KSizes.md),
                            //age
                            Consumer<DetailsProvider>(
                                builder: (context, detailProvider, child) {
                              return CounterWithTextWidget(
                                text: "${l10n.age}",
                                isRequired: false,
                                value: detailProvider.ageCounter
                                    .toStringAsFixed(0),
                                incrementPressed:
                                    detailProvider.incrementAgeCounter,
                                decrementPressed:
                                    detailProvider.decrementAgeCounter,
                              );
                            }),
                            SizedBox(height: KSizes.md),
                            //marital status
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${l10n.marital_status}",
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
                                  children: detailProvider.maritalStatus
                                      .map((maritalStatus) {
                                    final isSelected =
                                        detailProvider.selectedMaritalStatus ==
                                            maritalStatus;

                                    return GestureDetector(
                                      onTap: () {
                                        if (detailProvider
                                                .selectedMaritalStatus ==
                                            maritalStatus) {
                                          detailProvider
                                              .setSelectedMaritalStatus(null);
                                        } else {
                                          detailProvider
                                              .setSelectedMaritalStatus(
                                                  maritalStatus);
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
                                          maritalStatus,
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
                            //Nationality
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${l10n.nationality}",
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
                                  children: detailProvider.nationality
                                      .map((nationality) {
                                    final isSelected =
                                        detailProvider.selectedNationality ==
                                            nationality;

                                    return GestureDetector(
                                      onTap: () {
                                        if (detailProvider
                                                .selectedNationality ==
                                            nationality) {
                                          detailProvider
                                              .setSelectedNationality(null);
                                        } else {
                                          detailProvider.setSelectedNationality(
                                              nationality);
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
                                          nationality,
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
                            //Religion
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${l10n.religion}",
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
                                      detailProvider.religion.map((religion) {
                                    final isSelected =
                                        detailProvider.selectedReligion ==
                                            religion;

                                    return GestureDetector(
                                      onTap: () {
                                        if (detailProvider.selectedReligion ==
                                            religion) {
                                          detailProvider
                                              .setSelectedReligion(null);
                                        } else {
                                          detailProvider
                                              .setSelectedReligion(religion);
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
                                          religion,
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
                            //email
                            TextFormField(
                              controller: _emailController,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.emailAddress,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontSize: KSizes.fontSizeSm),
                              validator: (value) =>
                                  KValidator.validateEmail(value),
                              decoration: InputDecoration(
                                labelText: "${l10n.email}",
                              ),
                            ),

                            SizedBox(height: KSizes.md),
                            DottedDivider(),
                            SizedBox(height: KSizes.md),
                            //disability
                            Row(
                              children: [
                                Text(
                                  "${l10n.is_there_any_disability}",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                Spacer(),
                                Switch(
                                  value: _haveDisability,
                                  onChanged: (value) {
                                    setState(() {
                                      _haveDisability = value;
                                    });
                                  },
                                  activeColor: KColors.primary,
                                ),
                              ],
                            ),
                            SizedBox(height: KSizes.md),
                            if (_haveDisability) ...[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${l10n.disablity}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: KSizes.md),
                                  Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    children: detailProvider.disability
                                        .map((disability) {
                                      final isSelected =
                                          detailProvider.selectedDisability ==
                                              disability;

                                      return GestureDetector(
                                        onTap: () {
                                          if (detailProvider
                                                  .selectedDisability ==
                                              disability) {
                                            detailProvider
                                                .setSelectedDisability(null);
                                          } else {
                                            detailProvider
                                                .setSelectedDisability(
                                                    disability);
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
                                            disability,
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
                            ],
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
