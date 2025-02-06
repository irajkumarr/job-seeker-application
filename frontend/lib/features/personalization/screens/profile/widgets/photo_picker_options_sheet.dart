import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/alert_box/snackbar.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

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
      if (source == ImageSource.camera) {
        var status = await Permission.camera.status;
        if (!status.isGranted) {
          status = await Permission.camera.request();
          if (!status.isGranted) {
            KSnackbar.CustomSnackbar(
                context, "Camera permission denied", KColors.error);
            return;
          }
        }
      }
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        widget.onImagePicked(File(pickedFile.path));
        if (mounted) context.pop();
      }
    } catch (e) {
      KSnackbar.CustomSnackbar(context, "Failed to pick image", KColors.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
                  '${l10n.upload_profile_photo}',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontSize: 20.sp,
                      ),
                ),
                SizedBox(height: KSizes.xs),
                Text(
                  '${l10n.choose_your_profile_photo}',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: KColors.black,
                      ),
                ),
              ],
            ),
          ),
          SizedBox(height: KSizes.md),
          ListTile(
            leading: Icon(Icons.photo_library_outlined),
            title: Text('${l10n.upload_from_gallery}'),
            trailing: Icon(
              Icons.arrow_forward_ios_outlined,
              size: KSizes.iconXs,
              color: KColors.darkGrey,
            ),
            onTap: () => _pickProfile(ImageSource.gallery),
          ),
          ListTile(
            leading: Icon(Icons.camera_alt_outlined),
            title: Text('${l10n.take_a_photo}'),
            trailing: Icon(
              Icons.arrow_forward_ios_outlined,
              size: KSizes.iconXs,
              color: KColors.darkGrey,
            ),
            onTap: () => _pickProfile(ImageSource.camera),
          ),
        ],
      ),
    );
  }
}
