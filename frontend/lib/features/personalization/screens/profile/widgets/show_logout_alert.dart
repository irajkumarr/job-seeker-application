import 'package:flutter/material.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:go_router/go_router.dart';

Future<void> alertLogout(BuildContext context, VoidCallback onPressed) async {
  final l10n = AppLocalizations.of(context)!;
  return await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return PopScope(
        // canPop: false,
        child: SizedBox(
          width: KDeviceUtils.getScreenWidth(context),
          child: Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: KSizes.md),
            backgroundColor: KColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(KSizes.sm),
            ),
            child: Container(
              width: KDeviceUtils.getScreenWidth(context),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${l10n.logout_of_your_account}',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: KColors.black,
                          fontWeight: FontWeight.w600,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: KSizes.xs),
                  Text(
                    "${l10n.you_will_not_be_able_to_undo}",
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: KColors.darkGrey,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: KSizes.xs),
                  Divider(
                    color: KColors.grey,
                  ),
                  SizedBox(height: KSizes.sm),
                  Row(
                    spacing: KSizes.md,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TextButton(
                          style: ElevatedButton.styleFrom(
                            padding:
                                EdgeInsets.symmetric(vertical: KSizes.md - 2),
                            backgroundColor: KColors.secondaryBackground,
                          ),
                          child: Text(
                            "${l10n.no}",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: KColors.darkerGrey,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          onPressed: () {
                            context.pop();
                          },
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          style: ElevatedButton.styleFrom(
                            padding:
                                EdgeInsets.symmetric(vertical: KSizes.md - 2),
                            backgroundColor: KColors.primary,
                          ),
                          child: Text(
                            "${l10n.yes}",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: KColors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          onPressed: onPressed,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
