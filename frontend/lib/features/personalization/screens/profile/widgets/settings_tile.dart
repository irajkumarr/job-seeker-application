

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/constants/colors.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.text,
    required this.onTap,
    this.iconColor = KColors.darkerGrey,
    this.textColor = KColors.darkerGrey,
    required this.icon,
    this.isIconImage = false,
    this.iconImage,
  });
  final String text;
  final VoidCallback onTap;
  final Color iconColor;
  final Color textColor;
  final IconData icon;
  final bool isIconImage;
  final String? iconImage;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      horizontalTitleGap: 10,
      leading: isIconImage
          ? Image.asset(
              iconImage!,
              width: 24.w,
              height: 24.h,
            )
          : Icon(
              icon,
              color: iconColor,
            ),
      title: Text(
        text,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
      ),
    );
  }
}