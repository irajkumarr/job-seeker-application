import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isIconShowed = false,
    this.icon,
    this.color = KColors.primary,
  });

  final String text;
  final VoidCallback onPressed;
  final bool isIconShowed;
  final IconData? icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: color,
            splashFactory: NoSplash.splashFactory,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: KSizes.xs,
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: KColors.white,
                  ),
            ),
            isIconShowed
                ? Icon(
                    icon,
                    color: KColors.white,
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
