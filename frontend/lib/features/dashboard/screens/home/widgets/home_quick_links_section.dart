import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/texts/section_row_title_text.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/features/dashboard/providers/filter_provider.dart';
import 'package:frontend/features/dashboard/screens/home/widgets/quick_links_tile.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class HomeQuickLinksSection extends StatelessWidget {
  const HomeQuickLinksSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final filterProvider = Provider.of<FilterProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionRowTitleText(
          title: l10n.quick_links,
          subTitle: l10n.click_on_the_link_below,
          isViewAll: false,
        ),
        SizedBox(height: KSizes.md),
        Container(
          height: 125.h,
          child: ListView(
            padding: const EdgeInsets.only(left: KSizes.md),
            scrollDirection: Axis.horizontal,
            children: [
              QuickLinksTile(
                icon: Iconsax.bubble,
                title: l10n.employment_for_women,
                onTap: () async {
                  context.pushNamed(RoutesConstant.filter, extra: false);

                  await filterProvider.getFilteredJobs(
                      employmentForWomen: true);
                },
              ),
              QuickLinksTile(
                icon: Iconsax.alarm,
                title: l10n.urgent_jobs,
                onTap: () async {
                  context.pushNamed(RoutesConstant.filter, extra: false);

                  await filterProvider.getFilteredJobs(urgentJobs: true);
                },
              ),
              QuickLinksTile(
                icon: Iconsax.bag,
                title: l10n.jobs_without_experience,
                onTap: () async {
                  context.pushNamed(RoutesConstant.filter, extra: false);

                  await filterProvider.getFilteredJobs(
                      jobsWithoutExperience: true);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
