
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/l10n/l10n.dart';

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
