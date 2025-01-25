import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/appbar/appbar.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:frontend/core/utils/validators/validation.dart';
import 'package:frontend/features/authentication/providers/password_provider.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
            Text(
              "${l10n.sign_in}",
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            SizedBox(height: KSizes.sm),
            Text(
              "Please enter your registered mobile number and password to log in.",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                    color: KColors.dark,
                  ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: KSizes.defaultSpace),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    // controller: _phoneController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: KSizes.fontSizeSm),
                    validator: (value) => KValidator.validatePhoneNumber(value),
                    decoration: InputDecoration(
                      labelText: "${l10n.mobileNumber}",
                    ),
                  ),
                  SizedBox(
                    height: KSizes.defaultSpace,
                  ),

                  ///Password
                  Consumer<PasswordProvider>(builder: (context, value, child) {
                    return TextFormField(
                      // controller: _passwordController,
                      textInputAction: TextInputAction.done,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: KSizes.fontSizeSm),
                      validator: (value) => KValidator.validateEmptyText(
                          "${l10n.password}", value),
                      obscureText: value.loginPasswordVisible,
                      decoration: InputDecoration(
                        // prefixIcon: const Icon(Iconsax.password_check),
                        labelText: "${l10n.password}",
                        suffixIcon: IconButton(
                            onPressed: () {
                              value.toggleLoginPasswordVisibility();
                            },
                            icon: Icon(value.loginPasswordVisible
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined)),
                      ),
                    );
                  }),
                  SizedBox(
                    height: KSizes.spaceBtwInputFields / 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
