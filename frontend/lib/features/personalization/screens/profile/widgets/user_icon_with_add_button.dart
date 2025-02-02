import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

class UserIconWithAddButton extends StatelessWidget {
  const UserIconWithAddButton({
    super.key,
    this.profileImage,
  });
  final String? profileImage;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(RoutesConstant.uploadProfile);
      },
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(KSizes.md),
            clipBehavior: Clip.none,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: KColors.grey,
              ),
            ),
            child: profileImage != null
                ? SizedBox(
                    height: 100.h,
                    width: 100.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        profileImage!,
                        height: 100.h,
                        width: 100.w,
                        fit: BoxFit.cover,
                      ),
                    ))
                : Icon(
                    Iconsax.user,
                    size: 80.sp,
                    weight: 3,
                  ),
          ),
          Positioned(
            bottom: 10,
            right: 5,
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
      ),
    );
  }
}
