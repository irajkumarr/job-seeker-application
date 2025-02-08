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
        Padding(
          padding: EdgeInsets.only(top: KSizes.sm, bottom: KSizes.md),
          child: SizedBox(
              // height: MediaQuery.of(context).size.height * 0.83,
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: searchProvider.searchResults!.length,
                
                  itemBuilder: (context, index) {
                    JobModel job = searchProvider.searchResults![index];
                    return JobCard(job: job);
                  })),
        ),
      ],
    );
  }
}
