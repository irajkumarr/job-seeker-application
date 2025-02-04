import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.image,
      required this.isButtonShowed,
      this.buttonText,  this.onPressed});
  final String title;
  final String subTitle;
  final String image;
  final bool isButtonShowed;
  final String? buttonText;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: KSizes.md, vertical: KSizes.md),
      child: Column(
        children: [
          SizedBox(
            height: 100.h,
            width: 100.h,
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: KSizes.md),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                ),
          ),
          SizedBox(height: 8),
          Text(
            subTitle,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: KSizes.md),
          !isButtonShowed
              ? SizedBox()
              : SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: KColors.darkGrey),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(KSizes.defaultSpace)),
                    ),
                    onPressed: onPressed,
                    child: Text(
                      buttonText!,
                      style: TextStyle(color: KColors.primary),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
