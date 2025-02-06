import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/buttons/custom_button.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:go_router/go_router.dart';

void showImagePreview(
  BuildContext context,
  File image,
  VoidCallback onPressed,
) {
  final l10n = AppLocalizations.of(context)!;
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Allow the sheet to be as large as needed
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(KSizes.md),
      ),
    ),
    builder: (context) => Container(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: KSizes.md),
                    child: Column(
                      children: [
                        Text(
                          '${l10n.preview_photo}',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                fontSize: 20.sp,
                              ),
                        ),
                        SizedBox(height: KSizes.xs),
                        Text(
                          '${l10n.choose_upload_recognizable_photo}',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: KColors.black,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: KSizes.defaultSpace),
                  GestureDetector(
                    onTap: () {
                      context.pushNamed(
                        RoutesConstant.imagePreview,
                        extra: {
                          'file': image,
                          'image': null,
                          'isFile': true,
                        },
                      );
                    },
                    child: Container(
                      width: 200.w,
                      height: 200.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: KColors.grey),
                      ),
                      child: ClipOval(
                        child: Image.file(
                          image,
                          width: 200.w,
                          height: 200.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Divider line
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
            ),
          ),
          // Conditional Buttons
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: KSizes.md, vertical: KSizes.sm),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: CustomButton(
                    text: "${l10n.cancel}",
                    isIconShowed: false,
                    color: KColors.secondaryBackground,
                    textColor: KColors.black,
                    onPressed: () {
                      context.pop();
                    },
                  ),
                ),
                SizedBox(width: KSizes.sm),
                Expanded(
                  flex: 2,
                  child: CustomButton(
                    text: "${l10n.upload_photo}",
                    isIconShowed: false,
                    onPressed: onPressed,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class ImagePreview extends StatelessWidget {
  const ImagePreview({super.key, this.image, this.isFile = false, this.file});
  final String? image;
  final File? file;
  final bool isFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.dark,
      appBar: AppBar(
        backgroundColor: KColors.dark,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: KColors.white,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        padding: EdgeInsets.all(KSizes.sm),
        child: Stack(
          children: [
            // Image preview
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(KSizes.md),
                child: InteractiveViewer(
                  minScale: 0.5,
                  maxScale: 4,
                  child: isFile
                      ? Image.file(
                          file!,
                          fit: BoxFit.contain,
                        )
                      : Image.network(
                          image!,
                          fit: BoxFit.contain,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
