import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/data/models/category_model.dart';
import 'package:frontend/features/dashboard/providers/filter_provider.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.category,
  });

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final filterProvider = Provider.of<FilterProvider>(context);
    return GestureDetector(
      onTap: () async {
        filterProvider.setCategory(category.name);
        context.pushNamed(RoutesConstant.filter, extra: false);
        await filterProvider.getFilteredJobs(category: category.name);
      },
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
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w700,
                      color: KColors.white,
                    ),
              ),
              Text(
                '${category.metadata.jobCount} ${l10n.jobs}',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: KColors.white,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
