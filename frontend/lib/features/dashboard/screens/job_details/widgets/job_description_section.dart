import 'package:flutter/material.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/data/models/job_model.dart';
import 'package:frontend/l10n/l10n.dart';

class JobDescriptionSection extends StatelessWidget {
  const JobDescriptionSection({Key? key, required this.job}) : super(key: key);
  final JobModel job;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: KColors.secondaryBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDescriptionSection(
            '${l10n.job_description}',
            'We are seeking a professional Receptionist to be the first point of contact for our company. The ideal candidate will have excellent communication skills and a pleasant personality.',
          ),
          const SizedBox(height: 16),
          _buildDescriptionSection(
            '${l10n.responsibilities}',
            '• Welcoming visitors and directing them to the appropriate department\n'
                '• Managing incoming calls and maintaining call records\n'
                '• Receiving and sorting daily mail/deliveries\n'
                '• Scheduling meetings and maintaining office calendar\n'
                '• Maintaining office security by following safety procedures\n'
                '• Managing office supplies inventory',
          ),
          const SizedBox(height: 16),
          _buildDescriptionSection(
            '${l10n.requirements}',
            '• +2 / Intermediate Pass in any discipline\n'
                '• Excellent verbal and written communication skills in English and Nepali\n'
                '• Proficiency in MS Office applications\n'
                '• Previous experience as a Receptionist is preferred\n'
                '• Strong organizational and multitasking abilities\n'
                '• Professional appearance and friendly demeanor',
          ),
          const SizedBox(height: 16),
          _buildDescriptionSection(
            '${l10n.benefits}',
            '• Competitive salary package\n'
                '• Health insurance\n'
                '• Paid leaves\n'
                '• Festival bonuses\n'
                '• Performance-based incentives\n'
                '• Training and development opportunities',
          ),
          SizedBox(height: KSizes.md),
          job.allowFreshers
              ? Text(
                  "${l10n.freshers_are_enrouged_to_apply}",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w700,
                        color: KColors.black,
                      ),
                )
              : SizedBox(),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black87,
            fontWeight: FontWeight.w400,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
