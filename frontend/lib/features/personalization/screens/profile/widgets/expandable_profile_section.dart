import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/features/personalization/providers/profile_provider.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:provider/provider.dart';

class SectionData {
  final String label;
  final String value;
  final IconData icon;

  SectionData({required this.icon, required this.label, required this.value});
}

class ExpandableProfileSection extends StatelessWidget {
  const ExpandableProfileSection({
    super.key,
    required this.sectionId,
    required this.title,
    required this.leadingIcon,
    required this.leadingIconColor,
    required this.data,
    required this.height,
    required this.onTap,
  });

  final String sectionId;
  final String title;
  final IconData leadingIcon;
  final Color leadingIconColor;
  final List<SectionData> data;
  final double height;
  final VoidCallback onTap;

  /// Check if all required data fields are completed
  // Check if section is complete
  bool isSectionComplete() {
    // Filter out empty or null values
    final nonEmptyFields = data.where((item) {
      final value = item.value.trim();
      return value.isNotEmpty && value != "_ _ _" && value != "null";
    }).length;

    // Consider section complete if all fields have valid values
    return nonEmptyFields == data.length;
  }

  // Get appropriate icon and color based on completion status
  IconData get sectionIcon {
    return isSectionComplete() ? Icons.check_circle : Icons.error_outline;
  }

  Color get sectionIconColor {
    return isSectionComplete()
        ? Colors.green
        : KColors.primary; // or any warning color you prefer
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Consumer<ProfileProvider>(
      builder: (context, provider, child) {
        final isExpanded = provider.isExpanded(sectionId);
        return Column(
          children: [
            ListTile(
              onTap: () => provider.toggleSection(sectionId),
              horizontalTitleGap: 10.w,
              contentPadding: EdgeInsets.symmetric(
                  vertical: KSizes.xs, horizontal: KSizes.md),
              tileColor: KColors.secondaryBackground,
              shape: RoundedRectangleBorder(
                borderRadius: !isExpanded
                    ? BorderRadius.circular(KSizes.sm + 3)
                    : BorderRadius.vertical(
                        top: Radius.circular(KSizes.sm + 3)),
              ),
              // leading: Icon(
              //   leadingIcon,
              //   color: leadingIconColor,
              // ),
              leading: Icon(
                sectionIcon,
                color: sectionIconColor,
                size: 24.sp,
              ),
              title: Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontSize: 18.sp,
                    ),
              ),
              trailing: AnimatedRotation(
                duration: const Duration(milliseconds: 500),
                turns: isExpanded ? 0.5 : 0,
                child: const Icon(Icons.keyboard_arrow_down_sharp),
              ),
            ),
            if (isExpanded)
              Divider(
                height: 1,
                thickness: 1,
                color: KColors.grey,
              ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeInOut,
              height: isExpanded ? height : 0,
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.all(KSizes.md),
                  decoration: BoxDecoration(
                    color: KColors.secondaryBackground,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(KSizes.sm),
                      bottomRight: Radius.circular(KSizes.sm),
                    ),
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(KSizes.sm),
                          bottomRight: Radius.circular(KSizes.sm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: data
                              .map((item) => _buildInfoRow(
                                  context, item.label, item.value, item.icon))
                              .toList(),
                        ),
                      ),
                      Divider(),
                      SizedBox(height: KSizes.sm),
                      InkWell(
                        onTap: onTap,
                        borderRadius: BorderRadius.circular(KSizes.sm + 4),
                        child: Row(
                          children: [
                            Icon(
                              Icons.edit,
                              color: KColors.black.withOpacity(0.7),
                              size: KSizes.iconSm + 4,
                            ),
                            SizedBox(width: KSizes.md),
                            Text(
                              "${l10n.edit} ${title}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontSize: 14.sp,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInfoRow(
      BuildContext context, String label, String value, IconData icon) {
    return Column(
      children: [
        Row(
          spacing: KSizes.md,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: KColors.black.withOpacity(0.7),
              size: KSizes.iconSm + 4,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 14.sp,
                        ),
                  ),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: KSizes.md),
      ],
    );
  }
}
