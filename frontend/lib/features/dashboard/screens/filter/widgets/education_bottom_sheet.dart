import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/features/dashboard/providers/filter_provider.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void showEducationBottomSheet(
  BuildContext context,
  VoidCallback onPressed,
) {
  final l10n = AppLocalizations.of(context)!;
  final filterProvider = Provider.of<FilterProvider>(context, listen: false);
  final List<String> education = [
    "Cannot Read and Write",
    "Can Read and Write",
    "8 Class Pass",
    "S.L.C/ S.E.E Pass",
    "+2/ Intermediate Pass",
    "Diploma",
    "Bachelor's Degree",
    "Master's Degree",
    "Ph.D. Degree",
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
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: KSizes.md),
            child: Column(
              children: [
                Text(
                  '${l10n.select_your_education}',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontSize: 20.sp,
                      ),
                ),
                SizedBox(height: KSizes.xs),
                Text(
                  '${l10n.select_your_highest_education}',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: KColors.black,
                      ),
                ),
              ],
            ),
          ),
          SizedBox(height: KSizes.defaultSpace),
          education.isEmpty
              ? SizedBox()
              : Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: education.length,
                            itemBuilder: (context, index) {
                              final edu = education[index];
                              return Column(
                                children: [
                                  ListTile(
                                    onTap: () {
                                      context.pop();
                                      filterProvider.setEducation(edu);
                                      filterProvider.getFilteredJobs(
                                          education: edu);
                                    },
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: KSizes.md),
                                    title: Text(
                                      edu,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: KSizes.md),
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
