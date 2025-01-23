import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/shimmers/categories_shimmer.dart';
import 'package:frontend/data/models/category_model.dart';
import 'package:frontend/features/dashboard/providers/category_provider.dart';
import 'package:frontend/features/dashboard/screens/home/widgets/category_widget.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:provider/provider.dart';

class HomeCategoryList extends StatelessWidget {
  const HomeCategoryList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);

    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: KSizes.md),
          child: Text(
            "${l10n.what_kind_of_job_do_you_want}",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 15,
                ),
          ),
        ),
        SizedBox(height: KSizes.md),
        categoryProvider.isLoading
            ? CatergoriesShimmer()
            : Container(
                height: 225.h,
                child: ListView.builder(
                    padding: const EdgeInsets.only(left: KSizes.md),
                    scrollDirection: Axis.horizontal,
                    itemCount: categoryProvider.categories?.length ?? 0,
                    itemBuilder: (context, index) {
                      final CategoryModel category =
                          categoryProvider.categories![index];
                      return CategoryWidget(category: category);
                    }),
              ),
      ],
    );
  }
}
