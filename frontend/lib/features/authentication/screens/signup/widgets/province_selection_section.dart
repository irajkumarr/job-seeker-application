import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/buttons/custom_button.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/features/authentication/providers/location_provider.dart';
class ProvinceSelectionSection extends StatelessWidget {
  const ProvinceSelectionSection({
    super.key,
    required this.locationProvider,
  });
  final LocationProvider locationProvider;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: KColors.white,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: KSizes.sm, vertical: KSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Province",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                locationProvider.selectedProvince == null ||
                        !locationProvider.isMinimizedProvince
                    ? SizedBox()
                    : Text(
                        locationProvider.selectedProvince?.name ?? "",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontSize: 18.sp,
                              color: KColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
              ],
            ),
            // Province Selection Wrap
            if (!locationProvider.isMinimizedProvince) ...[
              SizedBox(height: KSizes.md),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: locationProvider.provinces.map((province) {
                  final isSelected =
                      locationProvider.selectedProvince == province;

                  return GestureDetector(
                    onTap: () {
                      if (locationProvider.selectedProvince == province) {
                        locationProvider.setSelectedProvince(null);
                      } else {
                        locationProvider.setSelectedProvince(province);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: isSelected ? KColors.secondary : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? KColors.primary : KColors.grey,
                        ),
                      ),
                      child: Text(
                        province.name,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: KSizes.md),
              if (locationProvider.selectedProvince != null)
                CustomButton(
                  text: "Next",
                  onPressed: () {
                    locationProvider.toggleMinimizedProvince();
                  },
                ),
            ],
          ],
        ),
      ),
    );
  }
}
