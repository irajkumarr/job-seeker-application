import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/common/widgets/appbar/appbar.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:frontend/core/utils/shimmers/filter_shimmer.dart';
import 'package:frontend/data/models/job_model.dart';
import 'package:frontend/features/dashboard/providers/filter_provider.dart';
import 'package:frontend/features/dashboard/providers/search_provider.dart';
import 'package:frontend/features/dashboard/screens/home/widgets/job_card.dart';
import 'package:frontend/features/dashboard/screens/search/search_result.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key, required this.isSearch});
  final bool isSearch;
  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<FilterProvider>(context);
    final searchProvider = Provider.of<SearchProvider>(context);
    int _calculateTotalVacancies(List<JobModel>? jobs) {
      if (jobs == null || jobs.isEmpty) return 0;
      return jobs.fold<int>(
          0, (sum, job) => sum + (job.basicInformation.noOfVacancy ?? 0));
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(KDeviceUtils.getAppBarHeight()),
        child: Appbar(isActionRequired: false),
      ),
      body: (isSearch && searchProvider.isLoading) || filterProvider.isLoading
          ? const FilterShimmer()
          : (isSearch &&
                      (searchProvider.searchResults == null ||
                          searchProvider.searchResults!.isEmpty)) ||
                  (!isSearch && (filterProvider.filterJobs.isEmpty))
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
                          'No results found',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: KSizes.sm),
                        Text("Your search returned no results"),
                        Text("Try removing filters or rephrasing your search"),
                        SizedBox(height: KSizes.md),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: KColors.primary),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(KSizes.defaultSpace)),
                          ),
                          onPressed: () {},
                          child: Text(
                            "Edit Search",
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
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: KSizes.md),
                        child: Text(
                          isSearch
                              ? "${searchProvider.searchText}"
                              : "Filtered Jobs",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                fontSize: 22.sp,
                              ),
                        ),
                      ),
                      SizedBox(height: KSizes.defaultSpace),
                      SizedBox(
                        height: 40.h,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(horizontal: KSizes.md),
                          children: [
                            DropDownWidget(
                              title: "All Filters",
                              icon: Icons.add,
                            ),
                            DropDownWidget(
                              title: "Category",
                              icon: Icons.keyboard_arrow_down_outlined,
                            ),
                            DropDownWidget(
                              title: "Location",
                              icon: Icons.keyboard_arrow_down_outlined,
                            ),
                            DropDownWidget(
                              title: "Experience",
                              icon: Icons.keyboard_arrow_down_outlined,
                            ),
                            DropDownWidget(
                              title: "Salary",
                              icon: Icons.keyboard_arrow_down_outlined,
                            ),
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
                              "We found ${isSearch ? searchProvider.searchResults?.length ?? 0 : filterProvider.filterJobs.length} jobs with ${isSearch ? _calculateTotalVacancies(searchProvider.searchResults) : _calculateTotalVacancies(filterProvider.filterJobs)} vacancies",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            SizedBox(height: KSizes.md),
                            isSearch
                                ? SearchResults()
                                : ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: filterProvider.filterJobs.length,
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
    );
  }
}

class DropDownWidget extends StatelessWidget {
  const DropDownWidget({
    super.key,
    required this.icon,
    required this.title,
  });
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: KSizes.sm),
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: KSizes.md, vertical: KSizes.sm),
        decoration: BoxDecoration(
          color: KColors.secondaryBackground,
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
    );
  }
}


  // DropdownButton<String>(
  //             value: filterProvider.selectedLocation,
  //             hint: Text("Select Location"),
  //             isExpanded: true,
  //             items: locations.map((String location) {
  //               return DropdownMenuItem(value: location, child: Text(location));
  //             }).toList(),
  //             onChanged: (value) => filterProvider.setLocation(value),
  //           ),
  //           DropdownButton<String>(
  //             value: filterProvider.selectedCategory,
  //             hint: Text("Select Category"),
  //             isExpanded: true,
  //             items: categories.map((String category) {
  //               return DropdownMenuItem(value: category, child: Text(category));
  //             }).toList(),
  //             onChanged: (value) => filterProvider.setCategory(value),
  //           ),
  //           DropdownButton<String>(
  //             value: filterProvider.selectedEducation,
  //             hint: Text("Select Education"),
  //             isExpanded: true,
  //             items: educations.map((String education) {
  //               return DropdownMenuItem(value: education, child: Text(education));
  //             }).toList(),
  //             onChanged: (value) => filterProvider.setEducation(value),
  //           ),
  //           DropdownButton<String>(
  //             value: filterProvider.selectedExperience,
  //             hint: Text("Select Experience"),
  //             isExpanded: true,
  //             items: experiences.map((String exp) {
  //               return DropdownMenuItem(value: exp, child: Text(exp));
  //             }).toList(),
  //             onChanged: (value) => filterProvider.setExperience(value),
  //           ),
  //           DropdownButton<String>(
  //             value: filterProvider.selectedIndustryTitle,
  //             hint: Text("Select Industry"),
  //             isExpanded: true,
  //             items: industries.map((String industry) {
  //               return DropdownMenuItem(value: industry, child: Text(industry));
  //             }).toList(),
  //             onChanged: (value) => filterProvider.setIndustryTitle(value),
  //           ),