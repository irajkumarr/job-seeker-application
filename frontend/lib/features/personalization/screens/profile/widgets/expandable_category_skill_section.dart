import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/features/personalization/providers/profile_provider.dart';
import 'package:provider/provider.dart';

class ExpandableCategoryAndSkillSection extends StatelessWidget {
  const ExpandableCategoryAndSkillSection({
    super.key,
    required this.sectionId,
    required this.title,
    required this.leadingIcon,
    required this.leadingIconColor,
    required this.data,
    required this.height,
  });

  final String sectionId;
  final String title;
  final IconData leadingIcon;
  final Color leadingIconColor;
  final List<String> data;
  final double height;

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
                duration: const Duration(milliseconds: 200),
                turns: isExpanded ? 0.5 : 0,
                child: const Icon(Icons.keyboard_arrow_down_sharp),
              ),
            ),
            // Add the Divider here
            if (isExpanded)
              Divider(
                height: 1,
                thickness: 1,
                color: KColors.grey,
              ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              // height: isExpanded ? height : 0,
              height: isExpanded ? null : 0,
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(KSizes.sm),
                          bottomRight: Radius.circular(KSizes.sm),
                        ),
                        child:
                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: data
                            //       .map((item) => _buildInfoRow(
                            //           context, item.label, item.value, item.icon))
                            //       .toList(),
                            // ),
                            Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: data.map((data) {
                            return GestureDetector(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                  vertical: 8.0,
                                ),
                                decoration: BoxDecoration(
                                  color: KColors.lightBackground,

                                  borderRadius: BorderRadius.circular(20),
                                  // border: Border.all(
                                  //   color: isSelected
                                  //       ? KColors.primary
                                  //       : KColors.grey,
                                  // ),
                                ),
                                child: Text(
                                  data,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: KSizes.sm),
                      Divider(
                        color: KColors.grey,
                      ),
                      SizedBox(height: KSizes.sm),
                      InkWell(
                        onTap: () {},
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
                      // SizedBox(height: KSizes.md),
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
}
