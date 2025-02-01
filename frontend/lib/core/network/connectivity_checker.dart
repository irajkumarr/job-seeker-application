import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';
import '../../common/widgets/alert_box/alert_box.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/image_strings.dart';
import '../utils/constants/sizes.dart';
import 'connectivity_provider.dart';

class ConnectivityChecker extends StatelessWidget {
  final Widget child;

  const ConnectivityChecker({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(
      builder: (context, connectivityProvider, _) {
        if (connectivityProvider.isChecking) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        } else if (connectivityProvider.connectivityResult
                .contains(ConnectivityResult.none)
            //  ==
            //     [ConnectivityResult.none]
            ) {
          // ignore: deprecated_member_use

          // ignore: deprecated_member_use
          return WillPopScope(
            onWillPop: () async {
              return await CustomAlertBox.alertCloseApp(context);
            },
            child: Scaffold(
              backgroundColor: KColors.white,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 200.h,
                        width: 200.w,
                        child: Image.asset(KImages.noInternet)),
                    const SizedBox(height: KSizes.md),
                    Text(
                      'Ooops!',
                      style: TextStyle(fontSize: 30.sp, color: Colors.black),
                    ),
                    SizedBox(height: KSizes.sm),
                    Text(
                      'No internet connection Found\n Check your Connection',
                      style: Theme.of(context).textTheme.titleSmall,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: KSizes.spaceBtwSections),
                    InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () async {
                        try {
                          // showToast("You're not connected");
                          // KSnackbar.Snackbar(
                          //     context,
                          //     "You're not connected...",
                          //     false,
                          //     KColors.error);
                          // showCustomToast(context, "You're not connected");

                          await connectivityProvider.checkConnectivity();
                        } catch (e) {
                          // showToast("Server Error");
                        }
                      },
                      child: Container(
                          padding: EdgeInsets.all(KSizes.sm),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            // color: KColors.primary,
                          ),
                          child: Text(
                            "Try Again",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: KColors.primary,
                                ),
                          )
                          // child: Icon(
                          //   Icons.refresh_outlined,
                          //   size: 35.sp,
                          //   color: KColors.primary,
                          // ),
                          ),
                    )
                  ],
                ),
              ),
            ),
          );
        } else {
          return child;
        }
      },
    );
  }
}
