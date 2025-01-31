import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/alert_box/snackbar.dart';
import 'package:frontend/common/widgets/custom_screen/custom_screen.dart';
import 'package:frontend/common/widgets/loaders/full_screen_overlay.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/divider/dotted_divider.dart';
import 'package:frontend/core/utils/validators/validation.dart';
import 'package:frontend/data/models/contact_information_model.dart'
    as contactInfoModel;
import 'package:frontend/data/models/profile_detail_model.dart';
import 'package:frontend/features/personalization/providers/contact_information_provider.dart';
import 'package:frontend/features/personalization/providers/profile_provider.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ContactInformationScreen extends StatefulWidget {
  const ContactInformationScreen({super.key, this.contact});
  final Emergencycontact? contact;
  @override
  _ContactInformationScreenState createState() =>
      _ContactInformationScreenState();
}

class _ContactInformationScreenState extends State<ContactInformationScreen> {
  final TextEditingController _contactFullNameController =
      TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final List<String> _relation = [
    "Mother",
    "Father",
    "Friend",
  ];

  String? _selectedRelation;

  // Dropdown values
  String? _selectedNumberType;

  final List<String> _numberTypes = [
    "Mobile",
    "Home",
    "Office",
  ];
  @override
  void initState() {
    super.initState();

    if (widget.contact != null) {
      _contactFullNameController.text = widget.contact!.fullName ?? "";
      _selectedRelation = widget.contact!.relation ?? "";
      _addressController.text = widget.contact!.address ?? "";
      _phoneNumberController.text =
          widget.contact!.phoneNumber?.mobileNumber ?? "";
      _selectedNumberType = widget.contact!.phoneNumber?.numberType ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final contactInformationProvider =
        Provider.of<ContactInformationProvider>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);
    return FullScreenOverlay(
      isLoading: contactInformationProvider.isLoading,
      child: CustomScreen(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            if (_selectedRelation == null) {
              // Show an error message
              KSnackbar.CustomSnackbar(
                  context, "Please select a relation", KColors.error);
              return;
            }

            if (widget.contact == null) {
              contactInfoModel.ContactInformationModel model =
                  contactInfoModel.ContactInformationModel(
                fullName: _contactFullNameController.text.trim(),
                address: _addressController.text.trim(),
                relation: _selectedRelation!.trim(),
                phoneNumber: contactInfoModel.PhoneNumber(
                  numberType: _selectedNumberType!.trim(),
                  mobileNumber: _phoneNumberController.text.trim(),
                ),
              );
              String data =
                  contactInfoModel.contactInformationModelToJson(model);
              contactInformationProvider.addContactInformation(context, data,
                  () async {
                await profileProvider.fetchProfile(forceRefresh: true);
                context.pop();
              });
            } else {
              contactInfoModel.ContactInformationModel model =
                  contactInfoModel.ContactInformationModel(
                fullName: _contactFullNameController.text.trim(),
                address: _addressController.text.trim(),
                relation: _selectedRelation!.trim(),
                phoneNumber: contactInfoModel.PhoneNumber(
                  numberType: _selectedNumberType!.trim(),
                  mobileNumber: _phoneNumberController.text.trim(),
                ),
              );
              String data =
                  contactInfoModel.contactInformationModelToJson(model);
              contactInformationProvider.updateContactInformation(
                  context, widget.contact!.id!, data, () async {
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
                "Contact Information",
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
                      controller: _contactFullNameController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: KSizes.fontSizeSm),
                      validator: (value) => KValidator.validateEmptyText(
                          "Contact Person Full Name", value),
                      decoration: InputDecoration(
                        labelText: "Contact Person Full Name",
                      ),
                    ),
                    SizedBox(height: KSizes.defaultSpace),
                    TextFormField(
                      controller: _addressController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: KSizes.fontSizeSm),
                      validator: (value) =>
                          KValidator.validateEmptyText("Address", value),
                      decoration: InputDecoration(
                        labelText: "Address",
                      ),
                    ),
                    SizedBox(height: KSizes.sm),
                    DottedDivider(),
                    SizedBox(height: KSizes.md),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Relation",
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    fontSize: 18.sp,
                                  ),
                        ),
                        SizedBox(height: KSizes.sm),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: _relation.map((relation) {
                            final isSelected = _selectedRelation == relation;

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (_selectedRelation == relation) {
                                    _selectedRelation = null;
                                  } else {
                                    _selectedRelation = relation;
                                  }
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? KColors.secondary
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: isSelected
                                        ? KColors.primary
                                        : KColors.grey,
                                  ),
                                ),
                                child: Text(
                                  relation,
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
                                validator: (value) =>
                                    KValidator.validateEmptyText(
                                        "Number Type", value),
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
                                    KValidator.validatePhoneNumber(value),
                                decoration: const InputDecoration(
                                    labelText: "Phone Number"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: KSizes.defaultSpace),
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
