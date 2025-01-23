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
import 'package:frontend/features/dashboard/screens/home/widgets/home_category_list.dart';
import 'package:frontend/features/dashboard/screens/home/widgets/home_header.dart';
import 'package:frontend/features/dashboard/screens/home/widgets/home_job_places_list.dart';
import 'package:frontend/features/dashboard/screens/home/widgets/home_quick_links_section.dart';
import 'package:frontend/features/dashboard/screens/home/widgets/home_search_bar.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

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
            SizedBox(height: KSizes.defaultSpace),
          ],
        ),
      ),
    );
  }
}
