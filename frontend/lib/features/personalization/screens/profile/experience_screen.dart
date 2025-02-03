import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/alert_box/snackbar.dart';
import 'package:frontend/common/widgets/custom_screen/custom_screen.dart';
import 'package:frontend/common/widgets/loaders/full_screen_overlay.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/divider/dotted_divider.dart';
import 'package:frontend/core/utils/validators/validation.dart';
import 'package:frontend/data/models/experience_model.dart' as experienceModel;
import 'package:frontend/data/models/profile_detail_model.dart';
import 'package:frontend/features/personalization/providers/experience_provider.dart';
import 'package:frontend/features/personalization/providers/profile_provider.dart';
import 'package:frontend/features/personalization/screens/profile/widgets/text_editor_widget.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ExperienceScreen extends StatefulWidget {
  const ExperienceScreen({super.key, this.experience});
  final Experience? experience;
  @override
  State<ExperienceScreen> createState() => _ExperienceScreenState();
}

class _ExperienceScreenState extends State<ExperienceScreen> {
  final List<String> _jobLevel = [
    "Top Level",
    "Senior Level",
    "Mid Level",
    "Entry Level",
  ];

  String? _selectedJobLevel;

  bool _isCurrentlyWorking = false;
  final TextEditingController _organizationNameController =
      TextEditingController();
  final TextEditingController _industryController = TextEditingController();
  final TextEditingController _jobCategoryController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _rolesController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _selectedStartYear;
  String? _selectedStartMonth;
  String? _selectedEndYear;
  String? _selectedEndMonth;

  // Generate list of years (e.g., last 50 years)
  List<String> _years = List.generate(
    50,
    (index) => (DateTime.now().year - index).toString(),
  );

  // List of months
  final List<String> _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  @override
  void initState() {
    super.initState();

    if (widget.experience != null) {
      _organizationNameController.text =
          widget.experience!.organizationName ?? '';
      _industryController.text = widget.experience!.industry ?? '';
      _jobCategoryController.text = widget.experience!.jobCategory ?? '';
      _locationController.text = widget.experience!.location ?? '';
      _designationController.text = widget.experience!.designation ?? '';
      _rolesController.text = widget.experience!.rolesAndResponsibilities ?? '';
      _selectedJobLevel = widget.experience!.jobLevel;
      _isCurrentlyWorking = widget.experience!.currentlyWorking ?? false;
      _selectedStartYear = widget.experience!.startDate?.year ?? "";
      _selectedStartMonth = widget.experience!.startDate?.month ?? "";
      // _selectedEndYear = widget.experience!.endDate?.year ?? "";
      // _selectedEndMonth = widget.experience!.endDate?.month ?? "";
      if (_isCurrentlyWorking) {
        _selectedEndYear = null;
        _selectedEndMonth = null;
      } else {
        _selectedEndYear = widget.experience!.endDate?.year;
        _selectedEndMonth = widget.experience!.endDate?.month;
      }
    }
  }

