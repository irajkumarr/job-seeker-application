import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/custom_screen/custom_screen.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:frontend/core/utils/divider/dotted_divider.dart';
import 'package:frontend/core/utils/validators/validation.dart';
import 'package:frontend/l10n/l10n.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({super.key});

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  final TextEditingController _trainingNameController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _completionYearController =
      TextEditingController();
  final TextEditingController _instituteNameController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Dropdown values
  String? _selectedDurationType;
  String? _selectedCompletionYear;
  String? _selectedCompletionMonth;

  final List<String> _durationTypes = ["Days", "Months", "Years"];
  final List<String> _years =
      List.generate(30, (index) => (DateTime.now().year - index).toString());

// List of months
  final List<String> _months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return CustomScreen(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          // Handle form submission
        }
      },
      buttonText: l10n.submit,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: KSizes.md, vertical: KSizes.defaultSpace),
        child: Column(
          children: [
            Text(
              "Training Name",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
            ),
            SizedBox(height: KSizes.defaultSpace),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _trainingNameController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: KSizes.fontSizeSm),
                    validator: (value) =>
                        KValidator.validateEmptyText("Training", value),
                    decoration: const InputDecoration(labelText: "Training"),
                  ),
                  SizedBox(height: KSizes.defaultSpace),

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
                    decoration:
                        const InputDecoration(labelText: "Name of Institute"),
                  ),

                  SizedBox(height: KSizes.sm),
                  DottedDivider(),
                  SizedBox(height: KSizes.sm),

                  // Duration Section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Duration",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(fontSize: 18.sp)),
                      SizedBox(height: KSizes.sm),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _durationController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontSize: KSizes.fontSizeSm),
                              validator: (value) =>
                                  KValidator.validateEmptyText(
                                      "Duration", value),
                              decoration: const InputDecoration(),
                            ),
                          ),
                          SizedBox(width: KSizes.md),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              icon: Icon(Icons.keyboard_arrow_down_outlined),
                              value: _selectedDurationType,
                              dropdownColor: KColors.white,
                              onChanged: (value) {
                                setState(() {
                                  _selectedDurationType = value;
                                });
                              },
                              items: _durationTypes.map((type) {
                                return DropdownMenuItem(
                                    value: type, child: Text(type));
                              }).toList(),
                              decoration: const InputDecoration(
                                  labelText: "Duration Type"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: KSizes.sm),
                  DottedDivider(),
                  SizedBox(height: KSizes.sm),

                  // Completion Year Section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Completion Year",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(fontSize: 18.sp)),
                      SizedBox(height: KSizes.sm),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: _selectedCompletionYear,
                              icon: Icon(Icons.keyboard_arrow_down_outlined),
                              dropdownColor: KColors.white,
                              onChanged: (value) {
                                setState(() {
                                  _selectedCompletionYear = value;
                                });
                              },
                              items: _years.map((year) {
                                return DropdownMenuItem(
                                    value: year, child: Text(year));
                              }).toList(),
                              decoration:
                                  const InputDecoration(labelText: "Year"),
                            ),
                          ),
                          SizedBox(width: KSizes.md),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: _selectedCompletionMonth,
                              icon: Icon(Icons.keyboard_arrow_down_outlined),
                              dropdownColor: KColors.white,
                              onChanged: (value) {
                                setState(() {
                                  _selectedCompletionMonth = value;
                                });
                              },
                              items: _months.map((month) {
                                return DropdownMenuItem(
                                    value: month, child: Text(month));
                              }).toList(),
                              decoration:
                                  const InputDecoration(labelText: "Month"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
