import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/circular_progress_indicator/custom_loading.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/image_strings.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:frontend/core/utils/shimmers/full_shimmer.dart';
import 'package:frontend/core/utils/shimmers/job_shimmer.dart';
import 'package:frontend/data/models/user_saved_jobs_model.dart';
import 'package:frontend/features/dashboard/widgets/login_redirect.dart';
import 'package:frontend/features/dashboard/widgets/no_data_widget.dart';
import 'package:frontend/features/dashboard/widgets/status_and_saved_jobs_appbar.dart';
import 'package:frontend/features/personalization/providers/saved_jobs_provider.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:frontend/navigation_menu.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SavedJobsScreen extends StatefulWidget {
  @override
  State<SavedJobsScreen> createState() => _SavedJobsScreenState();
}

class _SavedJobsScreenState extends State<SavedJobsScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final box = GetStorage();
    final String? token = box.read("token");
    final savedJobsProvider = Provider.of<SavedJobsProvider>(context);
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
              padding: EdgeInsets.symmetric(vertical: KSizes.md),
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
                          "Matched Jobs",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        SizedBox(height: KSizes.xs),
                        Text(
                          "0",
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
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
                          "Saved Jobs",
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
                  NoDataWidget(
                    title: "No data available",
                    subTitle:
                        "There are no matched jobs available for you at the moment.",
                    image: "assets/images/content/my_status_person.gif",
                    isButtonShowed: true,
                    buttonText: "Get Started",
                    onPressed: () {
                      context.read<NavigationProvider>().onTap(0);
                    },
                  ),
                  savedJobsProvider.isLoading
                      ? JobShimmer()
                      : savedJobsProvider.savedJobs.isEmpty
                          ? NoDataWidget(
                              title: "It's time to find your favourite jobs!",
                              subTitle:
                                  "Click on the icon ❤ to boomark or shortlist any jobs.",
                              image: "assets/images/content/heart.gif",
                              isButtonShowed: true,
                              buttonText: "Start Browsing Jobs",
                              onPressed: () {
                                context.read<NavigationProvider>().onTap(0);
                              },
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: KSizes.md, vertical: KSizes.sm),
                              child: ListView.builder(
                                itemCount: savedJobsProvider.savedJobs.length,
                                itemBuilder: (context, index) {
                                  final job =
                                      savedJobsProvider.savedJobs[index];
                                  return SavedJobsCard(
                                      job: job,
                                      onTapFavourite: () {
                                        savedJobsProvider.handleSavedJob(
                                            context, job.id!);
                                      });
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

class SavedJobsCard extends StatelessWidget {
  const SavedJobsCard({
    super.key,
    required this.job,
    required this.onTapFavourite,
  });

  final UserSavedJobsModel job;
  final VoidCallback onTapFavourite;

  @override
  Widget build(BuildContext context) {
    final savedJobsProvider = Provider.of<SavedJobsProvider>(context);
    bool isSaved = savedJobsProvider.savedJobIds.contains(job.id);
    return Padding(
      padding: EdgeInsets.only(bottom: KSizes.md),
      child: InkWell(
        onTap: () {
          context.pushNamed(RoutesConstant.jobDetails, extra: job.id);
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: KSizes.sm),
          decoration: BoxDecoration(
            border: Border.all(color: KColors.lightBackground),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Building Icon
                Center(
                  child: Container(
                    width: 100.w,
                    height: 100.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(KSizes.sm),
                      child: CachedNetworkImage(
                        imageUrl: job.company?.logo?.url ?? "",
                        placeholder: (context, url) => SizedBox(
                            child: Image.asset(KImages.defaultBuilding)),
                        errorWidget: (context, url, error) =>
                            Image.asset(KImages.defaultBuilding),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                // Vertical Line
                Container(
                  width: 1,
                  color: Colors.grey[200],
                  margin: EdgeInsets.symmetric(horizontal: KSizes.sm),
                ),
                // Content
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: KSizes.md, horizontal: KSizes.sm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Job Title
                        Text(
                          job.title ?? "",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Company Name
                        Text(
                          job.company?.name ?? "",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Location
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 16,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              job.location?.fullAddress ?? "",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                      ],
                    ),
                  ),
                ),

                Consumer<SavedJobsProvider>(
                    builder: (context, provider, child) {
                  bool isJobSaved = provider.savedJobIds.contains(job.id!);
                  return IconButton(
                    icon: Icon(
                        isJobSaved ? Icons.favorite : Icons.favorite_border_outlined),
                        color: isJobSaved?KColors.error:KColors.darkGrey,
                    onPressed: () {
                      provider.handleSavedJob(context, job.id!);
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
