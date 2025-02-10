import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/circular_progress_indicator/custom_loading.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:frontend/core/utils/shimmers/job_shimmer.dart';
import 'package:frontend/features/dashboard/providers/matched_jobs_provider.dart';
import 'package:frontend/features/dashboard/screens/home/widgets/job_card.dart';
import 'package:frontend/features/dashboard/screens/jobs/widgets/saved_jobs_card.dart';
import 'package:frontend/features/dashboard/widgets/login_redirect.dart';
import 'package:frontend/features/dashboard/widgets/no_data_widget.dart';
import 'package:frontend/features/dashboard/widgets/status_and_saved_jobs_appbar.dart';
import 'package:frontend/features/dashboard/providers/saved_jobs_provider.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:frontend/navigation_menu.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class SavedJobsScreen extends StatefulWidget {
  @override
  State<SavedJobsScreen> createState() => _SavedJobsScreenState();
}

class _SavedJobsScreenState extends State<SavedJobsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final matchedJobProvider =
          Provider.of<MatchedJobsProvider>(context, listen: false);
      matchedJobProvider.getUserMatchedJobs();
      final savedJobProvider =
          Provider.of<SavedJobsProvider>(context, listen: false);
      savedJobProvider.getUserSavedJobs();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final box = GetStorage();
    final String? token = box.read("token");
    final savedJobsProvider = Provider.of<SavedJobsProvider>(context);
    final matchedJobsProvider = Provider.of<MatchedJobsProvider>(context);
    if (token == null) {
      return LoginRedirect(
        isMatchedJobs: true,
      );
    }
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(KDeviceUtils.getAppBarHeight()),
          child: StatusAndSavedJobsAppbar(
            appbarText: l10n.matched_jobs,
          ),
        ),
        body: Column(
          children: [
            Container(
              color: KColors.white,
              padding: EdgeInsets.only(top: KSizes.md),
              child: TabBar(
                indicatorColor: KColors.primary,
                labelColor: KColors.black,
                unselectedLabelColor: KColors.darkerGrey,
                dividerColor: Colors.transparent,
                dividerHeight: 1,
                indicatorSize: TabBarIndicatorSize.tab,
                labelPadding: EdgeInsets.zero,
                tabs: [
                  Tab(
                    height: 50.h,
                    child: Column(
                      children: [
                        Text(
                          "${l10n.matched_jobs}",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        SizedBox(height: KSizes.xs),
                        matchedJobsProvider.isLoading
                            ? CustomLoading(
                                isLoadingTextShowed: false,
                                size: KSizes.md,
                                padding: EdgeInsets.only(top: KSizes.xs - 2),
                              )
                            : Text(
                                "${matchedJobsProvider.matchedJobs.length}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: KColors.primary,
                                    ),
                              ),
                      ],
                    ),
                  ),
                  Tab(
                    height: 50.h,
                    child: Column(
                      children: [
                        Text(
                          "${l10n.saved_jobs}",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        SizedBox(height: KSizes.xs),
                        savedJobsProvider.isLoading
                            ? CustomLoading(
                                isLoadingTextShowed: false,
                                size: KSizes.md,
                                padding: EdgeInsets.only(top: KSizes.xs - 2),
                              )
                            : Text(
                                "${savedJobsProvider.savedJobs.length}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: KColors.primary,
                                    ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Expanded TabBarView
            Expanded(
              child: TabBarView(
                children: [
                  matchedJobsProvider.isLoading
                      ? JobShimmer()
                      : matchedJobsProvider.matchedJobs.isEmpty
                          ? NoDataWidget(
                              title: "${l10n.no_data_available}",
                              subTitle: "${l10n.there_are_no_matched_jobs}",
                              image:
                                  "assets/images/content/my_status_person.gif",
                              isButtonShowed: true,
                              buttonText: "${l10n.get_started}",
                              onPressed: () {
                                context.read<NavigationProvider>().onTap(0);
                              },
                            )
                          : RefreshIndicator(
                              onRefresh: () async {
                                return await matchedJobsProvider
                                    .getUserMatchedJobs();
                              },
                              child: ListView.builder(
                                padding: EdgeInsets.symmetric(
                                    horizontal: KSizes.md,
                                    vertical: KSizes.defaultSpace),
                                itemCount:
                                    matchedJobsProvider.matchedJobs.length,
                                itemBuilder: (context, index) {
                                  final job =
                                      matchedJobsProvider.matchedJobs[index];
                                  return JobCard(job: job);
                                },
                              ),
                            ),
                  savedJobsProvider.isLoading
                      ? JobShimmer()
                      : savedJobsProvider.savedJobs.isEmpty
                          ? NoDataWidget(
                              title: "${l10n.time_to_find_favourite_jobs}",
                              subTitle: "${l10n.clik_on_the_icon_to_bookmark}",
                              image: "assets/images/content/heart.gif",
                              isButtonShowed: true,
                              buttonText: "${l10n.start_browsing_jobs}",
                              onPressed: () {
                                context.read<NavigationProvider>().onTap(0);
                              },
                            )
                          : RefreshIndicator(
                              onRefresh: () async {
                                return await savedJobsProvider
                                    .getUserSavedJobs();
                              },
                              child: ListView.builder(
                                padding: EdgeInsets.symmetric(
                                    horizontal: KSizes.md,
                                    vertical: KSizes.defaultSpace),
                                itemCount: savedJobsProvider.savedJobs.length,
                                itemBuilder: (context, index) {
                                  final job =
                                      savedJobsProvider.savedJobs[index];
                                  return SavedJobsCard(
                                    job: job,
                                  );
                                },
                              ),
                            ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
