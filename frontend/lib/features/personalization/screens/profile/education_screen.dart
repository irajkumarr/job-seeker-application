import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import 'package:frontend/l10n/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({super.key, this.education, this.isRemoved = false});
  final Education? education;
  final bool isRemoved;
  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  final List<String> _educationQualification = [
    "Cannot Read and Write",
    "Can Read and Write",
    "8 Class Pass",
    "S.L.C/ S.E.E Pass",
    "+2/ Intermediate Pass",
    "Diploma",
    "Bachelor's Degree",
    "Master's Degree",
    "Ph.D. Degree",
  ];
  final List<String> _gradeType = [
    "CGPA",
    "Percentage",
  ];

  String? _selectedEducationQualification;

  String? _selectedGradeType;

  bool _isCurrentlyStudying = false;
  final TextEditingController _educationProgramController =
      TextEditingController();
  final TextEditingController _educationBoardController =
      TextEditingController();
  final TextEditingController _instituteNameController =
      TextEditingController();
  final TextEditingController _marksController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _selectedYear;
  String? _selectedMonth;

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

  bool _shouldShowForm() {
    return _selectedEducationQualification != null &&
        _selectedEducationQualification != "Cannot Read and Write" &&
        _selectedEducationQualification != "Can Read and Write";
  }

  void _updateQualifications() {
    // If isRemoved is true, remove the restricted qualifications
    if (widget.isRemoved) {
      _educationQualification.remove("Cannot Read and Write");
      _educationQualification.remove("Can Read and Write");
    }
  }

  @override
  void initState() {
    super.initState();
    _updateQualifications();
    if (widget.education != null) {
      _selectedEducationQualification = widget.education!.level;
      _educationProgramController.text =
          widget.education!.educationProgram ?? '';
      _educationBoardController.text = widget.education!.educationBoard ?? '';
      _instituteNameController.text = widget.education!.institution ?? '';

      // Determine if the user is currently studying (graduationYear == null)
      _isCurrentlyStudying = widget.education!.graduationYear == null;

      if (_isCurrentlyStudying) {
        // If currently studying, set start date
        _selectedYear = widget.education!.startDate?.year;
        _selectedMonth = widget.education!.startDate?.month;
      } else {
        // If not currently studying, set graduation year
        _selectedYear = widget.education!.graduationYear?.year;
        _selectedMonth = widget.education!.graduationYear?.month;

        // Set grade details
        _selectedGradeType = widget.education!.grade?.type;
        _marksController.text = widget.education!.grade?.marks ?? '';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final educationProvider = Provider.of<EducationProvider>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);
    return FullScreenOverlay(
      isLoading: educationProvider.isLoading,
      child: CustomScreen(
        onPressed: () {
          if (_selectedEducationQualification == null) {
            KSnackbar.CustomSnackbar(context,
                "${l10n.select_education_qualification}", KColors.error);
            return;
          }
          if (!_shouldShowForm() || _formKey.currentState!.validate()) {
            if (widget.education == null) {
              educationModel.EducationModel model =
                  educationModel.EducationModel(
                level: _selectedEducationQualification?.trim(),
                educationProgram: _educationProgramController.text.trim(),
                educationBoard: _educationBoardController.text.trim(),
                institution: _instituteNameController.text.trim(),

                // Set startDate only if user is currently studying
                startDate: _isCurrentlyStudying
                    ? educationModel.GraduationYear(
                        year: _selectedYear?.trim() ?? '',
                        month: _selectedMonth?.trim() ?? '',
                      )
                    : null,

                // Set graduationYear only if user is NOT currently studying
                graduationYear: !_isCurrentlyStudying
                    ? educationModel.GraduationYear(
                        year: _selectedYear?.trim() ?? '',
                        month: _selectedMonth?.trim() ?? '',
                      )
                    : null,

                // Set grade only if user is NOT currently studying
                grade: !_isCurrentlyStudying
                    ? educationModel.Grade(
                        type: _selectedGradeType?.trim(),
                        marks: _marksController.text.trim(),
                      )
                    : null,
              );

              String data = educationModel.educationModelToJson(model);
              educationProvider.addEducation(context, data, () async {
                await profileProvider.fetchProfile(forceRefresh: true);
                context.pop();
              });
            } else {
              educationModel.EducationModel model =
                  educationModel.EducationModel(
                level: _selectedEducationQualification?.trim(),
                educationProgram: _educationProgramController.text.trim(),
                educationBoard: _educationBoardController.text.trim(),
                institution: _instituteNameController.text.trim(),

                // Set startDate only if user is currently studying
                startDate: _isCurrentlyStudying
                    ? educationModel.GraduationYear(
                        year: _selectedYear?.trim() ?? '',
                        month: _selectedMonth?.trim() ?? '',
                      )
                    : null,

                // Set graduationYear only if user is NOT currently studying
                graduationYear: !_isCurrentlyStudying
                    ? educationModel.GraduationYear(
                        year: _selectedYear?.trim() ?? '',
                        month: _selectedMonth?.trim() ?? '',
                      )
                    : null,

                // Set grade only if user is NOT currently studying
                grade: !_isCurrentlyStudying
                    ? educationModel.Grade(
                        type: _selectedGradeType?.trim(),
                        marks: _marksController.text.trim(),
                      )
                    : null,
              );

              String data = educationModel.educationModelToJson(model);
              educationProvider.updateEducation(
                  context, widget.education!.id!, data, () async {
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
                "${l10n.education}",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
              SizedBox(height: KSizes.md),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "${l10n.add_education}",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              fontSize: 18.sp,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(height: KSizes.sm),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children:
                        _educationQualification.map((educationQualification) {
                      final isSelected = _selectedEducationQualification ==
                          educationQualification;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (_selectedEducationQualification ==
                                educationQualification) {
                              _selectedEducationQualification = null;
                            } else {
                              _selectedEducationQualification =
                                  educationQualification;
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
              SizedBox(height: KSizes.md),
              if (_selectedEducationQualification != null &&
                  _shouldShowForm()) ...[
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _educationProgramController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontSize: KSizes.fontSizeSm),
                        validator: (value) => KValidator.validateEmptyText(
                            "${l10n.education_program}", value),
                        decoration: InputDecoration(
                          labelText: "${l10n.education_program}",
                        ),
                      ),
                      SizedBox(height: KSizes.sm),
                      DottedDivider(),
                      SizedBox(height: KSizes.sm),
                      TextFormField(
                        controller: _educationBoardController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontSize: KSizes.fontSizeSm),
                        validator: (value) => KValidator.validateEmptyText(
                            "${l10n.education_board}", value),
                        decoration: InputDecoration(
                          labelText: "${l10n.education_board}",
                        ),
                      ),
                      SizedBox(height: KSizes.md),
                      TextFormField(
                        controller: _instituteNameController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontSize: KSizes.fontSizeSm),
                        validator: (value) => KValidator.validateEmptyText(
                            "${l10n.name_of_institute}", value),
                        decoration: InputDecoration(
                          labelText: "${l10n.name_of_institute}",
                        ),
                      ),
                      SizedBox(height: KSizes.sm),
                      DottedDivider(),
                      SizedBox(height: KSizes.sm),
                      Row(
                        children: [
                          Text(
                            "${l10n.currently_studying}",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Spacer(),
                          Switch(
                            value: _isCurrentlyStudying,
                            onChanged: (value) {
                              setState(() {
                                _isCurrentlyStudying = value;
                              });
                            },
                            activeColor: KColors.primary,
                          ),
                        ],
                      ),
                      SizedBox(height: KSizes.md),
                      if (_isCurrentlyStudying) ...[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${l10n.started_year}",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            SizedBox(height: KSizes.sm),
                            Row(
                              children: [
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    value: _selectedYear,
                                    dropdownColor: KColors.white,
                                    icon: Icon(
                                        Icons.keyboard_arrow_down_outlined),
                                    hint: Text('${l10n.year}'),
                                    validator: (value) =>
                                        KValidator.validateEmptyText(
                                            "${l10n.year}", value),
                                    items: _years
                                        .map((year) => DropdownMenuItem(
                                              value: year,
                                              child: Text(year),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedYear = value;
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
                                    value: _selectedMonth,
                                    dropdownColor: KColors.white,
                                    icon: Icon(
                                        Icons.keyboard_arrow_down_outlined),
                                    hint: Text('${l10n.month}'),
                                    validator: (value) =>
                                        KValidator.validateEmptyText(
                                            "${l10n.month}", value),
                                    items: _months
                                        .map((month) => DropdownMenuItem(
                                              value: month,
                                              child: Text(month),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedMonth = value;
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
                      ] else ...[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${l10n.graduation_year}",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            SizedBox(height: KSizes.sm),
                            Row(
                              children: [
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    value: _selectedYear,
                                    dropdownColor: KColors.white,
                                    icon: Icon(
                                        Icons.keyboard_arrow_down_outlined),
                                    hint: Text('${l10n.year}'),
                                    validator: (value) =>
                                        KValidator.validateEmptyText(
                                            "${l10n.year}", value),
                                    items: _years
                                        .map((year) => DropdownMenuItem(
                                              value: year,
                                              child: Text(year),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedYear = value;
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
                                    value: _selectedMonth,
                                    dropdownColor: KColors.white,
                                    icon: Icon(
                                        Icons.keyboard_arrow_down_outlined),
                                    hint: Text('${l10n.month}'),
                                    validator: (value) =>
                                        KValidator.validateEmptyText(
                                            "${l10n.month}", value),
                                    items: _months
                                        .map((month) => DropdownMenuItem(
                                              value: month,
                                              child: Text(month),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedMonth = value;
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
                            SizedBox(height: KSizes.md),
                            Row(
                              children: [
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    value: _selectedGradeType,
                                    dropdownColor: KColors.white,
                                    icon: Icon(
                                        Icons.keyboard_arrow_down_outlined),
                                    hint: Text('${l10n.grade_type}'),
                                    validator: (value) =>
                                        KValidator.validateEmptyText(
                                            "${l10n.grade_type}", value),
                                    items: _gradeType
                                        .map((type) => DropdownMenuItem(
                                              value: type,
                                              child: Text(type),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedGradeType = value;
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
                                  child: TextFormField(
                                    controller: _marksController,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.text,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(fontSize: KSizes.fontSizeSm),
                                    validator: (value) {
                                      if (_selectedGradeType == null) {
                                        return '${l10n.select_grade_type}';
                                      }
                                      if (value == null || value.isEmpty) {
                                        return '${l10n.please_enter_marks}';
                                      }
                                      final marks = double.tryParse(value);
                                      if (marks == null) {
                                        return '${l10n.please_enter_valid_number}';
                                      }
                                      if (_selectedGradeType == "Percentage" &&
                                          (marks < 0 || marks > 100)) {
                                        return '${l10n.percentage_must_be}';
                                      }
                                      if (_selectedGradeType == "CGPA" &&
                                          (marks < 0 || marks > 4)) {
                                        return '${l10n.cgpa_must_be}';
                                      }
                                      return null; // No error
                                    },
                                    decoration: InputDecoration(
                                      labelText: "${l10n.marks_secured}",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                      SizedBox(height: KSizes.defaultSpace * 3),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _educationProgramController.dispose();
    _educationBoardController.dispose();
    _instituteNameController.dispose();
    super.dispose();
  }
}
