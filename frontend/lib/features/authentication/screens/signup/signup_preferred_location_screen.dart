import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/appbar/appbar.dart';
import 'package:frontend/common/widgets/buttons/custom_button.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:frontend/features/authentication/providers/location_provider.dart';
import 'package:frontend/features/authentication/screens/signup/widgets/address_selection_section.dart';
import 'package:frontend/features/authentication/screens/signup/widgets/district_selection_section.dart';
import 'package:frontend/features/authentication/screens/signup/widgets/municipality_selection_section.dart';
import 'package:frontend/features/authentication/screens/signup/widgets/province_selection_section.dart';
import 'package:provider/provider.dart';

class SignupPreferredLocationScreen extends StatelessWidget {
  const SignupPreferredLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(KDeviceUtils.getAppBarHeight() + 5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Appbar(isActionRequired: false),
            Row(
              children: [
                Container(
                  color: KColors.primary,
                  height: 5.h,
                  width: 150.w,
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
      body: Consumer<LocationProvider>(
        builder: (context, locationProvider, _) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: KSizes.md),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header Section
                  Column(
                    children: [
                      SizedBox(height: KSizes.defaultSpace),
                      Text(
                        "Where are you looking for work?",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                      ),
                      SizedBox(height: KSizes.xs),
                      Text(
                        "Select a location by priority",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: KColors.darkerGrey,
                              fontSize: 17.sp,
                            ),
                      ),
                      SizedBox(height: KSizes.defaultSpace),
                    ],
                  ),

                  // Province Selection Section
                  ProvinceSelectionSection(
                    locationProvider: locationProvider,
                  ),

                  // District Selection Section (only shown when province is minimized)

                  SizedBox(height: KSizes.md),
                  DistrictSelectionSection(
                    locationProvider: locationProvider,
                  ),
                  // ],

                  // Municipality Selection Section (only shown when district is minimized)

                  SizedBox(height: KSizes.md),
                  MunicipalitySelectionSection(
                    locationProvider: locationProvider,
                  ),

                  // Address Selection Section (only shown when Municipality is minimized)

                  SizedBox(height: KSizes.md),
                  AddressSelectionSection(
                    locationProvider: locationProvider,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
