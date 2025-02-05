import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/buttons/custom_button.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/features/authentication/providers/location_provider.dart';
import 'package:frontend/l10n/l10n.dart';

class MunicipalitySelectionSection extends StatelessWidget {
  const MunicipalitySelectionSection({
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
                  "${l10n.municipality}",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                locationProvider.selectedMunicipality == null ||
                        !locationProvider.isMinimizedMunicipality
                    ? SizedBox()
                    : SizedBox(
                        width: 150.w,
                        child: Text(
                          locationProvider.selectedMunicipality?.name ?? "",
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontSize: 18.sp,
                                    color: KColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
              ],
            ),
            // Municipality Selection Wrap
            if (!locationProvider.isMinimizedMunicipality &&
                locationProvider.isMinimizedDistrict) ...[
              SizedBox(height: KSizes.md),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: locationProvider.selectedDistrict!.municipalities
                    .map((municipality) {
                  final isSelected =
                      locationProvider.selectedMunicipality == municipality;

                  return GestureDetector(
                    onTap: () {
                      if (locationProvider.selectedMunicipality ==
                          municipality) {
                        locationProvider.setSelectedMunicipality(null);
                      } else {
                        locationProvider.setSelectedMunicipality(municipality);
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
                        municipality.name,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: KSizes.md),
              if (locationProvider.selectedMunicipality != null)
                CustomButton(
                  text: "${l10n.next}",
                  onPressed: () {
                    // Handle district selection completion
                    locationProvider.toggleMinimizedMunicipality();
                  },
                ),
            ],
          ],
        ),
      ),
    );
  }
}
