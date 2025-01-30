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

class ReferenceScreen extends StatefulWidget {
  const ReferenceScreen({super.key});

  @override
  State<ReferenceScreen> createState() => _ReferenceScreenState();
}

class _ReferenceScreenState extends State<ReferenceScreen> {
  final TextEditingController _referenceNameController =
      TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _organizationNameController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Dropdown values
  String? _selectedNumberType;

  final List<String> _numberTypes = ["Home", "Office", "Own"];

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
              "Reference",
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
                    controller: _referenceNameController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: KSizes.fontSizeSm),
                    validator: (value) =>
                        KValidator.validateEmptyText("Reference name", value),
                    decoration:
                        const InputDecoration(labelText: "Reference name"),
                  ),
                  SizedBox(height: KSizes.defaultSpace),
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
                    decoration: const InputDecoration(labelText: "Designation"),
                  ),
                  SizedBox(height: KSizes.defaultSpace),
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
                    decoration:
                        const InputDecoration(labelText: "Organization Name"),
                  ),
                  SizedBox(height: KSizes.defaultSpace),
                  TextFormField(
                    controller: _emailController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: KSizes.fontSizeSm),
                    validator: (value) =>
                        KValidator.validateEmptyText("Email", value),
                    decoration: const InputDecoration(labelText: "Email"),
                  ),

                  SizedBox(height: KSizes.sm),
                  DottedDivider(),
                  SizedBox(height: KSizes.sm),

                  // Duration Section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Phone Number",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(fontSize: 18.sp)),
                      SizedBox(height: KSizes.sm),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              icon: Icon(Icons.keyboard_arrow_down_outlined),
                              value: _selectedNumberType,
                              dropdownColor: KColors.white,
                              onChanged: (value) {
                                setState(() {
                                  _selectedNumberType = value;
                                });
                              },
                              items: _numberTypes.map((type) {
                                return DropdownMenuItem(
                                    value: type, child: Text(type));
                              }).toList(),
                              decoration: const InputDecoration(
                                  labelText: "Number Type"),
                            ),
                          ),
                          SizedBox(width: KSizes.md),
                          Expanded(
                            child: TextFormField(
                              controller: _phoneNumberController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontSize: KSizes.fontSizeSm),
                              validator: (value) =>
                                  KValidator.validateEmptyText(
                                      "Phone Number", value),
                              decoration: const InputDecoration(
                                  labelText: "Phone Number"),
                            ),
                          ),
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
