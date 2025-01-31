import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_screen/custom_screen.dart';
import 'package:frontend/common/widgets/loaders/full_screen_overlay.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/validators/validation.dart';
import 'package:frontend/data/models/profile_detail_model.dart';
import 'package:frontend/data/models/social_account_model.dart';
import 'package:frontend/features/personalization/providers/profile_provider.dart';
import 'package:frontend/features/personalization/providers/social_account_provider.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SocialAccountScreen extends StatefulWidget {
  const SocialAccountScreen({super.key, this.socialaccount});
  final Socialaccount? socialaccount;
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
  void initState() {
    super.initState();

    if (widget.socialaccount != null) {
      _socialMediaController.text = widget.socialaccount!.platform ?? "";
      _selectedSocialMedia = widget.socialaccount!.platform ?? "";
      _webAddressController.text = widget.socialaccount!.url ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final socialAccountProvider = Provider.of<SocialAccountProvider>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);
    return FullScreenOverlay(
      isLoading: socialAccountProvider.isLoading,
      child: CustomScreen(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            if (widget.socialaccount == null) {
              SocialAccountModel model = SocialAccountModel(
                platform: _socialMediaController.text.trim(),
                url: _webAddressController.text.trim(),
              );
              String data = socialAccountModelToJson(model);
              socialAccountProvider.addSocialAccount(context, data, () async {
                await profileProvider.fetchProfile(forceRefresh: true);
                context.pop();
              });
            } else {
              SocialAccountModel model = SocialAccountModel(
                platform: _socialMediaController.text.trim(),
                url: _webAddressController.text.trim(),
              );
              String data = socialAccountModelToJson(model);
              socialAccountProvider.updateSocialAccount(
                  context, widget.socialaccount!.id!, data, () async {
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
                      keyboardType: TextInputType.url,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: KSizes.fontSizeSm),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Web Address cannot be empty";
                        }

                        // Define platform-specific URL patterns
                        final Map<String, String> platformPatterns = {
                          "Facebook":
                              r'^(https?:\/\/)?(www\.)?facebook\.com\/[A-Za-z0-9._%-]+\/?$',
                          "Instagram":
                              r'^(https?:\/\/)?(www\.)?instagram\.com\/[A-Za-z0-9._%-]+\/?$',
                          "Twitter":
                              r'^(https?:\/\/)?(www\.)?twitter\.com\/[A-Za-z0-9._%-]+\/?$',
                          "LinkedIn":
                              r'^(https?:\/\/)?(www\.)?linkedin\.com\/in\/[A-Za-z0-9._%-]+\/?$',
                          "Snapchat":
                              r'^(https?:\/\/)?(www\.)?snapchat\.com\/add\/[A-Za-z0-9._%-]+\/?$',
                          "TikTok":
                              r'^(https?:\/\/)?(www\.)?tiktok\.com\/@?[A-Za-z0-9._%-]+\/?$',
                        };

                        if (_selectedSocialMedia != null &&
                            platformPatterns
                                .containsKey(_selectedSocialMedia)) {
                          final pattern =
                              platformPatterns[_selectedSocialMedia]!;
                          final isValidUrl =
                              RegExp(pattern, caseSensitive: false)
                                  .hasMatch(value);

                          if (!isValidUrl) {
                            return "Enter a valid $_selectedSocialMedia URL";
                          }
                        }

                        return null;
                      },
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
      ),
    );
  }
}
