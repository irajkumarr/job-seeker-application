import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/alert_box/snackbar.dart';
import 'package:frontend/common/widgets/custom_screen/custom_screen.dart';
import 'package:frontend/common/widgets/loaders/full_screen_overlay.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/divider/dotted_divider.dart';
import 'package:frontend/core/utils/validators/validation.dart';
import 'package:frontend/data/models/education_model.dart' as educationModel;
import 'package:frontend/data/models/profile_detail_model.dart';
import 'package:frontend/features/personalization/providers/education_provider.dart';
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

  // @override
  // void initState() {
  //   super.initState();
  //   if (widget.experience != null) {
  //     _selectedEducationQualification = widget.education!.level;
  //     _educationProgramController.text =
  //         widget.education!.educationProgram ?? '';
  //     _educationBoardController.text = widget.education!.educationBoard ?? '';
  //     _instituteNameController.text = widget.education!.institution ?? '';

  //     // Determine if the user is currently studying (graduationYear == null)
  //     _isCurrentlyStudying = widget.education!.graduationYear == null;

  //     if (_isCurrentlyStudying) {
  //       // If currently studying, set start date
  //       _selectedYear = widget.education!.startDate?.year;
  //       _selectedMonth = widget.education!.startDate?.month;
  //     } else {
  //       // If not currently studying, set graduation year
  //       _selectedYear = widget.education!.graduationYear?.year;
  //       _selectedMonth = widget.education!.graduationYear?.month;

  //       // Set grade details
  //       _selectedGradeType = widget.education!.grade?.type;
  //       _marksController.text = widget.education!.grade?.marks ?? '';
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final educationProvider = Provider.of<EducationProvider>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);
    return FullScreenOverlay(
      isLoading: educationProvider.isLoading,
      child: CustomScreen(
        onPressed: () {
          if (_selectedJobLevel == null) {
            KSnackbar.CustomSnackbar(
                context, "Please select a job level", KColors.error);
            return;
          }
          if (_formKey.currentState!.validate()) {
            //   if (widget.experience == null) {
            //     educationModel.EducationModel model =
            //         educationModel.EducationModel(
            //       level: _selectedEducationQualification?.trim(),
            //       educationProgram: _educationProgramController.text.trim(),
            //       educationBoard: _educationBoardController.text.trim(),
            //       institution: _instituteNameController.text.trim(),

            //       // Set startDate only if user is currently studying
            //       startDate: _isCurrentlyStudying
            //           ? educationModel.GraduationYear(
            //               year: _selectedYear?.trim() ?? '',
            //               month: _selectedMonth?.trim() ?? '',
            //             )
            //           : null,

            //       // Set graduationYear only if user is NOT currently studying
            //       graduationYear: !_isCurrentlyStudying
            //           ? educationModel.GraduationYear(
            //               year: _selectedYear?.trim() ?? '',
            //               month: _selectedMonth?.trim() ?? '',
            //             )
            //           : null,

            //       // Set grade only if user is NOT currently studying
            //       grade: !_isCurrentlyStudying
            //           ? educationModel.Grade(
            //               type: _selectedGradeType?.trim(),
            //               marks: _marksController.text.trim(),
            //             )
            //           : null,
            //     );

            //     String data = educationModel.educationModelToJson(model);
            //     educationProvider.addEducation(context, data, () async {
            //       await profileProvider.fetchProfile(forceRefresh: true);
            //       context.pop();
            //     });
            //   } else {
            //     educationModel.EducationModel model =
            //         educationModel.EducationModel(
            //       level: _selectedEducationQualification?.trim(),
            //       educationProgram: _educationProgramController.text.trim(),
            //       educationBoard: _educationBoardController.text.trim(),
            //       institution: _instituteNameController.text.trim(),

            //       // Set startDate only if user is currently studying
            //       startDate: _isCurrentlyStudying
            //           ? educationModel.GraduationYear(
            //               year: _selectedYear?.trim() ?? '',
            //               month: _selectedMonth?.trim() ?? '',
            //             )
            //           : null,

            //       // Set graduationYear only if user is NOT currently studying
            //       graduationYear: !_isCurrentlyStudying
            //           ? educationModel.GraduationYear(
            //               year: _selectedYear?.trim() ?? '',
            //               month: _selectedMonth?.trim() ?? '',
            //             )
            //           : null,

            //       // Set grade only if user is NOT currently studying
            //       grade: !_isCurrentlyStudying
            //           ? educationModel.Grade(
            //               type: _selectedGradeType?.trim(),
            //               marks: _marksController.text.trim(),
            //             )
            //           : null,
            //     );

            //     String data = educationModel.educationModelToJson(model);
            //     educationProvider.updateEducation(
            //         context, widget.education!.id!, data, () async {
            //       await profileProvider.fetchProfile(forceRefresh: true);
            //       context.pop();
            //     });
            //   }
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
                                  validator: (value) =>
                                      KValidator.validateEmptyText(
                                          "Year", value),
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
                      rolesController: _rolesController,
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
