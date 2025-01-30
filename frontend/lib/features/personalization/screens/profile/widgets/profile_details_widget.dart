
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/features/personalization/providers/profile_provider.dart';
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
    required this.onAdd, // Callback for adding data
  });

  final String sectionId;
  final String title;
  final IconData leadingIcon;
  final Color leadingIconColor;
  final bool isImage;
  final bool isRating;
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
                duration: const Duration(milliseconds: 200),
                turns: isExpanded ? 0.5 : 0,
                child: const Icon(Icons.keyboard_arrow_down_sharp),
              ),
            ),
            if (isExpanded)
              const Divider(height: 1, thickness: 1, color: Colors.grey),
            AnimatedSize(
              duration: const Duration(milliseconds: 500),
              curve: Curves.linear,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                height: isExpanded ? null : 0,
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Container(
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
                        const Divider(),
                        SizedBox(height: 8.h),
                        InkWell(
                          onTap: onAdd, // Handle Add button
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
                  const SizedBox(height: 4),
                  isImage
                      ? Image.network(item['value'])
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
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[600]),
                            ),
                ]
              ],
            ),
          ),
          TextButton(
            onPressed: item['onEdit'] ?? () {},
            child: const Text("Edit", style: TextStyle(color: Colors.blue)),
          ),
          TextButton(
            onPressed: item['onDelete'] ?? () {},
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
