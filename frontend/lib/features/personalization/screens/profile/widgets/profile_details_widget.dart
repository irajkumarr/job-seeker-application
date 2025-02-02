import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/features/personalization/providers/profile_provider.dart';
import 'package:frontend/features/personalization/screens/profile/widgets/image_preview.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProfileDetailsWidget extends StatelessWidget {
  const ProfileDetailsWidget({
    super.key,
    required this.sectionId,
    required this.title,
    required this.leadingIcon,
    required this.leadingIconColor,
    required this.data,
    this.isImage = false,
    this.isRating = false,
    required this.height,
    required this.onAdd,
    this.isEditShowed = true, // Callback for adding data
  });

  final String sectionId;
  final String title;
  final IconData leadingIcon;
  final Color leadingIconColor;
  final bool isImage;
  final bool isRating;
  final bool isEditShowed;
  final List<Map<String, dynamic>> data; // Generic list of data maps
  final double height;
  final VoidCallback onAdd; // Function to handle "Add" button

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
              contentPadding:
                  EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
              tileColor: KColors.secondaryBackground,
              shape: RoundedRectangleBorder(
                borderRadius: !isExpanded
                    ? BorderRadius.circular(8.r)
                    : BorderRadius.vertical(top: Radius.circular(8.r)),
              ),
              leading: Icon(leadingIcon, color: leadingIconColor),
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
              Container(
                color: KColors.secondaryBackground,
                child: const Divider(
                  height: 1,
                  indent: KSizes.md + 4,
                  endIndent: KSizes.md + 4,
                  color: KColors.grey,
                ),
              ),
            AnimatedSlide(
              duration: const Duration(milliseconds: 700),
              offset: isExpanded ? Offset.zero : const Offset(0, -0.1),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 700),
                opacity: isExpanded ? 1.0 : 0.0,
                child: ClipRect(
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.easeInOut,
                    child: Container(
                      height: isExpanded ? null : 0,
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: KColors.secondaryBackground,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8.r),
                          bottomRight: Radius.circular(8.r),
                        ),
                      ),
                      child: Column(
                        children: [
                          ...data
                              .map((item) => _buildInfoRow(context, item))
                              .toList(),
                          const Divider(
                            color: KColors.grey,
                          ),
                          SizedBox(height: 8.h),
                          InkWell(
                            onTap: onAdd,
                            borderRadius: BorderRadius.circular(8.r),
                            child: Row(
                              children: [
                                const Icon(Icons.add_circle,
                                    color: Colors.black54),
                                SizedBox(width: 8.w),
                                Text(
                                  "Add $title",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontSize: 14.sp),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Build dynamic row from map data
  Widget _buildInfoRow(BuildContext context, Map<String, dynamic> item) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            item['icon'] ?? Icons.info,
            size: 24,
            color: Colors.grey[600],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['label'] ?? "",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                if (item['value'] != null) ...[
                  const SizedBox(height: KSizes.md),
                  isImage
                      ? GestureDetector(
                          onTap: () {},
                          child: GestureDetector(
                            onTap: () {
                              // showImagePreview(context, item['value']);
                              context.pushNamed(
                                RoutesConstant.imagePreview,
                                extra: {
                                  'file': null,
                                  'image': item['value'],
                                  'isFile': false,
                                },
                              );
                            },
                            child: Center(
                              child: Image.network(
                                item['value'],
                              ),
                            ),
                          ),
                        )
                      : isRating
                          ? RatingBar.builder(
                              initialRating: item["value"],
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 18,
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: KColors.primary,
                              ),
                              onRatingUpdate: (rating) {
                                // You can handle the rating update here (if required)
                                // print(rating);
                              },
                            )
                          : Text(
                              item['value'],
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    fontSize: 14.sp,
                                  ),
                            ),
                ]
              ],
            ),
          ),
          TextButton(
            onPressed: item['onDelete'] ?? () {},
            child: const Text("Delete", style: TextStyle(color: KColors.error)),
          ),
          !isEditShowed
              ? SizedBox()
              : TextButton(
                  onPressed: item['onEdit'] ?? () {},
                  child: const Text("Edit",
                      style: TextStyle(color: KColors.primary)),
                ),
        ],
      ),
    );
  }
}
