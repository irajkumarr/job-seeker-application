import 'package:flutter/material.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/shimmers/full_shimmer.dart';
import 'package:frontend/data/models/job_model.dart';
import 'package:frontend/features/dashboard/providers/job_provider.dart';
import 'package:frontend/features/dashboard/screens/home/widgets/job_card.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:provider/provider.dart';

class HomeAllJobsSection extends StatelessWidget {
  const HomeAllJobsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final jobProvider = Provider.of<JobProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KSizes.md),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${l10n.all} ${l10n.jobs}",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              jobProvider.isLoading
                  ? Text("....")
                  : Text(
                      "${jobProvider.jobs?.length ?? 0} ${l10n.jobs} ${l10n.available}",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: KColors.darkGrey,
                          ),
                    ),
            ],
          ),
          SizedBox(height: KSizes.md),

          //showing all available jobs

          jobProvider.isLoading
              ? FullShimmer()
              : ListView.builder(
                  itemCount: jobProvider.jobs?.length ?? 0,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final JobModel job = jobProvider.jobs![index];

                    return JobCard(job: job);
                  },
                ),
        ],
      ),
    );
  }
}
