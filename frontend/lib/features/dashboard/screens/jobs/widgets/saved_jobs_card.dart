import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/image_strings.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/data/models/user_saved_jobs_model.dart';
import 'package:frontend/features/dashboard/providers/saved_jobs_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
class SavedJobsCard extends StatelessWidget {
  const SavedJobsCard({
    super.key,
    required this.job,
  });

  final UserSavedJobsModel job;

  @override
  Widget build(BuildContext context) {
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
                    icon: Icon(isJobSaved
                        ? Icons.favorite
                        : Icons.favorite_border_outlined),
                    color: isJobSaved ? KColors.error : KColors.darkGrey,
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
