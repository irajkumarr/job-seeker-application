import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/common/widgets/appbar/appbar.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:frontend/core/utils/shimmers/filter_shimmer.dart';
import 'package:frontend/data/models/job_model.dart';
import 'package:frontend/features/dashboard/providers/filter_provider.dart';
import 'package:frontend/features/dashboard/providers/search_provider.dart';
import 'package:frontend/features/dashboard/screens/filter/widgets/all_filters_bottom_sheet.dart';
import 'package:frontend/features/dashboard/screens/filter/widgets/category_bottom_sheet.dart';
import 'package:frontend/features/dashboard/screens/filter/widgets/education_bottom_sheet.dart';
import 'package:frontend/features/dashboard/screens/filter/widgets/experience_bottom_sheet.dart';
import 'package:frontend/features/dashboard/screens/filter/widgets/location_bottom_sheet.dart';
import 'package:frontend/features/dashboard/screens/filter/widgets/salary_bottom_sheet.dart';
import 'package:frontend/features/dashboard/screens/home/widgets/job_card.dart';
import 'package:frontend/features/dashboard/screens/search/search_result.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key, required this.isSearch});
  final bool isSearch;

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final filterProvider = Provider.of<FilterProvider>(context);
    final searchProvider = Provider.of<SearchProvider>(context);
    int _calculateTotalVacancies(List<JobModel>? jobs) {
      if (jobs == null || jobs.isEmpty) return 0;
      return jobs.fold<int>(
          0, (sum, job) => sum + (job.basicInformation.noOfVacancy ?? 0));
    }

    // String _formatFilters(
    //     Map<String, String> filters, FilterProvider provider) {
    //   List<String> selectedFilters = [];

    //   // Add all selected filters from the map
    //   filters.forEach((key, value) {
    //     selectedFilters.add("$value");
    //   });

    //   // Add Employment, Urgent Jobs, and Jobs Without Experience if selected
    //   if (provider.selectedEmploymentForWomen != null) {
    //     selectedFilters.add("Employment for Women");
    //   }
    //   if (provider.selectedUrgent != null) {
    //     selectedFilters.add("Urgent Jobs");
    //   }
    //   if (provider.selectedJobsWithoutExperience != null) {
    //     selectedFilters.add("Jobs Without Experience");
    //   }

    //   return selectedFilters.isNotEmpty
    //       ? selectedFilters.join(", ")
    //       : "No filters selected";
    // }

    // String _formatFilters(Map<String, String> filters) {
    //   if (filters.isEmpty) return ""; // Show nothing if multiple or no filters

    //   return filters.values.first; // ✅ Show only the first (single) filter
    // }
    String _formatFilters(Map<String, String> filters) {
      if (filters.length != 1)
        return ""; // Show nothing if no or more than one filter is selected

      return filters.values
          .first; // Show only the first filter when exactly one filter is selected
    }

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        filterProvider.resetFilters();
        return true;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(KDeviceUtils.getAppBarHeight()),
          child: Appbar(isActionRequired: false),
        ),
        body: (widget.isSearch && searchProvider.isLoading) ||
                filterProvider.isLoading
            ? const FilterShimmer()
            : (widget.isSearch &&
                        (searchProvider.searchResults == null ||
                            searchProvider.searchResults!.isEmpty)) ||
                    (!widget.isSearch && (filterProvider.filterJobs.isEmpty))
                ? Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: KSizes.md,
                          vertical: KSizes.spaceBtwSections),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                              "assets/images/content/rojgari_logo_single.svg"),
                          SizedBox(height: KSizes.md),
                          Text(
                            '${l10n.no_results_found}',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: KSizes.sm),
                          Text("${l10n.your_search_returned_no_results}"),
                          Text("${l10n.try_remove_filter}"),
                          SizedBox(height: KSizes.md),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: KColors.primary),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      KSizes.defaultSpace)),
                            ),
                            onPressed: widget.isSearch
                                ? () {
                                    context.pushNamed(RoutesConstant.search);
                                  }
                                : () {
                                    filterProvider.resetFilters();
                                    filterProvider.getFilteredJobs();
                                  },
                            child: Text(
                              "${l10n.edit_search}",
                              style: TextStyle(color: KColors.primary),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: KSizes.md),
                        (filterProvider.filters.isEmpty ||
                                    filterProvider.filters.length != 1) &&
                                searchProvider.searchText.isEmpty
                            ? SizedBox()
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: KSizes.md),
                                child: Text(
                                  widget.isSearch
                                      ? "${searchProvider.searchText}"
                                      : _formatFilters(filterProvider.filters),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                        fontSize: 22.sp,
                                      ),
                                ),
                              ),
                        (filterProvider.filters.isEmpty ||
                                    filterProvider.filters.length != 1) &&
                                !widget.isSearch
                            ? SizedBox()
                            : SizedBox(height: KSizes.defaultSpace),
                        SizedBox(
                          height: 40.h,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            padding:
                                EdgeInsets.symmetric(horizontal: KSizes.md),
                            children: [
                              DropDownWidget(
                                title: "${l10n.all_filters}",
                                icon: Icons.add,
                                onTap: () {
                                  showAllFiltersBottomSheet(
                                    context,
                                    () {},
                                  );
                                },
                              ),
                              DropDownWidget(
                                title: filterProvider.selectedCategory ??
                                    "${l10n.job_category}",
                                icon: Icons.keyboard_arrow_down_outlined,
                                color: filterProvider.selectedCategory == null
                                    ? KColors.secondaryBackground
                                    : KColors.accent,
                                onTap: () {
                                  showCategoryBottomSheet(
                                    context,
                                    () {},
                                  );
                                },
                              ),
                              DropDownWidget(
                                title: filterProvider.selectedLocation ??
                                    "${l10n.job_location}",
                                icon: Icons.keyboard_arrow_down_outlined,
                                color: filterProvider.selectedLocation == null
                                    ? KColors.secondaryBackground
                                    : KColors.accent,
                                onTap: () {
                                  showLocationBottomSheet(
                                    context,
                                    () {},
                                  );
                                },
                              ),
                              DropDownWidget(
                                icon: Icons.keyboard_arrow_down_outlined,
                                title: filterProvider.selectedExperience ??
                                    "${l10n.experience}",
                                color: filterProvider.selectedExperience == null
                                    ? KColors.secondaryBackground
                                    : KColors.accent,
                                onTap: () {
                                  showExperienceBottomSheet(
                                    context,
                                    () {},
                                  );
                                },
                              ),
                              DropDownWidget(
                                title: filterProvider.selectedSalary ??
                                    "${l10n.salary}",
                                icon: Icons.keyboard_arrow_down_outlined,
                                color: filterProvider.selectedSalary == null
                                    ? KColors.secondaryBackground
                                    : KColors.accent,
                                onTap: () {
                                  // context.pop();
                                  showSalaryBottomSheet(
                                    context,
                                    () {},
                                  );
                                },
                              ),
                              DropDownWidget(
                                title: filterProvider.selectedEducation ??
                                    "${l10n.education}",
                                icon: Icons.keyboard_arrow_down_outlined,
                                color: filterProvider.selectedEducation == null
                                    ? KColors.secondaryBackground
                                    : KColors.accent,
                                onTap: () {
                                  // context.pop();
                                  showEducationBottomSheet(
                                    context,
                                    () {},
                                  );
                                },
                              ),
                              Center(
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(
                                      KSizes.defaultSpace),
                                  onTap: () {
                                    filterProvider.resetFilters();
                                    filterProvider.getFilteredJobs();
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: KSizes.md,
                                        vertical: KSizes.sm),
                                    child: Text(
                                      "${l10n.clear_filters}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            color: KColors.primary,
                                          ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: KSizes.md),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: KSizes.md,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "We found ${widget.isSearch ? searchProvider.searchResults?.length ?? 0 : filterProvider.filterJobs.length} jobs with ${widget.isSearch ? _calculateTotalVacancies(searchProvider.searchResults) : _calculateTotalVacancies(filterProvider.filterJobs)} vacancies",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              SizedBox(height: KSizes.md),
                              widget.isSearch
                                  ? SearchResults()
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount:
                                          filterProvider.filterJobs.length,
                                      itemBuilder: (context, index) {
                                        final JobModel job =
                                            filterProvider.filterJobs[index];
                                        return JobCard(job: job);
                                      })
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}

class DropDownWidget extends StatelessWidget {
  const DropDownWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.color = KColors.secondaryBackground,
  });
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: KSizes.sm),
      child: InkWell(
        borderRadius: BorderRadius.circular(KSizes.defaultSpace),
        onTap: onTap,
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: KSizes.md, vertical: KSizes.sm),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(KSizes.defaultSpace),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: KSizes.sm,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    // fontSize: 22.sp,
                    ),
              ),
              Icon(icon),
            ],
          ),
        ),
      ),
    );
  }
}
