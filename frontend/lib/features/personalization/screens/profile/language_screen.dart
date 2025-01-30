import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/custom_screen/custom_screen.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/divider/dotted_divider.dart';
import 'package:frontend/core/utils/validators/validation.dart';
import 'package:frontend/l10n/l10n.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final TextEditingController _languageController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
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
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: KSizes.iconLg,

                    unratedColor: KColors.darkGrey,
                    // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star_border_rounded,
                      color: KColors.primary,
                    ),
                    onRatingUpdate: (rating) {},
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
    );
  }
}
