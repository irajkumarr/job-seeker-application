import 'package:flutter/material.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({
    super.key,
    this.size = KSizes.defaultSpace,
  });
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: KSizes.md),
        child: Column(
          children: [
            LoadingAnimationWidget.staggeredDotsWave(
              color: KColors.primary,
              size: size,
            ),
            Text(
              "Loading...",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: KColors.primary,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
