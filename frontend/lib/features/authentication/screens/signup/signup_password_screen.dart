import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/custom_screen/custom_screen.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/constants/text_strings.dart';
import 'package:frontend/core/utils/validators/validation.dart';
import 'package:frontend/features/authentication/providers/password_provider.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:provider/provider.dart';

class SignupPasswordScreen extends StatelessWidget {
  const SignupPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _confirmPasswordController =
        TextEditingController();
    final _signupPasswordFormKey = GlobalKey<FormState>();
    final l10n = AppLocalizations.of(context)!;
    return CustomScreen(
        onPressed: () {
          if (_signupPasswordFormKey.currentState!.validate()) {}
        },
        child: Padding(
          padding: EdgeInsets.all(KSizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: KSizes.defaultSpace),
              Text(
                "${l10n.password}",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
              SizedBox(height: KSizes.sm),
              Text(
                "${l10n.please_enter} ${l10n.and} \n${l10n.confirm_your_password}",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: KColors.darkerGrey,
                      fontSize: 17.sp,
                    ),
              ),
              SizedBox(height: KSizes.defaultSpace),
              //form
              Form(
                key: _signupPasswordFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///Password
                    Consumer<PasswordProvider>(
                        builder: (context, value, child) {
                      return TextFormField(
                        controller: _passwordController,
                        textInputAction: TextInputAction.next,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontSize: KSizes.fontSizeSm),
                        validator: (value) =>
                            KValidator.validatePassword(value),
                        obscureText: value.signupPasswordVisible,
                        decoration: InputDecoration(
                          // prefixIcon: const Icon(Iconsax.password_check),
                          labelText: "${l10n.password}",
                          suffixIcon: IconButton(
                            onPressed: () {
                              value.toggleSignupPasswordVisibility();
                            },
                            icon: Icon(value.signupPasswordVisible
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined),
                          ),
                        ),
                      );
                    }),
                    // SizedBox(height: KSizes.sm),

                    // Text(
                    //   "Minimum password length must be 8 characters",
                    //   style: Theme.of(context).textTheme.labelSmall,
                    // ),
                    SizedBox(
                      height: KSizes.defaultSpace,
                    ),

                    ///confirm password-------------------
                    Consumer<PasswordProvider>(
                        builder: (context, value, child) {
                      return TextFormField(
                        controller: _confirmPasswordController,
                        textInputAction: TextInputAction.done,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontSize: KSizes.fontSizeSm),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "${l10n.please_enter_confirm_password}";
                          }
                          if (value != _passwordController.text) {
                            return '"${l10n.password_donot_match}"';
                          }
                          return null;
                        },
                        obscureText: value.signupConfirmPasswordVisible,
                        decoration: InputDecoration(
                          // prefixIcon: const Icon(Iconsax.password_check),
                          labelText: "${l10n.confirm_password}",
                          suffixIcon: IconButton(
                            onPressed: () {
                              value.toggleSignupConfirmPasswordVisibility();
                            },
                            icon: Icon(value.signupConfirmPasswordVisible
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined),
                          ),
                        ),
                      );
                    }),
                    // SizedBox(height: KSizes.sm),

                    // Text(
                    //   "Both passwords must match",
                    //   style: Theme.of(context).textTheme.labelSmall,
                    // ),
                    SizedBox(height: KSizes.defaultSpace),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
