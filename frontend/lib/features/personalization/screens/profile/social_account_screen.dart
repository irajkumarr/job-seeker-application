import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_screen/custom_screen.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/validators/validation.dart';
import 'package:frontend/l10n/l10n.dart';

class SocialAccountScreen extends StatefulWidget {
  const SocialAccountScreen({super.key});

  @override
  _SocialAccountScreenState createState() => _SocialAccountScreenState();
}

class _SocialAccountScreenState extends State<SocialAccountScreen> {
  final TextEditingController _socialMediaController = TextEditingController();
  final TextEditingController _webAddressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final List<String> _socialMediaOptions = [
    "Facebook",
    "Instagram",
    "Twitter",
    "LinkedIn",
    "Snapchat",
    "TikTok",
  ];

  String? _selectedSocialMedia;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return CustomScreen(
      onPressed: () {
        if (_formKey.currentState!.validate()) {}
      },
      buttonText: l10n.submit,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: KSizes.md, vertical: KSizes.defaultSpace),
        child: Column(
          children: [
            Text(
              "Social Account",
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
                  DropdownButtonFormField<String>(
                    dropdownColor: KColors.white,
                    icon: Icon(Icons.keyboard_arrow_down_outlined),
                    value: _selectedSocialMedia,
                    hint: Text("Social Media"),
                    items: _socialMediaOptions.map((String socialMedia) {
                      return DropdownMenuItem<String>(
                        value: socialMedia,
                        child: Text(socialMedia),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedSocialMedia = value!;
                        _socialMediaController.text = value;
                      });
                    },
                    validator: (value) => value == null
                        ? "Please select a social media platform"
                        : null,
                  ),
                  SizedBox(height: KSizes.defaultSpace),
                  TextFormField(
                    controller: _webAddressController,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: KSizes.fontSizeSm),
                    validator: (value) =>
                        KValidator.validateEmptyText("Web Address", value),
                    decoration: InputDecoration(
                      labelText: "Web Address",
                    ),
                  ),
                  SizedBox(height: KSizes.defaultSpace),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
