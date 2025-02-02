// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:frontend/common/widgets/appbar/appbar.dart';
// import 'package:frontend/common/widgets/buttons/custom_button.dart';
// import 'package:frontend/core/utils/constants/colors.dart';
// import 'package:frontend/core/utils/constants/sizes.dart';
// import 'package:frontend/core/utils/device/device_utility.dart';
// import 'package:frontend/features/personalization/screens/profile/widgets/user_icon_with_add_button.dart';
// import 'package:frontend/l10n/l10n.dart';
// import 'package:go_router/go_router.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';

// class UploadProfileScreen extends StatelessWidget {
//   const UploadProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(KDeviceUtils.getAppBarHeight()),
//         child: Appbar(isActionRequired: false),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               physics: AlwaysScrollableScrollPhysics(),
//               child: Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: KSizes.md, vertical: KSizes.defaultSpace),
//                 child: Column(
//                   children: [
//                     Text(
//                       "Upload your profile photo",
//                       style: Theme.of(context).textTheme.headlineMedium,
//                     ),
//                     SizedBox(height: KSizes.sm),
//                     Text(
//                       "Choose and upload clearly recognizable photo",
//                       style: Theme.of(context).textTheme.titleSmall!.copyWith(
//                             fontSize: 17.sp,
//                           ),
//                     ),
//                     SizedBox(height: KSizes.defaultSpace),
//                     Stack(
//                       children: [
//                         Container(
//                           padding: EdgeInsets.all(KSizes.sm),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(100),
//                             border: Border.all(
//                               color: KColors.grey,
//                             ),
//                           ),
//                           child: Image.asset(
//                             "assets/images/content/my_status_person.gif",
//                             width: 150.w,
//                             height: 150.h,
//                             fit: BoxFit.contain,
//                           ),
//                         ),
//                         Positioned(
//                           bottom: 10,
//                           right: 10,
//                           child: Container(
//                             padding: EdgeInsets.all(KSizes.sm - 2),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(50),
//                               color: KColors.primary,
//                             ),
//                             child: Icon(
//                               Icons.add,
//                               color: KColors.white,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),

//           // Divider line
//           Container(
//             decoration: BoxDecoration(
//               border: Border(
//                 top: BorderSide(
//                   color: Colors.grey.shade300,
//                   width: 1,
//                 ),
//               ),
//             ),
//           ),