  String? validateEndDate(String? value) {
    if (_isCurrentlyWorking) return null; // No validation needed

    if (_selectedStartYear == null || _selectedStartMonth == null) {
      return "Select start date first";
    }

    if (_selectedEndYear == null || _selectedEndMonth == null) {
      return "Select end date";
    }

    try {
      int startYear = int.parse(_selectedStartYear!);
      int startMonth =
          _months.indexOf(_selectedStartMonth!) + 1; // Convert to number
      int endYear = int.parse(_selectedEndYear!);
      int endMonth =
          _months.indexOf(_selectedEndMonth!) + 1; // Convert to number

      if (startMonth == 0 || endMonth == 0) return "Invalid month selection";

      DateTime startDate = DateTime(startYear, startMonth);
      DateTime endDate = DateTime(endYear, endMonth);

      if (!endDate.isAfter(startDate)) {
        return "End date must be after start date";
      }

      return null; // Valid
    } catch (e) {
      return "Invalid date format";
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final experienceProvider = Provider.of<ExperienceProvider>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);
    return FullScreenOverlay(
      isLoading: experienceProvider.isLoading,
      child: CustomScreen(
        onPressed: () {
          if (_selectedJobLevel == null) {
            KSnackbar.CustomSnackbar(
                context, "Please select a job level", KColors.error);
            return;
          }
          if (_formKey.currentState!.validate()) {
            if (widget.experience == null) {
              experienceModel.ExperienceModel model =
                  experienceModel.ExperienceModel(
                organizationName: _organizationNameController.text.trim(),
                industry: _industryController.text.trim(),
                jobCategory: _jobCategoryController.text.trim(),
                location: _locationController.text.trim(),
                designation: _designationController.text.trim(),
                rolesAndResponsibilities: _rolesController.text.trim(),
                jobLevel: _selectedJobLevel?.trim() ?? "",
                currentlyWorking: _isCurrentlyWorking,
                startDate: experienceModel.Date(
                  year: _selectedStartYear?.trim() ?? '',
                  month: _selectedStartMonth?.trim() ?? '',
                ),
                endDate: !_isCurrentlyWorking
                    ? experienceModel.Date(
                        year: _selectedEndYear?.trim() ?? '',
                        month: _selectedEndMonth?.trim() ?? '',
                      )
                    : null,
              );

              String data = experienceModel.experienceModelToJson(model);
              experienceProvider.addExperience(context, data, () async {
                await profileProvider.fetchProfile(forceRefresh: true);
                context.pop();
              });
            } else {
              experienceModel.ExperienceModel model =
                  experienceModel.ExperienceModel(
                organizationName: _organizationNameController.text.trim(),
                industry: _industryController.text.trim(),
                jobCategory: _jobCategoryController.text.trim(),
                location: _locationController.text.trim(),
                designation: _designationController.text.trim(),
                rolesAndResponsibilities: _rolesController.text.trim(),
                jobLevel: _selectedJobLevel?.trim() ?? "",
                currentlyWorking: _isCurrentlyWorking,
                startDate: experienceModel.Date(
                  year: _selectedStartYear?.trim() ?? '',
                  month: _selectedStartMonth?.trim() ?? '',
                ),
                endDate: experienceModel.Date(
                  year: _selectedEndYear?.trim() ?? '',
                  month: _selectedEndMonth?.trim() ?? '',
                ),
              );

              String data = experienceModel.experienceModelToJson(model);
              experienceProvider.updateExperience(
                  context, widget.experience!.id!, data, () async {
                await profileProvider.fetchProfile(forceRefresh: true);
                context.pop();
              });
            }
          }
        },
        buttonText: l10n.submit,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: KSizes.md, vertical: KSizes.defaultSpace),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Work Experience",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
              SizedBox(height: KSizes.md),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _organizationNameController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: KSizes.fontSizeSm),
                      validator: (value) => KValidator.validateEmptyText(
                          "Organization Name", value),
                      decoration: InputDecoration(
                        labelText: "Organization Name",
                      ),
                    ),
                    SizedBox(height: KSizes.md),
                    TextFormField(
                      controller: _industryController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: KSizes.fontSizeSm),
                      validator: (value) =>
                          KValidator.validateEmptyText("Industry", value),
                      decoration: InputDecoration(
                        labelText: "Industry",
                      ),
                    ),
                    SizedBox(height: KSizes.md),
                    TextFormField(
                      controller: _jobCategoryController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: KSizes.fontSizeSm),
                      validator: (value) =>
                          KValidator.validateEmptyText("Job Category", value),
                      decoration: InputDecoration(
                        labelText: "Job Category",
                      ),
                    ),
                    SizedBox(height: KSizes.md),
                    TextFormField(
                      controller: _locationController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: KSizes.fontSizeSm),
                      validator: (value) =>
                          KValidator.validateEmptyText("Location", value),
                      decoration: InputDecoration(
                        labelText: "Location",
                      ),
                    ),
                    SizedBox(height: KSizes.md),
                    TextFormField(
                      controller: _designationController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: KSizes.fontSizeSm),
                      validator: (value) =>
                          KValidator.validateEmptyText("Designation", value),
                      decoration: InputDecoration(
                        labelText: "Designation",
                      ),
                    ),
                    SizedBox(height: KSizes.sm),
                    DottedDivider(),
                    SizedBox(height: KSizes.sm),
                    Text(
                      "Job Level",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    SizedBox(height: KSizes.sm),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: _jobLevel.map((jobLevel) {
                        final isSelected = _selectedJobLevel == jobLevel;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (_selectedJobLevel == jobLevel) {
                                _selectedJobLevel = null;
                              } else {
                                _selectedJobLevel = jobLevel;
                              }
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            decoration: BoxDecoration(
                              color:
                                  isSelected ? KColors.secondary : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color:
                                    isSelected ? KColors.primary : KColors.grey,
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
                    SizedBox(height: KSizes.sm),
                    DottedDivider(),
                    SizedBox(height: KSizes.sm),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Started Date",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        SizedBox(height: KSizes.sm),
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                value: _selectedStartYear,
                                dropdownColor: KColors.white,
                                icon: Icon(Icons.keyboard_arrow_down_outlined),
                                hint: Text('Year'),
                                validator: (value) =>
                                    KValidator.validateEmptyText("Year", value),
                                items: _years
                                    .map((year) => DropdownMenuItem(
                                          value: year,
                                          child: Text(year),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedStartYear = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 12),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: KSizes.sm),
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                value: _selectedStartMonth,
                                dropdownColor: KColors.white,
                                icon: Icon(Icons.keyboard_arrow_down_outlined),
                                hint: Text('Month'),
                                validator: (value) =>
                                    KValidator.validateEmptyText(
                                        "Month", value),
                                items: _months
                                    .map((month) => DropdownMenuItem(
                                          value: month,
                                          child: Text(month),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedStartMonth = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 12),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: KSizes.sm),
                    Row(
                      children: [
                        Text(
                          "Are you currently working here?",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Spacer(),
                        Switch(
                          value: _isCurrentlyWorking,
                          onChanged: (value) {
                            setState(() {
                              _isCurrentlyWorking = value;
                            });
                          },
                          activeColor: KColors.primary,
                        ),
                      ],
                    ),
                    SizedBox(height: KSizes.sm),
                    if (!_isCurrentlyWorking) ...[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "End Date",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          SizedBox(height: KSizes.sm),
                          Row(
                            children: [
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  value: _selectedEndYear,
                                  dropdownColor: KColors.white,
                                  icon:
                                      Icon(Icons.keyboard_arrow_down_outlined),
                                  hint: Text('Year'),
                                  // validator: (value) =>
                                  //     KValidator.validateEmptyText(
                                  //         "Year", value),
                                  validator: validateEndDate,
                                  items: _years
                                      .map((year) => DropdownMenuItem(
                                            value: year,
                                            child: Text(year),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedEndYear = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 12),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: KSizes.sm),
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  value: _selectedEndMonth,
                                  dropdownColor: KColors.white,
                                  icon:
                                      Icon(Icons.keyboard_arrow_down_outlined),
                                  hint: Text('Month'),
                                  // validator: (value) =>
                                  //     KValidator.validateEmptyText(
                                  //         "Month", value),

                                  validator: validateEndDate,
                                  items: _months
                                      .map((month) => DropdownMenuItem(
                                            value: month,
                                            child: Text(month),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedEndMonth = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 12),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                    SizedBox(height: KSizes.sm),
                    DottedDivider(),
                    SizedBox(height: KSizes.sm),
                    TextEditorWidget(
                      title: "Roles and Responsibilities",
                      controller: _rolesController,
                    ),
                    SizedBox(height: KSizes.defaultSpace * 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
