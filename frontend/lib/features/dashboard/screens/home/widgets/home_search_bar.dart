import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:go_router/go_router.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: () {
        context.pushNamed(RoutesConstant.search);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: KSizes.sm + 2),
        child: Container(
          height: KDeviceUtils.getAppBarHeight(),
          width: double.infinity,
          padding: EdgeInsets.only(right: KSizes.sm, left: KSizes.md),
          decoration: BoxDecoration(
              color: KColors.white,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: KColors.primaryContainer,
                width: 1.4,
              )),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  '${l10n.search_jobs}',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: KColors.darkGrey,
                      ),
                ),
              ),
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: KColors.primary,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Icon(
                  AntDesign.search1,
                  color: KColors.white,
                  // size: 28,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
