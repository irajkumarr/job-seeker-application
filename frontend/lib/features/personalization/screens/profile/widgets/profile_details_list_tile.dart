import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/l10n/l10n.dart';

class ProfileDetailListTile extends StatelessWidget {
  const ProfileDetailListTile({
    super.key,
    required this.title,
    // required this.leadingIcon,
    required this.onAdd,
    // required this.leadingIconColor,
  });
  final String title;
  // final Color leadingIconColor;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: KColors.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontSize: 18.sp,
                ),
          ),
          SizedBox(height: KSizes.sm),
          Divider(
            color: KColors.grey,
          ),
          SizedBox(height: KSizes.sm),
          InkWell(
            onTap: onAdd,
            borderRadius: BorderRadius.circular(KSizes.md),
            child: Row(
              children: [
                Icon(
                  Icons.add_circle,
                  color: KColors.primary,
                  size: 20,
                ),
                const SizedBox(width: KSizes.md),
                Text(
                  '${l10n.add} $title',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: KColors.primary,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
