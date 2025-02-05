import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/image_strings.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/data/models/blog_model.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:intl/intl.dart';

class BlogsTile extends StatelessWidget {
  const BlogsTile({
    super.key,
    required this.blog,
  });

  final Result blog;

  @override
  Widget build(BuildContext context) {
    DateTime parsedDate = DateTime.parse(blog.createdAt.toString()).toLocal();

    String createdFullDate = DateFormat('MMMM dd, yyyy').format(parsedDate);

    final l10n = AppLocalizations.of(context)!;
    return SizedBox(
      width: 300.w,
      child: Card(
        elevation: 0.5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(KSizes.sm),
        ),
        color: KColors.white,
        child: Column(
          children: [
            SizedBox(
              height: 175.h,
              child: ClipRRect(
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(KSizes.sm)),
                child: CachedNetworkImage(
                  imageUrl: blog.image,
                  placeholder: (context, url) =>
                      SizedBox(child: Image.asset(KImages.defaultBuilding)),
                  errorWidget: (context, url, error) =>
                      Image.asset(KImages.defaultBuilding),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: KSizes.md),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: KSizes.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    utf8.decode(blog.title.codeUnits),
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontFamily: "Mukta",
                          fontWeight: FontWeight.w700,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: KSizes.sm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        createdFullDate,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        "${l10n.total_views}: ${blog.viewCount.toString()}",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
