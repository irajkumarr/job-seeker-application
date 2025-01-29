import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/texts/section_row_title_text.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/image_strings.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:frontend/features/personalization/screens/profile/widgets/language_bottom_sheet.dart';
import 'package:frontend/features/personalization/screens/profile/widgets/profile_appbar.dart';
import 'package:frontend/features/personalization/screens/profile/widgets/profile_header.dart';
import 'package:frontend/features/personalization/screens/profile/widgets/settings_tile.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:frontend/l10n/language_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
class ProfileWithoutLogin extends StatelessWidget {
  const ProfileWithoutLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(KDeviceUtils.getAppBarHeight()),
        child: ProfileAppbar(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: KSizes.md, vertical: KSizes.md),
          child: Column(
            children: [
              //profile header
              ProfileHeader(),

              SizedBox(height: KSizes.spaceBtwSections),
              //sign in and sign up option

              Container(
                padding: EdgeInsets.symmetric(vertical: KSizes.sm),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(KSizes.sm),
                  color: KColors.primaryContainer,
                ),
                child: Column(
                  children: [
                    SettingsTile(
                      text: "${l10n.join_rojgari}",
                      iconColor: KColors.primary,
                      textColor: KColors.primary,
                      icon: Icons.add_circle_outline_rounded,
                      onTap: () {
                        context.pushNamed(RoutesConstant.signup);
                      },
                    ),
                    SettingsTile(
                      text: "${l10n.sign_in}",
                      icon: Icons.logout,
                      onTap: () {
                        context.pushNamed(RoutesConstant.login);
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: KSizes.defaultSpace),

              //priorities section (language and employer zone)
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
                        title: "${l10n.priorities}",
                        subTitle: "${l10n.change_your_priorities}",
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
                      text: "${l10n.employer_zone}",
                      icon: Icons.business_outlined,
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              SizedBox(height: KSizes.defaultSpace),
              //training section lists
              Container(
                padding: EdgeInsets.symmetric(vertical: KSizes.sm),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(KSizes.sm),
                  color: KColors.primaryContainer,
                ),
                child: Column(
                  children: [
                    SettingsTile(
                      text: "${l10n.training_lists}",
                      icon: Icons.content_paste_rounded,
                      onTap: () {},
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
                      subTitle: "${l10n.read_terms_and_conditions}",
                      isViewAll: false,
                    ),
                    SettingsTile(
                      text: "${l10n.terms_conditions}",
                      icon: Icons.description_outlined,
                      onTap: () {},
                    ),
                    SettingsTile(
                      text: "FAQs",
                      icon: Icons.help_outline,
                      onTap: () {},
                    ),
                    SettingsTile(
                      text: "${l10n.contact_us}",
                      icon: Icons.phone_outlined,
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              SizedBox(height: KSizes.defaultSpace),
            ],
          ),
        ),
      ),
    );
  }
}
