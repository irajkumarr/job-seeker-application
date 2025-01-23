import 'package:flutter/material.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/l10n/l10n.dart';

class SectionRowTitleText extends StatelessWidget {
  const SectionRowTitleText({
    super.key,
    required this.title,
    required this.subTitle,
    required this.isViewAll,
  });

  final String title;
  final String subTitle;
  final bool isViewAll;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KSizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 15,
                ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                subTitle,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: KColors.black,
                    ),
              ),
              !isViewAll
                  ? SizedBox()
                  : Text(
                      "${l10n.view_all}",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: KColors.primary,
                          ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
