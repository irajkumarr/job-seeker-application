import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/data/models/job_model.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../../../../core/utils/constants/image_strings.dart';

class JobCard extends StatelessWidget {
  const JobCard({
    super.key,
    required this.job,
  });

  final JobModel job;

  @override
  Widget build(BuildContext context) {
    DateTime parsedDate = DateTime.parse(job.expiryDate.toString()).toLocal();

    String expiryFullDate = DateFormat('MMMM d yyyy').format(parsedDate);

    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: EdgeInsets.only(bottom: KSizes.md),
      child: InkWell(
        onTap: () {
          context.pushNamed(RoutesConstant.jobDetails, extra: job.id);
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
                        imageUrl: job.company.logo.url,
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
                          job.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Company Name
                        Text(
                          job.company.name,
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
                              job.company.location.fullAddress,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        // Available Jobs
                        Row(
                          children: [
                            Icon(
                              Iconsax.user,
                              size: 16,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${job.basicInformation.noOfVacancy} ${l10n.job} ${l10n.available}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Expiry Date
                        Text(
                          '${l10n.expiry_date}: $expiryFullDate',
                          style: TextStyle(
                            fontSize: 12,
                            color: KColors.primary,
                          ),
                        ),
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
