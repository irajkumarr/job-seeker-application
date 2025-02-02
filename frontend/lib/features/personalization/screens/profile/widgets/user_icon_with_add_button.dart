

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:get_storage/get_storage.dart';
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
    final box = GetStorage();
    final String? localImage = box.read("profileImage");

    return GestureDetector(
      onTap: () {
        context.pushNamed(RoutesConstant.uploadProfile);
      },
      child: Stack(
        children: [
          Container(
            height: 100.h,
            width: 100.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: KColors.grey,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: localImage != null
                  ? Image.network(
                      localImage,
                      height: 100.h,
                      width: 100.w,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          _defaultIcon(),
                    )
                  : profileImage != null
                      ? CachedNetworkImage(
                          imageUrl: profileImage!,
                          height: 100.h,
                          width: 100.w,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => _defaultIcon(),
                          errorWidget: (context, url, error) => _defaultIcon(),
                        )
                      : _defaultIcon(),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 5,
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: KColors.primary,
              ),
              child: Icon(
                Icons.add,
                color: KColors.white,
                size: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Default icon widget
  Widget _defaultIcon() {
    return Icon(
      Iconsax.user,
      size: 80.sp,
      weight: 3,
    );
  }
}
