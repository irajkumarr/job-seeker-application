// import 'package:flutter/material.dart';
// import 'package:frontend/common/widgets/alert_box/snackbar.dart';
// import 'package:frontend/core/routes/routes_constant.dart';
// import 'package:frontend/core/utils/constants/colors.dart';
// import 'package:frontend/core/utils/constants/sizes.dart';
// import 'package:frontend/core/utils/device/device_utility.dart';
// import 'package:frontend/features/authentication/providers/signup_provider.dart';
// import 'package:frontend/l10n/l10n.dart';
// import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';

// Future<void> signupPhoneAlert(
//     BuildContext context, String mobileNumber, String name) async {
//   final l10n = AppLocalizations.of(context)!;

//   final signupProvider = Provider.of<SignupProvider>(context, listen: false);
//   return await showDialog(
//     barrierDismissible: false,
//     context: context,
//     builder: (BuildContext context) {
//       return PopScope(
//         // canPop: false,
//         child: SizedBox(
//           width: KDeviceUtils.getScreenWidth(context),
//           child: Dialog(
//             insetPadding: EdgeInsets.symmetric(horizontal: KSizes.md),
//             backgroundColor: KColors.white,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(KSizes.sm),
//             ),
//             child: Container(
//               width: KDeviceUtils.getScreenWidth(context),
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     'Is this mobile number correct?',
//                     style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                           color: KColors.black,
//                           fontWeight: FontWeight.w600,
//                         ),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: KSizes.xs),
//                   Text(
//                     "977-$mobileNumber",
//                     style: Theme.of(context).textTheme.headlineMedium!.copyWith(
//                           color: KColors.black,
//                         ),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: KSizes.xs),
//                   Divider(
//                     color: KColors.grey,
//                   ),
//                   SizedBox(height: KSizes.sm),
//                   Row(
//                     spacing: KSizes.md,
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Expanded(
//                         child: TextButton(
//                           style: ElevatedButton.styleFrom(
//                             padding:
//                                 EdgeInsets.symmetric(vertical: KSizes.md - 2),
//                             backgroundColor: KColors.secondaryBackground,
//                           ),
//                           child: Text(
//                             "Edit",
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .titleSmall!
//                                 .copyWith(
//                                   color: KColors.darkerGrey,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                           ),
//                           onPressed: () {
//                             context.pop();
//                           },
//                         ),
//                       ),
//                       Expanded(
//                         child: TextButton(
//                           style: ElevatedButton.styleFrom(
//                             padding:
//                                 EdgeInsets.symmetric(vertical: KSizes.md - 2),
//                             backgroundColor: KColors.primary,
//                           ),
//                           child: Text(
//                             "${l10n.yes}",
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .titleSmall!
//                                 .copyWith(
//                                   color: KColors.white,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                           ),
//                           onPressed: () async {
//                             // Check if mobile number exists
//                             context.pop();
//                             final isValid = await signupProvider
//                                 .checkMobileNumber(mobileNumber);
//                             // if (context.mounted) {
//                             // }
//                             if (isValid) {
//                               // Navigate to password screen if mobile number doesn't exist
//                               // if (context.mounted) {
//                               context.goNamed(RoutesConstant.signupPassword,
//                                   extra: {
//                                     "name": name,
//                                     "mobileNumber": mobileNumber,
//                                   });
//                               // }
//                             } else {
//                               // Show error if mobile number exists
//                               // if (context.mounted) {
//                               KSnackbar.CustomSnackbar(
//                                   context, signupProvider.error, KColors.error);
//                               // }
//                             }
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }

import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/alert_box/snackbar.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:frontend/features/authentication/providers/signup_provider.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

Future<void> signupPhoneAlert(
    BuildContext context, String mobileNumber, String name) async {
  final l10n = AppLocalizations.of(context)!;
  final signupProvider = Provider.of<SignupProvider>(context, listen: false);
  final navigator = GoRouter.of(context);

  return await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      return PopScope(
        child: SizedBox(
          width: KDeviceUtils.getScreenWidth(dialogContext),
          child: Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: KSizes.md),
            backgroundColor: KColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(KSizes.sm),
            ),
            child: Container(
              width: KDeviceUtils.getScreenWidth(dialogContext),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Is this mobile number correct?',
                    style:
                        Theme.of(dialogContext).textTheme.bodyLarge!.copyWith(
                              color: KColors.black,
                              fontWeight: FontWeight.w600,
                            ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: KSizes.xs),
                  Text(
                    "977-$mobileNumber",
                    style: Theme.of(dialogContext)
                        .textTheme
                        .headlineMedium!
                        .copyWith(
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
                            style: Theme.of(dialogContext)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: KColors.darkerGrey,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          onPressed: () {
                            dialogContext.pop();
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
                            l10n.yes,
                            style: Theme.of(dialogContext)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: KColors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          onPressed: () async {
                            // Close the dialog using GoRouter
                            dialogContext.pop();

                            // Check if mobile number exists
                            final isValid = await signupProvider
                                .checkMobileNumber(mobileNumber);

                            if (context.mounted) {
                              if (isValid) {
                                // Navigate using the stored navigator
                                navigator.goNamed(
                                  RoutesConstant.signupPassword,
                                  extra: {
                                    "name": name,
                                    "mobileNumber": mobileNumber,
                                  },
                                );
                              } else {
                                // Show error if mobile number exists
                                KSnackbar.CustomSnackbar(
                                  context,
                                  signupProvider.error,
                                  KColors.error,
                                );
                              }
                            }
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
