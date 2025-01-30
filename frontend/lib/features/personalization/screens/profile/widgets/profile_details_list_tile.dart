import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';

class ProfileDetailListTile extends StatelessWidget {
  const ProfileDetailListTile({
    super.key,
    required this.title,
    required this.leadingIcon,
    required this.onTap,
    required this.leadingIconColor,
  });
  final String title;
  final IconData leadingIcon;
  final Color leadingIconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8F0), // Light peach background
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Work Experience',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                Icon(
                  Icons.add_circle_outline,
                  color: KColors.secondary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Add Work Experience',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.orange[400],
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
