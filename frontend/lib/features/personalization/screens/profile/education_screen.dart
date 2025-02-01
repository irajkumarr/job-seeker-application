import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/alert_box/snackbar.dart';
import 'package:frontend/common/widgets/custom_screen/custom_screen.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/divider/dotted_divider.dart';
import 'package:frontend/core/utils/validators/validation.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:provider/provider.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return CustomScreen(
      onPressed: () {
        if (_selectedEducationQualification == null) {
          KSnackbar.CustomSnackbar(context,
              "Please select an education qualification", KColors.error);
          return;
        }
        if (!_shouldShowForm() || _formKey.currentState!.validate()) {
          // Handle form submission
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
              "Education",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
            ),
            SizedBox(height: KSizes.md),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add Education",
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontSize: 18.sp,
                      ),
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
                          color: isSelected ? KColors.secondary : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected ? KColors.primary : KColors.grey,
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
                          "Education Program", value),
                      decoration: InputDecoration(
                        labelText: "Education Program",
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
                          "Education Board", value),
                      decoration: InputDecoration(
                        labelText: "Education Board",
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
                          "Name of Institute", value),
                      decoration: InputDecoration(
                        labelText: "Name of Institute",
                      ),
                    ),
                    SizedBox(height: KSizes.sm),
                    DottedDivider(),
                    SizedBox(height: KSizes.sm),
                    Row(
                      children: [
                        Text(
                          "Currently studying?",
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
                            "Started Year",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          SizedBox(height: KSizes.sm),
                          Row(
                            children: [
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  value: _selectedYear,
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
                            "Graduation Year",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          SizedBox(height: KSizes.sm),
                          Row(
                            children: [
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  value: _selectedYear,
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
                                  icon:
                                      Icon(Icons.keyboard_arrow_down_outlined),
                                  hint: Text('Grade Type'),
                                  validator: (value) =>
                                      KValidator.validateEmptyText(
                                          "Grade Type", value),
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
                                      return 'Please select a grade type';
                                    }
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter marks';
                                    }
                                    final marks = double.tryParse(value);
                                    if (marks == null) {
                                      return 'Please enter a valid number';
                                    }
                                    if (_selectedGradeType == "Percentage" &&
                                        (marks < 0 || marks > 100)) {
                                      return 'Percentage must be between 0 and 100';
                                    }
                                    if (_selectedGradeType == "CGPA" &&
                                        (marks < 0 || marks > 4)) {
                                      return 'CGPA must be between 0 and 4';
                                    }
                                    return null; // No error
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Marks Secured",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                    SizedBox(height: KSizes.defaultSpace),
                  ],
                ),
              ),
            ],
          ],
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
