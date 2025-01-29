import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/texts/section_row_title_text.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/image_strings.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:frontend/features/personalization/screens/profile/widgets/language_bottom_sheet.dart';
import 'package:frontend/features/personalization/screens/profile/widgets/profile_appbar.dart';
import 'package:frontend/features/personalization/screens/profile/widgets/profile_header.dart';
import 'package:frontend/features/personalization/screens/profile/widgets/profile_without_login.dart';
import 'package:frontend/features/personalization/screens/profile/widgets/settings_tile.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:frontend/l10n/language_provider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final box = GetStorage();
    final String? token = box.read("token");
    if (token != null) {
      return ProfileWithoutLogin();
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(KDeviceUtils.getAppBarHeight()),
        child: ProfileAppbar(),
      ),
    );
  }
}