//           // Next button - always at bottom
//           Padding(
//             padding: EdgeInsets.symmetric(
//                 horizontal: KSizes.md, vertical: KSizes.sm),
//             child: Row(
//               spacing: KSizes.sm,
//               children: [
//                 Expanded(
//                   flex: 1,
//                   child: Container(
//                     child: CustomButton(
//                       text: "Skip",
//                       isIconShowed: false,
//                       icon: Icons.arrow_forward,
//                       color: KColors.secondaryBackground,
//                       textColor: KColors.black,
//                       onPressed: () {
//                         // context.pop();
//                       },
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   flex: 2,
//                   child: Container(
//                     child: CustomButton(
//                       text: "Upload Photo",
//                       isIconShowed: false,
//                       icon: Icons.arrow_forward,
//                       onPressed: () {
//                         showPhotoPickerOptionsBottomSheet(context);
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class PhotoPickerOptionsBottomSheet extends StatefulWidget {
//   PhotoPickerOptionsBottomSheet({Key? key}) : super(key: key);

//   @override
//   State<PhotoPickerOptionsBottomSheet> createState() =>
//       _PhotoPickerOptionsBottomSheetState();
// }

// class _PhotoPickerOptionsBottomSheetState
//     extends State<PhotoPickerOptionsBottomSheet> {
//   // File? _selectedFile;

//   // Future<void> _pickProfile(ImageSource source) async {
//   //   try {
//   //     final ImagePicker picker = ImagePicker();
//   //     final XFile? pickedFile = await picker.pickImage(source: source);

//   //     if (pickedFile != null) {
//   //       if (mounted) {
//   //         setState(() {
//   //           _selectedFile = File(pickedFile.path);
//   //         });
//   //       }
//   //     }
//   //   } catch (e) {
//   //     print("Error picking image: $e");
//   //     if (mounted) {
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(content: Text('Failed to pick image')),
//   //       );
//   //     }
//   //   }
//   // }
//   File? _selectedFile;
//   final ImagePicker _picker = ImagePicker();

//   // Function to request camera permission and pick image
//   Future<void> _pickProfile(ImageSource source) async {
//     try {
//       if (source == ImageSource.camera) {
//         var status = await Permission.camera.status;
//         if (!status.isGranted) {
//           status = await Permission.camera.request();
//           if (!status.isGranted) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Camera permission denied')),
//             );
//             return;
//           }
//         }
//       }

//       final XFile? pickedFile = await _picker.pickImage(source: source);

//       if (pickedFile != null) {
//         if (mounted) {
//           setState(() {
//             _selectedFile = File(pickedFile.path);
//           });
//         }
//       }
//     } catch (e) {
//       print("Error picking image: $e");
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to pick image')),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {

//     return Container(
//       padding: EdgeInsets.symmetric(vertical: KSizes.md),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(KSizes.md)),
//       ),
//       child: Column(
//         // crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // Drag Handle
//           Center(
//             child: Container(
//               width: 35.w,
//               height: 4.h,
//               decoration: BoxDecoration(
//                 color: KColors.darkerGrey,
//                 borderRadius: BorderRadius.circular(KSizes.md),
//               ),
//             ),
//           ),
//           const SizedBox(height: KSizes.defaultSpace),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: KSizes.md),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Upload Profile Photo',
//                   style: Theme.of(context).textTheme.headlineMedium!.copyWith(
//                         fontSize: 20.sp,
//                       ),
//                 ),
//                 SizedBox(height: KSizes.xs),
//                 Text(
//                   'Choose your profile photo to upload',
//                   style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                         color: KColors.black,
//                       ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: KSizes.md),
//           // Language Options
//           ListView(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             children: [
//               ListTile(
//                 tileColor: KColors.white,
//                 leading: Icon(Icons.phone_android_outlined),
//                 title: Text(
//                   'Upload from Gallery',
//                   style: Theme.of(context).textTheme.titleMedium,
//                 ),
//                 trailing: Icon(
//                   Icons.arrow_forward_ios_outlined,
//                   size: KSizes.iconSm,
//                   color: KColors.darkGrey,
//                 ),
//                 onTap: () async {
//                   await _pickProfile(
//                       ImageSource.gallery); // Wait for image selection
//                   if (mounted)
//                     context.pop(); // Close bottom sheet after picking image
//                 },
//               ),
//               ListTile(
//                 tileColor: KColors.white,
//                 leading: Icon(Icons.camera_alt_outlined),
//                 title: Text(
//                   'Take a photo',
//                   style: Theme.of(context).textTheme.titleMedium,
//                 ),
//                 trailing: Icon(
//                   Icons.arrow_forward_ios_outlined,
//                   size: KSizes.iconSm,
//                   color: KColors.darkGrey,
//                 ),
//                 onTap: () async {
//                   await _pickProfile(
//                       ImageSource.camera); // Wait for image selection
//                   if (mounted)
//                     context.pop(); // Close bottom sheet after picking image
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Usage:
// void showPhotoPickerOptionsBottomSheet(BuildContext context) {
//   showModalBottomSheet(
//     context: context,
//     isDismissible: true,
//     isScrollControlled: true,
//     showDragHandle: false,
//     sheetAnimationStyle: AnimationStyle(
//       duration: Duration(milliseconds: 500),
//       reverseDuration: Duration(milliseconds: 500),
//     ),
//     builder: (context) => PhotoPickerOptionsBottomSheet(),
//   );
// }

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:frontend/common/widgets/appbar/appbar.dart';
// import 'package:frontend/common/widgets/buttons/custom_button.dart';
// import 'package:frontend/core/utils/constants/colors.dart';
// import 'package:frontend/core/utils/constants/sizes.dart';
// import 'package:frontend/core/utils/device/device_utility.dart';
// import 'package:frontend/l10n/l10n.dart';
// import 'package:go_router/go_router.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';

// class UploadProfileScreen extends StatefulWidget {
//   const UploadProfileScreen({super.key});

//   @override
//   _UploadProfileScreenState createState() => _UploadProfileScreenState();
// }

// class _UploadProfileScreenState extends State<UploadProfileScreen> {
//   File? _selectedFile;

//   void _updateSelectedImage(File? image) {
//     setState(() {
//       _selectedFile = image;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(KDeviceUtils.getAppBarHeight()),
//         child: Appbar(isActionRequired: false),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               physics: AlwaysScrollableScrollPhysics(),
//               child: Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: KSizes.md, vertical: KSizes.defaultSpace),
//                 child: Column(
//                   children: [
//                     Text(
//                       "Upload your profile photo",
//                       style: Theme.of(context).textTheme.headlineMedium,
//                     ),
//                     SizedBox(height: KSizes.sm),
//                     Text(
//                       "Choose and upload clearly recognizable photo",
//                       style: Theme.of(context).textTheme.titleSmall!.copyWith(
//                             fontSize: 17.sp,
//                           ),
//                     ),
//                     SizedBox(height: KSizes.defaultSpace),

//                     // Profile Image
//                     GestureDetector(
//                       onTap: () {
//                         showPhotoPickerOptionsBottomSheet(
//                             context, onImageSelected);
//                       },
//                       child: Stack(
//                         children: [
//                           Container(
//                             // padding: EdgeInsets.all(KSizes.sm),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(100),
//                               border: Border.all(
//                                 color: KColors.grey,
//                               ),
//                             ),
//                             child: ClipOval(
//                               child: _selectedFile != null
//                                   ? Image.file(
//                                       _selectedFile!,
//                                       width: 150.w,
//                                       height: 150.h,
//                                       fit: BoxFit.cover,
//                                     )
//                                   : Image.asset(
//                                       "assets/images/content/my_status_person.gif",
//                                       width: 150.w,
//                                       height: 150.h,
//                                       fit: BoxFit.contain,
//                                     ),
//                             ),
//                           ),
//                           Positioned(
//                             bottom: 10,
//                             right: 10,
//                             child: GestureDetector(
//                               onTap: () {
//                                 showPhotoPickerOptionsBottomSheet(
//                                     context, _updateSelectedImage);
//                               },
//                               child: Container(
//                                 padding: EdgeInsets.all(KSizes.sm - 2),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(50),
//                                   color: KColors.primary,
//                                 ),
//                                 child: Icon(
//                                   Icons.add,
//                                   color: KColors.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),

//           // Divider
//           Container(
//             decoration: BoxDecoration(
//               border: Border(
//                 top: BorderSide(
//                   color: Colors.grey.shade300,
//                   width: 1,
//                 ),
//               ),
//             ),
//           ),

//           // Next button
//           Padding(
//             padding: EdgeInsets.symmetric(
//                 horizontal: KSizes.md, vertical: KSizes.sm),
//             child: Row(
//               children: [
//                 Expanded(
//                   flex: 1,
//                   child: CustomButton(
//                     text: "Skip",
//                     isIconShowed: false,
//                     icon: Icons.arrow_forward,
//                     color: KColors.secondaryBackground,
//                     textColor: KColors.black,
//                     onPressed: () {},
//                   ),
//                 ),
//                 Expanded(
//                   flex: 2,
//                   child: CustomButton(
//                     text: "Upload Photo",
//                     isIconShowed: false,
//                     icon: Icons.arrow_forward,
//                     onPressed: () {
//                       showPhotoPickerOptionsBottomSheet(
//                           context, _updateSelectedImage);
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class PhotoPickerOptionsBottomSheet extends StatefulWidget {
//   final Function(File?) onImageSelected;

//   const PhotoPickerOptionsBottomSheet({Key? key, required this.onImageSelected})
//       : super(key: key);

//   @override
//   State<PhotoPickerOptionsBottomSheet> createState() =>
//       _PhotoPickerOptionsBottomSheetState();
// }

// class _PhotoPickerOptionsBottomSheetState
//     extends State<PhotoPickerOptionsBottomSheet> {
//   File? _selectedFile;
//   final ImagePicker _picker = ImagePicker();

//   Future<void> _pickProfile(ImageSource source) async {
//     try {
//       if (source == ImageSource.camera) {
//         var status = await Permission.camera.status;
//         if (!status.isGranted) {
//           status = await Permission.camera.request();
//           if (!status.isGranted) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Camera permission denied')),
//             );
//             return;
//           }
//         }
//       }

//       final XFile? pickedFile = await _picker.pickImage(source: source);

//       if (pickedFile != null) {
//         File imageFile = File(pickedFile.path);
//         widget.onImageSelected(imageFile);
//         if (mounted) context.pop(); // Close bottom sheet after selecting
//       }
//     } catch (e) {
//       print("Error picking image: $e");
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to pick image')),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: KSizes.md),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(KSizes.md)),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Center(
//             child: Container(
//               width: 35.w,
//               height: 4.h,
//               decoration: BoxDecoration(
//                 color: KColors.darkerGrey,
//                 borderRadius: BorderRadius.circular(KSizes.md),
//               ),
//             ),
//           ),
//           const SizedBox(height: KSizes.defaultSpace),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: KSizes.md),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Upload Profile Photo',
//                   style: Theme.of(context).textTheme.headlineMedium!.copyWith(
//                         fontSize: 20.sp,
//                       ),
//                 ),
//                 SizedBox(height: KSizes.xs),
//                 Text(
//                   'Choose your profile photo to upload',
//                   style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                         color: KColors.black,
//                       ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: KSizes.md),
//           ListView(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             children: [
//               ListTile(
//                 leading: Icon(Icons.photo_library),
//                 title: Text("Upload from Gallery"),
//                 onTap: () => _pickProfile(ImageSource.gallery),
//               ),
//               ListTile(
//                 leading: Icon(Icons.camera_alt),
//                 title: Text("Take a photo"),
//                 onTap: () => _pickProfile(ImageSource.camera),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Show Bottom Sheet
// void showPhotoPickerOptionsBottomSheet(
//     BuildContext context, Function(File?) onImageSelected) {
//   showModalBottomSheet(
//     context: context,
//     isDismissible: true,
//     isScrollControlled: true,
//     builder: (context) =>
//         PhotoPickerOptionsBottomSheet(onImageSelected: onImageSelected),
//   );
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/appbar/appbar.dart';
import 'package:frontend/common/widgets/buttons/custom_button.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:frontend/features/personalization/screens/profile/widgets/image_preview.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class UploadProfileScreen extends StatefulWidget {
  const UploadProfileScreen({super.key});

  @override
  State<UploadProfileScreen> createState() => _UploadProfileScreenState();
}

class _UploadProfileScreenState extends State<UploadProfileScreen> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  // Function to pick an image
  Future<void> _pickProfile(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image')),
      );
    }
  }

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
    return Scaffold(
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
                        showImagePreview(context, _selectedImage!);
                      },
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PhotoPickerOptionsBottomSheet extends StatefulWidget {
  final Function(File) onImagePicked;
  const PhotoPickerOptionsBottomSheet({Key? key, required this.onImagePicked})
      : super(key: key);

  @override
  State<PhotoPickerOptionsBottomSheet> createState() =>
      _PhotoPickerOptionsBottomSheetState();
}

class _PhotoPickerOptionsBottomSheetState
    extends State<PhotoPickerOptionsBottomSheet> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickProfile(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        widget.onImagePicked(File(pickedFile.path));
        if (mounted) context.pop(); // Close bottom sheet after picking
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: KSizes.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(KSizes.md)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: KSizes.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Upload Profile Photo',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontSize: 20.sp,
                      ),
                ),
                SizedBox(height: KSizes.xs),
                Text(
                  'Choose your profile photo to upload',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: KColors.black,
                      ),
                ),
              ],
            ),
          ),
          SizedBox(height: KSizes.md),
          ListTile(
            leading: Icon(Icons.photo_library),
            title: Text('Upload from Gallery'),
            onTap: () => _pickProfile(ImageSource.gallery),
          ),
          ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text('Take a Photo'),
            onTap: () => _pickProfile(ImageSource.camera),
          ),
        ],
      ),
    );
  }
}
