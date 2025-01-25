import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/common/widgets/buttons/custom_button.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:frontend/features/dashboard/widgets/status_and_saved_jobs_appbar.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:go_router/go_router.dart';

class LoginRedirect extends StatelessWidget {
  const LoginRedirect({
    super.key,
    required this.isMatchedJobs,
  });
  final bool isMatchedJobs;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(KDeviceUtils.getAppBarHeight()),
        child: StatusAndSavedJobsAppbar(
          appbarText: isMatchedJobs ? l10n.saved_jobs : l10n.my_status,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: KSizes.spaceBtwSections * 1.5,
            vertical: KSizes.defaultSpace),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/images/content/rojgari_icon.svg"),
              SizedBox(height: KSizes.md),
              Column(
                children: [
                  Text(
                    "${l10n.join_rojgari_today}",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(height: KSizes.sm),
                  Text(
                    "${l10n.unlock_new_opportunities_on_rojgari}",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: KColors.black,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(height: KSizes.sm),
              Divider(
                color: KColors.grey,
              ),
              SizedBox(height: KSizes.sm),
              CustomButton(
                text: l10n.sign_in,
                onPressed: () {
                  context.pushNamed(RoutesConstant.login);
                },
              ),
              SizedBox(height: KSizes.md - 4),
              GestureDetector(
                onTap: () {
                  context.pushNamed(RoutesConstant.signup);
                },
                child: Text(
                  "${l10n.sign_up}",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: KColors.primary,
                      ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
