

import 'package:flutter/material.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:frontend/features/authentication/providers/login_provider.dart';
import 'package:frontend/features/personalization/screens/profile/widgets/profile_without_login.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

 
    return Consumer<LoginProvider>(
      builder: (context, loginProvider, child) {
        final String? token = loginProvider.box.read("token");

        if (token == null) {
          return const ProfileWithoutLogin(); 
        }

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(KDeviceUtils.getAppBarHeight()),
            child: Material(
              elevation: 0.2,
              child: AppBar(
                title: Text(
                  l10n.profile,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontSize: 22),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      context.pushNamed(RoutesConstant.profileSettings);
                    },
                    icon: const Icon(Icons.settings_outlined),
                  ),
                  SizedBox(width: KSizes.xs),
                ],
              ),
            ),
          ),
          body: Center(
            child: Text(
              "Welcome, you are logged in!", // Your profile content here
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        );
      },
    );
  }
}
