import 'package:flutter/material.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/data/models/job_model.dart';
import 'package:frontend/features/dashboard/screens/job_details/widgets/info_row.dart';
import 'package:frontend/l10n/l10n.dart';

class BasicInformationSection extends StatelessWidget {
  const BasicInformationSection({Key? key, required this.job})
      : super(key: key);
  final JobModel job;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(KSizes.md),
          decoration: BoxDecoration(
            color: KColors.secondaryBackground,
            borderRadius: BorderRadius.circular(KSizes.sm),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${l10n.basic_information}",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: KColors.black,
                    ),
              ),
              SizedBox(height: KSizes.sm),
              InfoRow(
                  label: '${l10n.no_of_vacancy}',
                  value: job.basicInformation.noOfVacancy.toStringAsFixed(0)),
              InfoRow(
                label: '${l10n.location}',
                value: "${job.location.district}",
              ),
              InfoRow(
                  label: '${l10n.salary}',
                  value:
                      "${l10n.nrs} ${job.salary.toStringAsFixed(0)} ${l10n.monthly}"),
              InfoRow(
                  label: '${l10n.job_level}',
                  value: job.basicInformation.jobLevel),
              InfoRow(label: '${l10n.job_type}', value: job.type),
              InfoRow(
                  label: '${l10n.age}',
                  value:
                      "${job.basicInformation.age.min} - ${job.basicInformation.age.max}"),
              InfoRow(
                  label: '${l10n.gender}', value: job.basicInformation.gender),
              InfoRow(
                  label: '${l10n.education}',
                  value: job.basicInformation.education),
              InfoRow(
                  label: '${l10n.experience}',
                  value: job.basicInformation.experience.toStringAsFixed(0) !=
                          "0"
                      ? "${job.basicInformation.experience.toStringAsFixed(0)} ${l10n.years}"
                      : "Not Required"),
              InfoRow(
                  label: '${l10n.shift}', value: job.basicInformation.shift),
            ],
          ),
        ),
        SizedBox(height: KSizes.defaultSpace),
        // //skills container
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(KSizes.md),
          decoration: BoxDecoration(
            color: KColors.secondaryBackground,
            borderRadius: BorderRadius.circular(KSizes.sm),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${l10n.skills}",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: KColors.black,
                    ),
              ),
              SizedBox(height: KSizes.sm),
              //skills list
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: job.skills
                    .map((skill) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: KColors.lightContainer,
                            borderRadius: BorderRadius.circular(KSizes.md),
                          ),
                          child: Text(
                            skill,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: KColors.black,
                                    ),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
        SizedBox(height: KSizes.defaultSpace),
        //Personal qualities container
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(KSizes.md),
          decoration: BoxDecoration(
            color: KColors.secondaryBackground,
            borderRadius: BorderRadius.circular(KSizes.sm),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${l10n.personal_qualities}",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: KColors.black,
                    ),
              ),
              SizedBox(height: KSizes.sm),
              //personal qualities list
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: job.personalQualities
                    .map((personalQuality) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: KColors.lightContainer,
                            borderRadius: BorderRadius.circular(KSizes.md),
                          ),
                          child: Text(
                            personalQuality,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: KColors.black,
                                    ),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),

        SizedBox(height: KSizes.defaultSpace),
        //benefits container
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(KSizes.md),
          decoration: BoxDecoration(
            color: KColors.secondaryBackground,
            borderRadius: BorderRadius.circular(KSizes.sm),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${l10n.benefits}",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: KColors.black,
                    ),
              ),
              SizedBox(height: KSizes.sm),
              //benefits list
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: job.benefits
                    .map((benefit) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: KColors.lightContainer,
                            borderRadius: BorderRadius.circular(KSizes.md),
                          ),
                          child: Text(
                            benefit,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: KColors.black,
                                    ),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
