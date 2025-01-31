import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/image_strings.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:frontend/l10n/language_provider.dart';
import 'package:provider/provider.dart';

class LanguageBottomSheet extends StatelessWidget {
  LanguageBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final languageProvider = Provider.of<LanguageProvider>(context);
    final currentLocale = languageProvider.locale.languageCode;
    return Container(
      padding: EdgeInsets.symmetric(vertical: KSizes.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(KSizes.md)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag Handle
          Center(
            child: Container(
              width: 35.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: KColors.darkerGrey,
                borderRadius: BorderRadius.circular(KSizes.md),
              ),
            ),
          ),
          const SizedBox(height: KSizes.defaultSpace),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: KSizes.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${l10n.changeLanguage}',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: KSizes.xs),
                Text(
                  '${l10n.customize_your_language_setting}',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: KColors.black,
                      ),
                ),
              ],
            ),
          ),
          SizedBox(height: KSizes.md),
          // Language Options
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 14,
                  backgroundImage: AssetImage(KImages.flagNepal),
                ),
                title: Text(
                  'नेपाली',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontFamily: "Mukta",
                      ),
                ),
                trailing: Radio(
                  value: 'ne',
                  groupValue: currentLocale,
                  onChanged: (value) {
                    languageProvider.setLocale(const Locale('ne', ''));
                    // Navigator.pop(context);
                  },
                  activeColor: KColors.primary,
                ),
                onTap: () {
                  languageProvider.setLocale(const Locale('ne', ''));
                  // Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const CircleAvatar(
                  radius: 14,
                  backgroundImage: AssetImage(KImages.flagUk),
                ),
                title: Text(
                  'English',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                trailing: Radio(
                  value: 'en',
                  groupValue: currentLocale,
                  onChanged: (value) {
                    languageProvider.setLocale(const Locale('en', ''));
                    // Navigator.pop(context);
                  },
                  activeColor: KColors.primary,
                ),
                onTap: () {
                  languageProvider.setLocale(const Locale('en', ''));
                  // Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Usage:
void showLanguageBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isDismissible: true,
    isScrollControlled: true,
    showDragHandle: false,
    sheetAnimationStyle: AnimationStyle(
      duration: Duration(milliseconds: 500),
      reverseDuration: Duration(milliseconds: 500),
    ),
    backgroundColor: KColors.white,
    builder: (context) => LanguageBottomSheet(),
  );
}
