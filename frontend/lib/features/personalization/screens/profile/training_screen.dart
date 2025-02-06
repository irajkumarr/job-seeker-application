import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/custom_screen/custom_screen.dart';
import 'package:frontend/common/widgets/loaders/full_screen_overlay.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/divider/dotted_divider.dart';
import 'package:frontend/core/utils/validators/validation.dart';
import 'package:frontend/data/models/profile_detail_model.dart';
import 'package:frontend/data/models/training_model.dart' as trainingModel;
import 'package:frontend/features/personalization/providers/profile_provider.dart';
import 'package:frontend/features/personalization/providers/training_provider.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({super.key, this.training});
  final Training? training;
  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  final TextEditingController _trainingNameController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();

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
  void initState() {
    super.initState();

    if (widget.training != null) {
      _trainingNameController.text = widget.training!.name ?? "";
      _instituteNameController.text = widget.training!.institute ?? "";
      _durationController.text = widget.training!.duration?.value ?? "";
      _selectedDurationType = widget.training!.duration?.unit ?? "";
      _selectedCompletionYear = widget.training!.completionYear?.year ?? "";
      _selectedCompletionMonth = widget.training!.completionYear?.month ?? "";
    }
  }

  @override
  void dispose() {
    _trainingNameController.dispose();
    _instituteNameController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final trainingProvider = Provider.of<TrainingProvider>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);
    return FullScreenOverlay(
      isLoading: trainingProvider.isLoading,
      child: CustomScreen(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            if (widget.training == null) {
              trainingModel.TrainingModel model = trainingModel.TrainingModel(
                name: _trainingNameController.text.trim(),
                institute: _instituteNameController.text.trim(),
                duration: trainingModel.Duration(
                  value: _durationController.text.trim(),
                  unit: _selectedDurationType!.trim(),
                ),
                completionYear: trainingModel.CompletionYear(
                  year: _selectedCompletionYear!.trim(),
                  month: _selectedCompletionMonth!.trim(),
                ),
              );
              String data = trainingModel.trainingModelToJson(model);
              trainingProvider.addTraining(context, data, () async {
                await profileProvider.fetchProfile(forceRefresh: true);
                context.pop();
              });
            } else {
              trainingModel.TrainingModel model = trainingModel.TrainingModel(
                name: _trainingNameController.text.trim(),
                institute: _instituteNameController.text.trim(),
                duration: trainingModel.Duration(
                  value: _durationController.text.trim(),
                  unit: _selectedDurationType!.trim(),
                ),
                completionYear: trainingModel.CompletionYear(
                  year: _selectedCompletionYear!.trim(),
                  month: _selectedCompletionMonth!.trim(),
                ),
              );
              String data = trainingModel.trainingModelToJson(model);
              trainingProvider.updateTraining(
                  context, widget.training!.id!, data, () async {
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
            children: [
              Text(
                "${l10n.training_name}",
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
                      validator: (value) => KValidator.validateEmptyText(
                          "${l10n.training}", value),
                      decoration:
                          InputDecoration(labelText: "${l10n.training}"),
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
                          "${l10n.name_of_institute}", value),
                      decoration: InputDecoration(
                          labelText: "${l10n.name_of_institute}"),
                    ),

                    SizedBox(height: KSizes.sm),
                    DottedDivider(),
                    SizedBox(height: KSizes.sm),

                    // Duration Section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${l10n.duration}",
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
                                        "${l10n.duration}", value),
                                decoration: InputDecoration(
                                    labelText: "${l10n.duration}"),
                              ),
                            ),
                            SizedBox(width: KSizes.md),
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                icon: Icon(Icons.keyboard_arrow_down_outlined),
                                value: _selectedDurationType,
                                dropdownColor: KColors.white,
                                validator: (value) =>
                                    KValidator.validateEmptyText(
                                        "${l10n.duration_type}", value),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedDurationType = value;
                                  });
                                },
                                items: _durationTypes.map((type) {
                                  return DropdownMenuItem(
                                      value: type, child: Text(type));
                                }).toList(),
                                decoration: InputDecoration(
                                    labelText: "${l10n.duration_type}"),
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
                        Text("${l10n.completion_year}",
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
                                validator: (value) =>
                                    KValidator.validateEmptyText(
                                        "${l10n.year}", value),
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
                                    InputDecoration(labelText: "${l10n.year}"),
                              ),
                            ),
                            SizedBox(width: KSizes.md),
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                value: _selectedCompletionMonth,
                                icon: Icon(Icons.keyboard_arrow_down_outlined),
                                dropdownColor: KColors.white,
                                validator: (value) =>
                                    KValidator.validateEmptyText(
                                        "${l10n.month}", value),
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
                                    InputDecoration(labelText: "${l10n.month}"),
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
      ),
    );
  }
}
