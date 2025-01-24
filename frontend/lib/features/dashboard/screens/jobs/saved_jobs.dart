import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/common/widgets/buttons/custom_button.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/image_strings.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:frontend/features/dashboard/widgets/login_redirect.dart';
import 'package:frontend/features/dashboard/widgets/status_and_saved_jobs_appbar.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:frontend/l10n/language_provider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class SavedJobsScreen extends StatelessWidget {
  const SavedJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final box = GetStorage();
    final String? token = box.read("token");
    if (token == null) {
      return LoginRedirect(
        isMatchedJobs: true,
      );
    }
    return SizedBox();
  }
}
