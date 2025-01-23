import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';

class QuickLinksTile extends StatelessWidget {
  const QuickLinksTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: KSizes.md - 4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(KSizes.sm),
        child: Container(
          width: 135.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(KSizes.sm),
              border: Border.all(
                color: KColors.lightContainer,
              )),
          padding: EdgeInsets.all(KSizes.sm),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: KColors.primaryContainer,
                  borderRadius: BorderRadius.circular(50),
                ),
                width: 50.w,
                height: 50.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Icon(icon),
                ),
              ),
              SizedBox(height: KSizes.sm),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
