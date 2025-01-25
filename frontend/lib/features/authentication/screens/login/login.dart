import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/appbar/appbar.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:frontend/features/authentication/screens/login/widgets/login_form.dart';
import 'package:frontend/features/authentication/screens/login/widgets/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(KDeviceUtils.getAppBarHeight()),
        child: Appbar(isActionRequired: false),
      ),
      body: Padding(
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
    );
  }
}
