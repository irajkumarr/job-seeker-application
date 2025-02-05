import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/appbar/appbar.dart';
import 'package:frontend/common/widgets/buttons/custom_button.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:frontend/data/models/profile_detail_model.dart';
import 'package:frontend/features/authentication/providers/signup_provider.dart';
import 'package:frontend/features/personalization/providers/profile_provider.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:frontend/navigation_menu.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignupFormCompletedScreen extends StatelessWidget {
  const SignupFormCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(KDeviceUtils.getAppBarHeight() + 5.h),
        child: Column(
          children: [
            Appbar(isActionRequired: false),
            Row(
              children: [
                Container(
                  color: KColors.primary,
                  height: 5.h,
                  width: KDeviceUtils.getScreenWidth(context),
                ),
                Expanded(
                  child: Container(
                    color: KColors.grey,
                    height: 5.h,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: PopScope(
        canPop: false,
        child: Padding(
          padding: EdgeInsets.all(KSizes.spaceBtwSections),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  child: SizedBox(
                    width: 200.w,
                    height: 200.h,
                    child: Image.asset(
                      "assets/images/content/register_success.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Text(
                  "${l10n.signup_form_completed}",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                ),
                SizedBox(height: KSizes.xs),
                Text(
                  "${profileProvider.profile?.name ?? ""}, ${l10n.you_are_all_set_to_apply}",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: KColors.darkerGrey,
                        fontSize: 17.sp,
                      ),
                ),
                SizedBox(height: KSizes.md),
                Divider(
                  color: KColors.grey,
                ),
                SizedBox(height: KSizes.md),
                SizedBox(
                  width: 200.w,
                  child: CustomButton(
                      text: "${l10n.continue_name}",
                      onPressed: () {
                        context.read<NavigationProvider>().onTap(0);
                        context.goNamed(RoutesConstant.navigationMenu);
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
