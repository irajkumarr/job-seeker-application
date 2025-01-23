import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:frontend/common/widgets/appbar/appbar.dart';
import 'package:frontend/core/utils/circular_progress_indicator/circlular_indicator.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/image_strings.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:frontend/features/dashboard/providers/category_provider.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final categoryProvider = Provider.of<CategoryProvider>(context);
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
            //home text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: KSizes.md)
                  .copyWith(top: KSizes.defaultSpace),
              child: Column(
                spacing: KSizes.xs,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${l10n.discover_and_apply_to_jobs}",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    "${l10n.free}.",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: KColors.primary,
                        ),
                  ),
                  Text(
                    "${l10n.more_than_people_found_jobs}",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: KColors.black,
                        ),
                  ),
                ],
              ),
            ),
            //home search bar

            SizedBox(height: KSizes.md),
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: KSizes.sm + 2),
                child: Container(
                  height: KDeviceUtils.getAppBarHeight(),
                  width: double.infinity,
                  padding: EdgeInsets.only(right: KSizes.sm, left: KSizes.md),
                  decoration: BoxDecoration(
                      color: KColors.white,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: KColors.primaryContainer,
                        width: 1.4,
                      )),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${l10n.search_jobs}',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: KColors.darkGrey,
                                  ),
                        ),
                      ),
                      Container(
                        width: 40.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: KColors.primary,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Icon(
                          AntDesign.search1,
                          color: KColors.white,
                          // size: 28,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //category
            SizedBox(height: KSizes.defaultSpace),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: KSizes.md),
                  child: Text(
                    "What kind of job do you want?",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 15,
                        ),
                  ),
                ),
                SizedBox(height: KSizes.md),
                Container(
                  height: 225.h,
                  child: ListView.builder(
                      padding: const EdgeInsets.only(left: KSizes.md),
                      scrollDirection: Axis.horizontal,
                      itemCount: categoryProvider.categories?.length ?? 0,
                      itemBuilder: (context, index) {
                        final category = categoryProvider.categories![index];
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 170.w,
                            margin: EdgeInsets.only(right: KSizes.md - 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: NetworkImage(category.image),

                                // image: NetworkImage(
                                //     "https://api.rojgari.com/media/uploads/job_category/Gent_staff_1.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.7),
                                  ],
                                ),
                              ),
                              padding: EdgeInsets.all(KSizes.md),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    category.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: KColors.white,
                                        ),
                                  ),
                                  Text(
                                    '${category.metadata.jobCount} Jobs',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: KColors.white,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
