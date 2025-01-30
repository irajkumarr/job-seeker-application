
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class UserIconWithAddButton extends StatelessWidget {
  const UserIconWithAddButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(KSizes.sm),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: KColors.grey,
            ),
          ),
          child: Icon(
            Iconsax.user,
            size: 80.sp,
            weight: 3,
          ),
        ),
        Positioned(
          bottom: 7,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: KColors.primary,
            ),
            child: Icon(
              Icons.add,
              color: KColors.white,
            ),
          ),
        )
      ],
    );
  }
}
