import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/texts/section_row_title_text.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/shimmers/categories_shimmer.dart';
import 'package:frontend/features/dashboard/providers/blog_provider.dart';
import 'package:frontend/features/dashboard/screens/home/widgets/blogs_tile.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:provider/provider.dart';

class HomeBlogsSection extends StatelessWidget {
  const HomeBlogsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final blogProvider = Provider.of<BlogProvider>(context);

    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionRowTitleText(
          title: l10n.blogs,
          subTitle: l10n.check_out_our_new_blogs_post,
          isViewAll: true,
        ),
        SizedBox(height: KSizes.md),
        blogProvider.isLoading
            ? CatergoriesShimmer()
            : Container(
                height: 265.h,
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: KSizes.md),
                  scrollDirection: Axis.horizontal,
                  itemCount: blogProvider.blogs?.results.length ?? 0,
                  itemBuilder: (context, index) {
                    final blog = blogProvider.blogs!.results[index];

                    return BlogsTile(blog: blog);
                  },
                ),
              ),
      ],
    );
  }
}
