import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/appbar/appbar.dart';
import 'package:frontend/common/widgets/loaders/full_screen_overlay.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:frontend/features/authentication/providers/login_provider.dart';
import 'package:frontend/features/authentication/screens/login/widgets/login_form.dart';
import 'package:frontend/features/authentication/screens/login/widgets/login_header.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    return FullScreenOverlay(
      isLoading: loginProvider.isLoading,
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(KDeviceUtils.getAppBarHeight()),
            child: Appbar(isActionRequired: false),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: KSizes.md, vertical: KSizes.defaultSpace),
              child: Column(
                children: [
                  LoginHeader(),
                  SizedBox(height: KSizes.defaultSpace),
                  LoginForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
