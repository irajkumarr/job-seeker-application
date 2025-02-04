import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/loaders/full_screen_overlay.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/image_strings.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:frontend/core/utils/shimmers/job_detail_shimmer.dart';
import 'package:frontend/features/dashboard/providers/job_application_provider.dart';
import 'package:frontend/features/dashboard/providers/job_application_status_provider.dart';
import 'package:frontend/features/dashboard/providers/job_provider.dart';
import 'package:frontend/features/dashboard/screens/job_details/widgets/basic_information_section.dart';
import 'package:frontend/features/dashboard/screens/job_details/widgets/info_item.dart';
import 'package:frontend/features/dashboard/screens/job_details/widgets/job_description_section.dart';
import 'package:frontend/features/dashboard/providers/saved_jobs_provider.dart';
import 'package:frontend/features/personalization/screens/profile/widgets/custom_alert.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class JobDetailsScreen extends StatefulWidget {
  const JobDetailsScreen({Key? key, required this.jobId}) : super(key: key);
  final String jobId;

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  bool showBasicInfo = true;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _basicInfoKey = GlobalKey();
  final GlobalKey _jobDescriptionKey = GlobalKey();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final jobProvider = Provider.of<JobProvider>(context, listen: false);
      Provider.of<JobApplicationStatusProvider>(context, listen: false)
          .checkJobApplicationStatus(context: context, jobId: widget.jobId);
      jobProvider.fetchJobById(widget.jobId);
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final jobProvider = Provider.of<JobProvider>(context);
    final jobApplicationProvider = Provider.of<JobApplicationProvider>(context);
    final l10n = AppLocalizations.of(context)!;

    // Loading and error handling
    if (jobProvider.isLoading) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(KDeviceUtils.getAppBarHeight()),
          child: Material(
            elevation: 0.2,
            child: AppBar(
              title: Text(
                '${l10n.job_details}',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontSize: 22,
                    ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(child: JobDetailShimmer()),
      );
    }

    if (jobProvider.error != null) {
      return Scaffold(
        body: Center(
          child: Text(
            jobProvider.error!.message,
            style: const TextStyle(color: Colors.red, fontSize: 18),
          ),
        ),
      );
    }

    final job = jobProvider.job;

    // No job data
    if (job == null) {
      return const Scaffold(
        body: Center(
          child: Text(
            "No job data found.",
            style: TextStyle(fontSize: 18, color: Colors.black54),
          ),
        ),
      );
    }
    DateTime parsedDate =
        DateTime.parse(jobProvider.job!.expiryDate.toString()).toLocal();

    String expiryFullDate = DateFormat('MMMM d yyyy').format(parsedDate);
    // Main UI
    return FullScreenOverlay(
      isLoading: jobApplicationProvider.isLoading,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(KDeviceUtils.getAppBarHeight()),
          child: Material(
            elevation: 0.2,
            child: AppBar(
              title: Text(
                '${l10n.job_details}',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontSize: 22,
                    ),
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          // color: Colors.grey[200],
                          border: Border.all(
                            color: KColors.grey,
                          ),
                          borderRadius: BorderRadius.circular(KSizes.md),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(KSizes.md),
                          child: CachedNetworkImage(
                            imageUrl: job.company.logo.url,
                            placeholder: (context, url) => SizedBox(
                                child: Image.asset(KImages.defaultBuilding)),
                            errorWidget: (context, url, error) =>
                                Image.asset(KImages.defaultBuilding),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            jobProvider.job!.title,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          SizedBox(height: KSizes.xs),
                          Text(
                            job.company.name,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: KSizes.md),

                  // Expiry Date
                  Text(
                    '${l10n.expiry_date}: $expiryFullDate',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: KColors.primary,
                          fontSize: 13,
                        ),
                  ),
                  const SizedBox(height: KSizes.defaultSpace),

                  // Info Items
                  InfoItem(
                    icon: Iconsax.location,
                    text: job.company.location.fullAddress,
                  ),
                  const SizedBox(height: KSizes.md),
                  InfoItem(
                    icon: Icons.work_outline_rounded,
                    text: job.type,
                  ),
                  const SizedBox(height: KSizes.md),
                  InfoItem(
                    icon: Icons.money,
                    text:
                        "NRs. ${job.salary.toStringAsFixed(0)} ${l10n.monthly}",
                  ),
                  SizedBox(height: KSizes.sm),

                  // Tabs
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() => showBasicInfo = true);
                          _scrollTo(_basicInfoKey);
                        },
                        child: Text(
                          '${l10n.basic_information}',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: showBasicInfo
                                        ? KColors.primary
                                        : KColors.black,
                                  ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() => showBasicInfo = false);
                          _scrollTo(_jobDescriptionKey);
                        },
                        child: Text(
                          '${l10n.job_description}',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: !showBasicInfo
                                        ? KColors.primary
                                        : KColors.black,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: KSizes.sm),

                  // Basic Information Section
                  BasicInformationSection(
                    key: _basicInfoKey,
                    job: job,
                  ),

                  SizedBox(height: KSizes.defaultSpace),
                  // Job Description Section
                  JobDescriptionSection(
                    key: _jobDescriptionKey,
                    job: job,
                  ),

                  SizedBox(height: 80.h), // Space for bottom bar
                ],
              ),
            ),

            // Bottom Action Bar
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(KSizes.md),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: KColors.grey,
                      blurRadius: 1,
                      offset: Offset(0, -1),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Consumer<SavedJobsProvider>(
                        builder: (context, provider, child) {
                      bool isJobSaved = provider.savedJobIds.contains(job.id);
                      return Container(
                        decoration: BoxDecoration(
                          color: KColors.secondaryBackground,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: IconButton(
                          icon: Icon(isJobSaved
                              ? Icons.favorite
                              : Icons.favorite_border_outlined),
                          color: isJobSaved ? KColors.error : KColors.darkGrey,
                          onPressed: () {
                            provider.handleSavedJob(context, job.id);
                          },
                        ),
                      );
                    }),
                    const SizedBox(width: KSizes.md),
                    Consumer<JobApplicationStatusProvider>(
                      builder: (context, provider, child) {
                        if (provider.isLoading) {
                          return CircularProgressIndicator();
                        }

                        return Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            height: 50.h,
                            child: ElevatedButton(
                              onPressed: provider.hasApplied
                                  ? null
                                  : () async {
                                      await alertApplyJob(context, () async {
                                        context.pop();
                                        await jobApplicationProvider.applyJob(
                                            context: context,
                                            jobId: job.id,
                                            onSuccess: () async {
                                              await showCongratulationsDialog(
                                                  context, () {
                                                context.pop();
                                              });
                                              provider
                                                  .checkJobApplicationStatus(
                                                      context: context,
                                                      jobId: widget.jobId);
                                            });
                                      });
                                    },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: KColors.primary,
                                  splashFactory: NoSplash.splashFactory,
                                  disabledBackgroundColor: Color(0xffB0B1B5),
                                  disabledForegroundColor: KColors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  )),
                              child:
                                  //  jobApplicationProvider.isLoading
                                  //     ? CustomLoading(
                                  //         isLoadingTextShowed: false,
                                  //         size: KSizes.md,
                                  //         padding: EdgeInsets.only(top: KSizes.xs - 2),
                                  //       ):
                                  provider.hasApplied
                                      ? Text(
                                          "Applied",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                color: KColors.white,
                                              ),
                                        )
                                      : Text(
                                          "${l10n.apply_now}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                // fontWeight: FontWeight.w700,
                                                color: KColors.white,
                                              ),
                                        ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
