import 'package:flutter/material.dart';
import 'package:frontend/data/models/job_model.dart';
import 'package:frontend/features/dashboard/providers/search_provider.dart';
import 'package:frontend/features/dashboard/screens/home/widgets/job_card.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/constants/sizes.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({super.key});

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);
    return ListView(
      // crossAxisAlignment: CrossAxisAlignment.start,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        // Row(
        //   children: [
        //     Text(
        //       "${searchProvider.searchResults!.length}",
        //       style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        //           fontWeight: FontWeight.w600, color: KColors.primary),
        //     ),
        //     const Text(" results found"),
        //     Text(
        //       ' "${searchProvider.searchText}"',
        //       style: Theme.of(context)
        //           .textTheme
        //           .bodyLarge!
        //           .copyWith(fontWeight: FontWeight.w700, color: KColors.black),
        //     ),
        //   ],
        // ),
        Padding(
          padding: EdgeInsets.only(top: KSizes.sm, bottom: KSizes.md),
          child: SizedBox(
              // height: MediaQuery.of(context).size.height * 0.83,
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: searchProvider.searchResults!.length,
                  // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //   crossAxisCount: 2,
                  //   mainAxisExtent: 290.h,
                  //   mainAxisSpacing: 8,
                  //   crossAxisSpacing: 8,
                  // ),
                  itemBuilder: (context, index) {
                    JobModel job = searchProvider.searchResults![index];
                    return JobCard(job: job);
                  })),
        ),
      ],
    );
  }
}
