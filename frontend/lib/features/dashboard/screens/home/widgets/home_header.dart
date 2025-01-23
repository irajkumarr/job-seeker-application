
import 'package:flutter/material.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/l10n/l10n.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KSizes.md)
          .copyWith(top: KSizes.defaultSpace),
      child: Column(
        spacing: KSizes.xs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${l10n.discover_and_apply_to_jobs}",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(
            "${l10n.free}.",
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: KColors.primary,
                ),
          ),
          Text(
            "${l10n.more_than_people_found_jobs}",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: KColors.black,
                ),
          ),
        ],
      ),
    );
  }
}
