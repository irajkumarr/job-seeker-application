import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/loaders/full_screen_overlay.dart';
import 'package:frontend/common/widgets/texts/section_row_title_text.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/image_strings.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:frontend/core/utils/http/url_launch.dart';
import 'package:frontend/features/authentication/providers/login_provider.dart';
import 'package:frontend/features/personalization/screens/profile/widgets/change_password_bottom_sheet.dart';
import 'package:frontend/features/personalization/screens/profile/widgets/language_bottom_sheet.dart';
import 'package:frontend/features/personalization/screens/profile/widgets/settings_tile.dart';
import 'package:frontend/features/personalization/screens/profile/widgets/show_logout_alert.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:frontend/l10n/language_provider.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final loginProvider = Provider.of<LoginProvider>(context);
    return FullScreenOverlay(
      isLoading: loginProvider.isLoading,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(KDeviceUtils.getAppBarHeight()),
          child: Material(
            elevation: 0.2,
            child: AppBar(
              title: Text(
                "${l10n.settings}",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontSize: 22,
                    ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: KSizes.md, vertical: KSizes.md),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: KSizes.sm).copyWith(
                    top: KSizes.md,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(KSizes.sm),
                    color: KColors.primaryContainer,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionRowTitleText(
                          title: "${l10n.profile}",
                          subTitle: "${l10n.change_profile_settings}",
                          isViewAll: false),
                      Consumer<LanguageProvider>(
                          builder: (context, languageProvider, child) {
                        final flagImage =
                            languageProvider.locale.languageCode == 'ne'
                                ? KImages.flagNepal
                                : KImages.flagUk;
                        return SettingsTile(
                          text: "${l10n.language}",
                          isIconImage: true,
                          iconImage: flagImage,
                          icon: Icons.language_outlined,
                          onTap: () {
                            showLanguageBottomSheet(context);
                          },
                        );
                      }),
                      SettingsTile(
                        text: "${l10n.change_password}",
                        icon: Icons.lock_outline_rounded,
                        onTap: () {
                          showChangePasswordBottomSheet(context);
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(height: KSizes.defaultSpace),

                //learn more section
                Container(
                  padding: EdgeInsets.symmetric(vertical: KSizes.sm).copyWith(
                    top: KSizes.md,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(KSizes.sm),
                    color: KColors.primaryContainer,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionRowTitleText(
                        title: "${l10n.to_learn_more}",
                        subTitle:
                            "${l10n.click_below_for_more_information_on_employment_services}",
                        isViewAll: false,
                      ),
                      SettingsTile(
                        text: "${l10n.about_rojgari}",
                        icon: Icons.description_outlined,
                        onTap: () {
                          UrlLaunch.launchUrl("https://rojgari.com/en/about");
                        },
                      ),
                      SettingsTile(
                        text: "${l10n.blogs}",
                        icon: Iconsax.book,
                        onTap: () {
                          UrlLaunch.launchUrl("https://rojgari.com/en/blog");
                        },
                      ),
                      SettingsTile(
                        text: "FAQs",
                        icon: Icons.help_outline,
                        onTap: () {
                          UrlLaunch.launchUrl("https://rojgari.com/en/faq");
                        },
                      ),
                      SettingsTile(
                        text: "${l10n.contact_us}",
                        icon: Icons.phone_outlined,
                        onTap: () {
                          UrlLaunch.launchUrl("https://rojgari.com/en/contact");
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: KSizes.defaultSpace),

                //legal policies section
                Container(
                  padding: EdgeInsets.symmetric(vertical: KSizes.sm).copyWith(
                    top: KSizes.md,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(KSizes.sm),
                    color: KColors.primaryContainer,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionRowTitleText(
                        title: "${l10n.community_standards_legal_policies}",
                        subTitle:
                            "${l10n.customize_your_experiecne_on_rojgari}",
                        isViewAll: false,
                      ),
                      SettingsTile(
                        text: "${l10n.terms_and_condition}",
                        icon: Icons.description_outlined,
                        onTap: () {
                          UrlLaunch.launchUrl(
                              "https://rojgari.com/en/terms-condition");
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: KSizes.defaultSpace),

                //log out section
                Container(
                  padding: EdgeInsets.symmetric(vertical: KSizes.sm).copyWith(
                    top: KSizes.md,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(KSizes.sm),
                    color: KColors.primaryContainer,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionRowTitleText(
                        title: "${l10n.logout}",
                        subTitle: "${l10n.click_below_to_logout}",
                        isViewAll: false,
                      ),
                      SettingsTile(
                        text: "${l10n.logout}",
                        icon: Icons.logout_outlined,
                        onTap: () async {
                          await alertLogout(
                            context,
                            () async {
                              await loginProvider.logout(context);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(height: KSizes.defaultSpace),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
