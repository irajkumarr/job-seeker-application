import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/constants/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text, required this.onPressed,
  });

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: ElevatedButton(
        onPressed:onPressed,
        style: ElevatedButton.styleFrom(
            splashFactory: NoSplash.splashFactory,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            )),
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: KColors.white,
              ),
        ),
      ),
    );
  }
}
