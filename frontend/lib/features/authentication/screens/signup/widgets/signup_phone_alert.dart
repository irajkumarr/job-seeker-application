import 'package:flutter/material.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:go_router/go_router.dart';

Future<void> signupPhoneAlert(BuildContext context, String mobileNumber) async {
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
                    'Is this mobile number correct?',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: KColors.black,
                          fontWeight: FontWeight.w600,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: KSizes.xs),
                  Text(
                    "977-$mobileNumber",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: KColors.black,
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
                            "Edit",
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
                          onPressed: () {
                            // Navigator.of(context).pop();
                            context.goNamed(RoutesConstant.signupPassword);
                            // SystemNavigator.pop();
                          },
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
