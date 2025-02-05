import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/buttons/custom_button.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/features/authentication/providers/location_provider.dart';
import 'package:frontend/l10n/l10n.dart';
class DistrictSelectionSection extends StatelessWidget {
  const DistrictSelectionSection({
    super.key,
    required this.locationProvider,
  });

  final LocationProvider locationProvider;
  @override
  Widget build(BuildContext context) {
    
    final l10n = AppLocalizations.of(context)!;
    return Card(
      color: KColors.white,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: KSizes.sm, vertical: KSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${l10n.district}",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                locationProvider.selectedDistrict == null ||
                        !locationProvider.isMinimizedDistrict
                    ? SizedBox()
                    : Text(
                        locationProvider.selectedDistrict?.name ?? "",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontSize: 18.sp,
                              color: KColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
              ],
            ),
            // District  Selection Wrap
            if (!locationProvider.isMinimizedDistrict &&
                locationProvider.isMinimizedProvince) ...[
              SizedBox(height: KSizes.md),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: locationProvider.selectedProvince!.districts
                    .map((district) {
                  final isSelected =
                      locationProvider.selectedDistrict == district;

                  return GestureDetector(
                    onTap: () {
                      if (locationProvider.selectedDistrict == district) {
                        locationProvider.setSelectedDistrict(null);
                      } else {
                        locationProvider.setSelectedDistrict(district);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? KColors.secondary : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? KColors.primary : KColors.grey,
                        ),
                      ),
                      child: Text(
                        district.name,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: KSizes.md),
              if (locationProvider.selectedDistrict != null)
                CustomButton(
                  text: "${l10n.next}",
                  onPressed: () {
                    // Handle district selection completion
                    locationProvider.toggleMinimizedDistrict();
                  },
                ),
            ],
          ],
        ),
      ),
    );
  }
}