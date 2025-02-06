import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_screen/custom_screen.dart';
import 'package:frontend/common/widgets/loaders/full_screen_overlay.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/divider/dotted_divider.dart';
import 'package:frontend/data/models/other_information_model.dart';
import 'package:frontend/data/models/profile_detail_model.dart';
import 'package:frontend/features/personalization/providers/other_information_provider.dart';
import 'package:frontend/features/personalization/providers/profile_provider.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class OtherInformationScreen extends StatefulWidget {
  const OtherInformationScreen({super.key, this.otherInformation});
  final Otherinformation? otherInformation;
  @override
  State<OtherInformationScreen> createState() => _OtherInformationScreenState();
}

class _OtherInformationScreenState extends State<OtherInformationScreen> {
  late bool willingToTravel;
  late bool willingToRelocate;
  late bool hasTwoWheelerLicense;
  late bool hasFourWheelerLicense;
  late bool ownsTwoWheeler;
  late bool ownsFourWheeler;

  @override
  void initState() {
    super.initState();

    final otherInfo = widget.otherInformation;

    willingToTravel =
        otherInfo?.willingToTravelOutsideResidingLocation ?? false;
    willingToRelocate =
        otherInfo?.willingToRelocateOutsideResidingLocation ?? false;
    hasTwoWheelerLicense = otherInfo?.haveTwoWheelerDrivingLicense ?? false;
    hasFourWheelerLicense = otherInfo?.havefourWheelerDrivingLicense ?? false;
    ownsTwoWheeler = otherInfo?.ownTwoWheelerVehicle ?? false;
    ownsFourWheeler = otherInfo?.ownFourWheelerVehicle ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);

    final otherInformationProvider =
        Provider.of<OtherInformationProvider>(context);
    final l10n = AppLocalizations.of(context)!;
    return FullScreenOverlay(
      isLoading: otherInformationProvider.isLoading,
      child: CustomScreen(
        onPressed: () {
          OtherInformationModel model = OtherInformationModel(
            willingToTravelOutsideResidingLocation: willingToTravel,
            willingToRelocateOutsideResidingLocation: willingToRelocate,
            haveTwoWheelerDrivingLicense: hasTwoWheelerLicense,
            havefourWheelerDrivingLicense: hasFourWheelerLicense,
            ownTwoWheelerVehicle: ownsTwoWheeler,
            ownFourWheelerVehicle: ownsFourWheeler,
          );
          otherInformationProvider.updateOtherInformation(context, model,
              () async {
            await profileProvider.fetchProfile(forceRefresh: true);
            context.pop();
          });
        },
        buttonText: "${l10n.submit}",
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: KSizes.md,
            vertical: KSizes.defaultSpace,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${l10n.other_information}",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
              SizedBox(height: KSizes.defaultSpace),
              Form(
                child: Column(
                  children: [
                    SwitchTextTile(
                      title: "${l10n.will_you_travel_outside_during_job}",
                      isValue: willingToTravel,
                      onChanged: (value) =>
                          setState(() => willingToTravel = value),
                    ),
                    SwitchTextTile(
                      title: "${l10n.will_you_temporarily_relocate_during_job}",
                      isValue: willingToRelocate,
                      onChanged: (value) =>
                          setState(() => willingToRelocate = value),
                    ),
                    SwitchTextTile(
                      title: "${l10n.have_two_wheeler_license}",
                      isValue: hasTwoWheelerLicense,
                      onChanged: (value) =>
                          setState(() => hasTwoWheelerLicense = value),
                    ),
                    SwitchTextTile(
                      title: "${l10n.have_four_wheeler_license}",
                      isValue: hasFourWheelerLicense,
                      onChanged: (value) =>
                          setState(() => hasFourWheelerLicense = value),
                    ),
                    SwitchTextTile(
                      title: "${l10n.own_two_wheeler}",
                      isValue: ownsTwoWheeler,
                      onChanged: (value) =>
                          setState(() => ownsTwoWheeler = value),
                    ),
                    SwitchTextTile(
                      title: "${l10n.own_four_wheeler}",
                      isValue: ownsFourWheeler,
                      onChanged: (value) =>
                          setState(() => ownsFourWheeler = value),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget SwitchTextTile({
    required String title,
    required bool isValue,
    required ValueChanged<bool> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        SizedBox(height: KSizes.md),
        Switch(
          value: isValue,
          onChanged: onChanged,
          activeColor: KColors.primary,
        ),
        SizedBox(height: KSizes.md),
        DottedDivider(),
        SizedBox(height: KSizes.md),
      ],
    );
  }
}
