import 'package:flutter/material.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({
    super.key,
    this.size = KSizes.defaultSpace,
    this.isLoadingTextShowed = true,
    this.padding = const EdgeInsets.only(top: KSizes.md),
  });
  final double size;
  final bool isLoadingTextShowed;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: padding,
        child: Column(
          children: [
            LoadingAnimationWidget.staggeredDotsWave(
              color: KColors.primary,
              size: size,
            ),
            !isLoadingTextShowed
                ? SizedBox()
                : Text(
                    "${l10n.loading}",
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
