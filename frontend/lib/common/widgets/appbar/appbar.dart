import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/core/utils/constants/image_strings.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/features/dashboard/widgets/employer_bottom_sheet.dart';
import 'package:frontend/l10n/language_provider.dart';
import 'package:provider/provider.dart';

class Appbar extends StatelessWidget {
  const Appbar({
    super.key,
    required this.isActionRequired,
  });
  final bool isActionRequired;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0.2,
      child: AppBar(
        title: SvgPicture.asset(
          "assets/images/content/rojgari_logo.svg",
          width: 110.w,
        ),
        actions: !isActionRequired
            ? null
            : [
                Consumer<LanguageProvider>(
                    builder: (context, languageProvider, child) {
                  final flagImage = languageProvider.locale.languageCode == 'ne'
                      ? KImages.flagUk
                      : KImages.flagNepal;
                  final lang = languageProvider.locale.languageCode == 'ne'
                      ? "EN"
                      : "ने";
                  return Row(
                    spacing: KSizes.sm,
                    children: [
                      Text(
                        lang,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                      ),
                      GestureDetector(
                        onTap: () {
                          languageProvider.toggleLanguage();
                        },
                        child: Image.asset(
                          flagImage,
                          width: 25.w,
                        ),
                      ),
                    ],
                  );
                }),
                SizedBox(width: KSizes.sm),
                IconButton(
                  onPressed: () {
                    showEmployerBottomSheet(context);
                  },
                  icon: Icon(
                    Icons.business_outlined,
                  ),
                ),
                SizedBox(width: KSizes.xs),
              ],
      ),
    );
  }
}
