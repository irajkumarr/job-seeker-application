
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/core/utils/constants/image_strings.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:iconsax/iconsax.dart';

class Appbar extends StatelessWidget {
  const Appbar({
    super.key,
    required this.isActionRequired,
  });
  final bool isActionRequired;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
                Row(
                  spacing: KSizes.sm,
                  children: [
                    Text(
                      "${l10n.lang}",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Image.asset(
                      KImages.flagUk,
                      width: 25.w,
                    ),
                  ],
                ),
                SizedBox(width: KSizes.md),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Iconsax.buildings,
                  ),
                ),
                SizedBox(width: KSizes.xs),
              ],
      ),
    );
  }
}