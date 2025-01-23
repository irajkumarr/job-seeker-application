import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/shimmers/categories_vertical_shimmer.dart';
import 'package:frontend/features/dashboard/providers/job_provider.dart';
import 'package:frontend/features/dashboard/screens/home/widgets/job_place_widget.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:provider/provider.dart';

class HomeJobPlacesList extends StatelessWidget {
  const HomeJobPlacesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final jobProvider = Provider.of<JobProvider>(context);

    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: KSizes.md),
          child: Text(
            "${l10n.where_do_you_want_to_work}",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 15,
                ),
          ),
        ),
        SizedBox(height: KSizes.md),
        jobProvider.isLoading
            ? CategoriesVerticalShimmer()
            : Container(
                height: 110.h,
                child: ListView.builder(
                    padding: const EdgeInsets.only(left: KSizes.md),
                    scrollDirection: Axis.horizontal,
                    itemCount: jobProvider.jobPlaces?.length ?? 0,
                    itemBuilder: (context, index) {
                      final jobPlace = jobProvider.jobPlaces![index];
                      return JobPlaceWidget(jobPlace: jobPlace);
                    }),
              ),
      ],
    );
  }
}
