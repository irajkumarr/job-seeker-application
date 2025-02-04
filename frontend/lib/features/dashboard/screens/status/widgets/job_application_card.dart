import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/data/models/job_application_model.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../../../../core/utils/constants/image_strings.dart';

class JobApplicationCard extends StatelessWidget {
  const JobApplicationCard({
    super.key,
    required this.jobApplication,
  });

  final JobApplicationModel jobApplication;

  @override
  Widget build(BuildContext context) {
    DateTime parsedDate =
        DateTime.parse(jobApplication.appliedAt.toString()).toLocal();

    String applyFullDate = DateFormat('MMMM dd, yyyy').format(parsedDate);

    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: EdgeInsets.only(bottom: KSizes.md),
      child: InkWell(
        onTap: () {
          context.pushNamed(RoutesConstant.jobDetails,
              extra: jobApplication.job!.id);
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          // padding: const EdgeInsets.all(KSizes.md),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[200]!),
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
                        imageUrl: jobApplication.job?.company.logo.url ?? "",
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
                        // jobApplication Title
                        Text(
                          jobApplication.job?.title ?? "",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Company Name
                        Text(
                          jobApplication.job?.company.name ?? "",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Location
                        Row(
                          children: [
                            Text(
                              'Applied Date:',
                              style: TextStyle(
                                fontSize: 12,
                                color: KColors.primary,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "$applyFullDate",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        // Available jobApplications
                        Container(
                          padding: EdgeInsetsDirectional.symmetric(
                              horizontal: KSizes.sm, vertical: 2),
                          decoration: BoxDecoration(
                              color: Color(0xffB0B1B5),
                              borderRadius: BorderRadius.circular(KSizes.xs)),
                          child: Text(
                            "Applied",
                            style: TextStyle(color: KColors.white),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Expiry Date
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
