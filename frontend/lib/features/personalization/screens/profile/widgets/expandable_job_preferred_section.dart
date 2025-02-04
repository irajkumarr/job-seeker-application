import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/features/personalization/providers/profile_provider.dart';
import 'package:frontend/features/personalization/screens/profile/widgets/expandable_profile_section.dart';
import 'package:provider/provider.dart';

class ExpandablePreferredJobLocationSection extends StatelessWidget {
  const ExpandablePreferredJobLocationSection({
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

  @override
  Widget build(BuildContext context) {
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
              leading: Icon(
                leadingIcon,
                color: leadingIconColor,
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
                              Icons.add_circle,
                              color: KColors.black.withOpacity(0.7),
                              size: KSizes.iconSm + 4,
                            ),
                            SizedBox(width: KSizes.md),
                            Text(
                              "Add ${title}",
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
    return Row(
      children: [
        Icon(
          icon,
          size: 24,
          color: Colors.grey[600],
        ),
        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),

        // Delete Button
        // TextButton(
        //   onPressed: () {},
        //   style: TextButton.styleFrom(
        //     foregroundColor: Colors.red,
        //     padding: const EdgeInsets.symmetric(horizontal: 8),
        //   ),
        //   child: const Text(
        //     'Delete',
        //     style: TextStyle(
        //       fontSize: 14,
        //       fontWeight: FontWeight.w400,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
