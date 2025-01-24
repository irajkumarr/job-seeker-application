import 'package:flutter/material.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/data/models/job_model.dart';
import 'package:frontend/features/dashboard/screens/job_details/widgets/info_row.dart';

class BasicInformationSection extends StatelessWidget {
  const BasicInformationSection({Key? key, required this.job})
      : super(key: key);
  final JobModel job;

  @override
  Widget build(BuildContext context) {
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
                "Basic Information",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: KColors.black,
                    ),
              ),
              SizedBox(height: KSizes.sm),
              InfoRow(
                  label: 'No.Of Vacancy',
                  value: job.basicInformation.noOfVacancy.toStringAsFixed(0)),
              InfoRow(
                label: 'Location',
                value: job.location.fullAddress,
              ),
              InfoRow(
                  label: 'Salary',
                  value: "NRs. ${job.salary.toStringAsFixed(0)} monthly"),
              InfoRow(label: 'Job Level', value: job.basicInformation.jobLevel),
              InfoRow(label: 'Job Type', value: job.type),
              InfoRow(
                  label: 'Age',
                  value:
                      "${job.basicInformation.age.min} - ${job.basicInformation.age.max}"),
              InfoRow(label: 'Gender', value: job.basicInformation.gender),
              InfoRow(
                  label: 'Education', value: job.basicInformation.education),
              InfoRow(
                  label: 'Experience',
                  value:
                      "${job.basicInformation.experience.toStringAsFixed(0)} years"),
              InfoRow(label: 'Shift', value: job.basicInformation.shift),
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
                "Skills",
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
                "Personal Qualities",
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
                "Benefits",
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
