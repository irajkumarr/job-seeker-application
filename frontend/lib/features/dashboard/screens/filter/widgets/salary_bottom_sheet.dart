import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/features/dashboard/providers/filter_provider.dart';
import 'package:frontend/features/dashboard/providers/job_provider.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void showSalaryBottomSheet(
  BuildContext context,
  VoidCallback onPressed,
) {
  final l10n = AppLocalizations.of(context)!;
  final jobProvider = Provider.of<JobProvider>(context, listen: false);
  final filterProvider = Provider.of<FilterProvider>(context, listen: false);

  final salaryRanges = [
    {'label': 'Rs. 15000 or less', 'value': '0-15000'},
    {'label': 'Rs. 15001 - Rs. 25000', 'value': '15001-25000'},
    {'label': 'Rs. 25001 - Rs. 35000', 'value': '25001-35000'},
    {'label': 'Rs. 35001 - Rs. 50000', 'value': '35001-50000'},
    {'label': 'Rs. 50001 - Rs. 75000', 'value': '50001-75000'},
    {'label': 'Rs. 75001 - Rs. 100000', 'value': '75001-100000'},
    {'label': 'Rs. 100001 and above', 'value': '100001'}
  ];

  showModalBottomSheet(
    context: context,
    sheetAnimationStyle: AnimationStyle(
      duration: Duration(milliseconds: 600),
      reverseDuration: Duration(milliseconds: 300),
    ),
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(KSizes.md),
      ),
    ),
    builder: (context) => Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: KSizes.md),
            child: Column(
              children: [
                Text(
                  '${l10n.select_your_expected_salary}',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontSize: 20.sp,
                      ),
                ),
                SizedBox(height: KSizes.xs),
                Text(
                  '${l10n.select_your_expected_salary_for_job}',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: KColors.black,
                      ),
                ),
              ],
            ),
          ),
          SizedBox(height: KSizes.defaultSpace),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: salaryRanges.length,
                      itemBuilder: (context, index) {
                        final salary = salaryRanges[index];
                        return Column(
                          children: [
                            ListTile(
                              onTap: () {
                                context.pop();
                                filterProvider
                                    .setSalary(salary['label'].toString());
                                filterProvider.getFilteredJobs(
                                    salary: salary['value'].toString());
                                // filterProvider.getFilteredJobs(
                                //     salary: salary['value'].toString());
                              },
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: KSizes.md),
                              title: Text(
                                salary['label'].toString(),
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: KSizes.md),
                              child: Divider(
                                height: 1,
                                color: KColors.grey,
                              ),
                            ),
                          ],
                        );
                      })
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
