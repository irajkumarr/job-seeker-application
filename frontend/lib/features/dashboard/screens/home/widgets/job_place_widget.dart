
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';

class JobPlaceWidget extends StatelessWidget {
  const JobPlaceWidget({
    super.key,
    required this.jobPlace,
  });

  final String jobPlace;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(KSizes.sm),
          border: Border.all(
            color: KColors.lightContainer,
          )),
      margin: EdgeInsets.only(right: KSizes.md - 4),
      padding: EdgeInsets.all(KSizes.sm),
      child: Column(
        children: [
          SizedBox(
            width: 50.w,
            height: 50.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                "https://www.neptos.io:3000/public/uploads/watermark-thumb/thumb-nimage-1590553913042.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: KSizes.sm),
          Text(
            jobPlace,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
