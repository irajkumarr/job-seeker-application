import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/alert_box/snackbar.dart';
import 'package:frontend/common/widgets/appbar/appbar.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:frontend/features/dashboard/providers/blog_provider.dart';
import 'package:frontend/features/dashboard/providers/category_provider.dart';
import 'package:frontend/features/dashboard/providers/job_provider.dart';
import 'package:frontend/features/dashboard/screens/home/widgets/home_all_jobs_section.dart';
import 'package:frontend/features/dashboard/screens/home/widgets/home_blogs_section.dart';
import 'package:frontend/features/dashboard/screens/home/widgets/home_category_list.dart';
import 'package:frontend/features/dashboard/screens/home/widgets/home_header.dart';
import 'package:frontend/features/dashboard/screens/home/widgets/home_job_places_list.dart';
import 'package:frontend/features/dashboard/screens/home/widgets/home_quick_links_section.dart';
import 'package:frontend/features/dashboard/screens/home/widgets/home_search_bar.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    Future<void> retryFetchData() async {
      await Future.delayed(Duration(seconds: 2));
      try {
        await Future.wait([
          Provider.of<JobProvider>(context, listen: false).fetchJobPlaces(),
          Provider.of<JobProvider>(context, listen: false).fetchJobs(),
          Provider.of<BlogProvider>(context, listen: false).fetchBlogs(),
          Provider.of<CategoryProvider>(context, listen: false)
              .fetchCategories(),
        ]);
      } catch (e) {
        KSnackbar.Snackbar(context, "${l10n.connection_to_api_server_failed}",
            false, KColors.darkerGrey);
        rethrow; // Rethrow to maintain error state
      }
    }

    bool _hasError(BuildContext context) {
      return [
        context.read<CategoryProvider>().error,
        context.read<JobProvider>().error,
      ].any((error) => error != null);
    }

    // if (_hasError(context)) {
    //   return _buildErrorWidget(context);
    // }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(KDeviceUtils.getAppBarHeight()),
        child: Appbar(
          isActionRequired: true,
        ),
      ),
      body: RefreshIndicator(
        backgroundColor: KColors.white,
        color: KColors.primary,
        onRefresh: () async {
          await retryFetchData();
        },
        child: _hasError(context)
            ? _buildErrorWidget(retryFetchData, context)
            : SingleChildScrollView(
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
      ),
    );
  }

  Widget _buildErrorWidget(VoidCallback onRefetch, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: KSizes.spaceBtwSections),
      child: Center(
        child: InkWell(
          onTap: () {
            onRefetch();
          },
          borderRadius: BorderRadius.circular(KSizes.xs),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: KSizes.spaceBtwSections * 2,
              vertical: KSizes.sm,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: KColors.primary),
              borderRadius: BorderRadius.circular(KSizes.xs),
            ),
            child: Text(
              "Refetch",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: KColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
