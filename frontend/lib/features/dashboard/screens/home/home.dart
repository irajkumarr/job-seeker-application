import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/appbar/appbar.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:frontend/features/dashboard/screens/home/widgets/home_all_jobs_section.dart';
import 'package:frontend/features/dashboard/screens/home/widgets/home_blogs_section.dart';
import 'package:frontend/features/dashboard/screens/home/widgets/home_category_list.dart';
import 'package:frontend/features/dashboard/screens/home/widgets/home_header.dart';
import 'package:frontend/features/dashboard/screens/home/widgets/home_job_places_list.dart';
import 'package:frontend/features/dashboard/screens/home/widgets/home_quick_links_section.dart';
import 'package:frontend/features/dashboard/screens/home/widgets/home_search_bar.dart';
import 'package:frontend/l10n/l10n.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(KDeviceUtils.getAppBarHeight()),
        child: Appbar(
          isActionRequired: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //home header
            HomeHeader(),
            //home search bar

            SizedBox(height: KSizes.md),
            HomeSearchBar(),
            //job category
            SizedBox(height: KSizes.defaultSpace),
            HomeCategoryList(),
            //job places
            SizedBox(height: KSizes.defaultSpace),
            HomeJobPlacesList(),
            //quick links
            SizedBox(height: KSizes.defaultSpace),
            HomeQuickLinksSection(),
            //blogs section
            SizedBox(height: KSizes.defaultSpace),
            HomeBlogsSection(),
            //all jobs section
            SizedBox(height: KSizes.defaultSpace),
            HomeAllJobsSection(),

            SizedBox(height: KSizes.defaultSpace),
          ],
        ),
      ),
    );
  }
}
