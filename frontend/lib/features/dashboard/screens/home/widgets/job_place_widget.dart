import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/image_strings.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/features/dashboard/providers/filter_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class JobPlaceWidget extends StatelessWidget {
  const JobPlaceWidget({
    super.key,
    required this.jobPlace,
  });

  final String jobPlace;

  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<FilterProvider>(context);
    return Padding(
      padding: EdgeInsets.only(right: KSizes.md - 4),
      child: InkWell(
        onTap: () async {
          filterProvider.setLocation(jobPlace);
          context.pushNamed(RoutesConstant.filter, extra: false);
          await filterProvider.getFilteredJobs(location: jobPlace);
        },
        borderRadius: BorderRadius.circular(KSizes.sm),
        child: Container(
          width: 110.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(KSizes.sm),
              border: Border.all(
                color: KColors.lightContainer,
              )),
          padding: EdgeInsets.all(KSizes.sm),
          child: Column(
            children: [
              SizedBox(
                width: 50.w,
                height: 50.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child:
                      // Image.network(
                      //   "https://www.neptos.io:3000/public/uploads/watermark-thumb/thumb-nimage-1590553913042.jpg",
                      //   fit: BoxFit.cover,
                      // ),
                      CachedNetworkImage(
                    imageUrl:
                        "https://media-cdn.tripadvisor.com/media/photo-s/06/81/d8/6b/tempio-di-swayambhunath.jpg",
                    placeholder: (context, url) => SizedBox(
                        width: 50.w,
                        height: 50.h,
                        child: Image.asset(KImages.defaultBuilding)),
                    errorWidget: (context, url, error) =>
                        Image.asset(KImages.defaultBuilding),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: KSizes.sm),
              Text(
                jobPlace,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
