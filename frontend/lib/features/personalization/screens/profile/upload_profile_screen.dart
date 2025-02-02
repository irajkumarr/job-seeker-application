import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/alert_box/snackbar.dart';
import 'package:frontend/common/widgets/appbar/appbar.dart';
import 'package:frontend/common/widgets/buttons/custom_button.dart';
import 'package:frontend/common/widgets/loaders/full_screen_overlay.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:frontend/features/personalization/providers/profile_provider.dart';
import 'package:frontend/features/personalization/screens/profile/widgets/image_preview.dart';
import 'package:frontend/features/personalization/screens/profile/widgets/photo_picker_options_sheet.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class UploadProfileScreen extends StatefulWidget {
  const UploadProfileScreen({super.key});

  @override
  State<UploadProfileScreen> createState() => _UploadProfileScreenState();
}

class _UploadProfileScreenState extends State<UploadProfileScreen> {
  File? _selectedImage;
  // final ImagePicker _picker = ImagePicker();

  // Function to pick an image
  // Future<void> _pickProfile(ImageSource source) async {
  //   try {
  //     final XFile? pickedFile = await _picker.pickImage(source: source);

  //     if (pickedFile != null) {
  //       setState(() {
  //         _selectedImage = File(pickedFile.path);
  //       });
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to pick image')),
  //     );
  //   }
  // }

  // Show the bottom sheet for picking an image
  void _showPhotoPickerBottomSheet() {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      builder: (context) => PhotoPickerOptionsBottomSheet(
        onImagePicked: (File image) {
          setState(() {
            _selectedImage = image;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return FullScreenOverlay(
      isLoading: profileProvider.isLoading,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(KDeviceUtils.getAppBarHeight()),
          child: Appbar(isActionRequired: false),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: KSizes.md, vertical: KSizes.defaultSpace),
                  child: Column(
                    children: [
                      Text(
                        "Upload your profile photo",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      SizedBox(height: KSizes.sm),
                      Text(
                        "Choose and upload a clearly recognizable photo",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontSize: 17.sp,
                            ),
                      ),
                      SizedBox(height: KSizes.defaultSpace),

                      // Profile Image with Add Button
                      GestureDetector(
                        onTap: _showPhotoPickerBottomSheet,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 150.w,
                              height: 150.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: KColors.grey),
                              ),
                              child: ClipOval(
                                child: _selectedImage != null
                                    ? Image.file(
                                        _selectedImage!,
                                        width: 150.w,
                                        height: 150.h,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        "assets/images/content/my_status_person.gif",
                                        width: 150.w,
                                        height: 150.h,
                                        fit: BoxFit.contain,
                                      ),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: Container(
                                padding: EdgeInsets.all(KSizes.sm - 2),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: KColors.primary,
                                ),
                                child: Icon(Icons.add, color: KColors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
                      text: "Skip",
                      isIconShowed: false,
                      color: KColors.secondaryBackground,
                      textColor: KColors.black,
                      onPressed: () {
                        context.pop();
                      },
                    ),
                  ),
                  SizedBox(width: KSizes.sm),
                  if (_selectedImage == null) ...[
                    Expanded(
                      flex: 2,
                      child: CustomButton(
                        text: "Upload Photo",
                        isIconShowed: false,
                        onPressed: _showPhotoPickerBottomSheet,
                      ),
                    ),
                  ] else ...[
                    Expanded(
                      flex: 2,
                      child: CustomButton(
                        text: "Next",
                        isIconShowed: false,
                        onPressed: () {
                          showImagePreview(context, _selectedImage!, () async {
                            context.pop();
                            await profileProvider.updateProfileImage(
                                context, _selectedImage!);

                            KSnackbar.CustomSnackbar(context,
                                "Profile Image Updated!", KColors.primary);
                            Provider.of<ProfileProvider>(context, listen: false)
                                .fetchProfile(forceRefresh: true);
                            context.pop();
                          });
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
