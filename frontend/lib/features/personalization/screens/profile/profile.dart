import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/common/widgets/texts/section_row_title_text.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/image_strings.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:frontend/features/personalization/screens/profile/widgets/profile_appbar.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:frontend/l10n/language_provider.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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

              SizedBox(height: KSizes.defaultSpace),
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
                      onTap: () {},
                    ),
                    SettingsTile(
                      text: "${l10n.sign_in}",
                      icon: Icons.logout,
                      onTap: () {},
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
                        title: "Priorities",
                        subTitle: "Change your priorities",
                        isViewAll: false),
                    Consumer<LanguageProvider>(
                        builder: (context, languageProvider, child) {
                      final flagImage =
                          languageProvider.locale.languageCode == 'ne'
                              ? KImages.flagUk
                              : KImages.flagNepal;
                      return SettingsTile(
                        text: "${l10n.language}",
                        isIconImage: true,
                        iconImage: flagImage,
                        icon: Icons.language_outlined,
                        onTap: () {},
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

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.text,
    required this.onTap,
    this.iconColor = KColors.darkerGrey,
    this.textColor = KColors.darkerGrey,
    required this.icon,
    this.isIconImage = false,
    this.iconImage,
  });
  final String text;
  final VoidCallback onTap;
  final Color iconColor;
  final Color textColor;
  final IconData icon;
  final bool isIconImage;
  final String? iconImage;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      horizontalTitleGap: 10,
      leading: isIconImage
          ? Image.asset(
              iconImage!,
              width: 24.w,
              height: 24.h,
            )
          : Icon(
              icon,
              color: iconColor,
            ),
      title: Text(
        text,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        //icon
        Container(
          width: 80.w,
          height: 80.h,
          decoration: BoxDecoration(
            border: Border.all(
              color: KColors.black,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(100),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: SvgPicture.asset(
              "assets/images/content/rojgari_icon.svg",
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(width: KSizes.md),
        //text
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${l10n.guest}",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontSize: 22,
                  ),
            ),
            Text(
              "${l10n.welcome_to} ${l10n.your_business_name}",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        )
      ],
    );
  }
}
