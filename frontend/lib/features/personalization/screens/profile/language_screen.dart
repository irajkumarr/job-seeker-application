import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/custom_screen/custom_screen.dart';
import 'package:frontend/common/widgets/loaders/full_screen_overlay.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/divider/dotted_divider.dart';
import 'package:frontend/core/utils/validators/validation.dart';
import 'package:frontend/data/models/language_model.dart';
import 'package:frontend/data/models/profile_detail_model.dart';
import 'package:frontend/features/personalization/providers/profile_provider.dart';
import 'package:frontend/features/personalization/providers/user_language_provider.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key, this.language});
  final Language? language;
  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  final TextEditingController _languageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  double? _languageScore;
  @override
  void initState() {
    super.initState();

    if (widget.language != null) {
      _languageController.text = widget.language!.name ?? "";
      _languageScore = widget.language!.score ?? 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final userLanguageProvider = Provider.of<UserLanguageProvider>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);
    return FullScreenOverlay(
      isLoading: userLanguageProvider.isLoading,
      child: CustomScreen(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            if (widget.language == null) {
              LanguageModel model = LanguageModel(
                name: _languageController.text.trim(),
                score: _languageScore,
              );
              String data = languageModelToJson(model);
              userLanguageProvider.addLanguage(context, data, () async {
                await profileProvider.fetchProfile(forceRefresh: true);
                context.pop();
              });
            } else {
              LanguageModel model = LanguageModel(
                name: _languageController.text.trim(),
                score: _languageScore,
              );
              String data = languageModelToJson(model);
              userLanguageProvider.updateLanguage(
                  context, widget.language!.id!, data, () async {
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
                "Language",
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
                    //name
                    TextFormField(
                      controller: _languageController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: KSizes.fontSizeSm),
                      validator: (value) =>
                          KValidator.validateEmptyText("Language", value),
                      decoration: InputDecoration(
                        labelText: "Language",
                      ),
                    ),
                    SizedBox(
                      height: KSizes.sm,
                    ),
                    DottedDivider(),
                    SizedBox(
                      height: KSizes.sm,
                    ),
                    //score
                    Text(
                      "Score",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontSize: 18.sp,
                          ),
                    ),
                    SizedBox(
                      height: KSizes.sm,
                    ),
                    RatingBar.builder(
                      initialRating: _languageScore ?? 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: KSizes.iconLg,

                      unratedColor: KColors.grey,
                      // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: KColors.primary,
                      ),
                      onRatingUpdate: (rating) {
                        _languageScore = rating;
                        setState(() {});
                      },
                    ),
                    SizedBox(
                      height: KSizes.md,
                    ),
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
