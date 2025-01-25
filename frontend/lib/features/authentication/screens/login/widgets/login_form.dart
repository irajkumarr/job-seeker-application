import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/buttons/custom_button.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/validators/validation.dart';
import 'package:frontend/features/authentication/providers/login_provider.dart';
import 'package:frontend/features/authentication/providers/password_provider.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final loginProvider = Provider.of<LoginProvider>(context);
    final TextEditingController _mobileNumberController =
        TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final _loginKey = GlobalKey<FormState>();
    return Form(
      key: _loginKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _mobileNumberController,
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
              controller: _passwordController,
              textInputAction: TextInputAction.done,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontSize: KSizes.fontSizeSm),
              validator: (value) =>
                  KValidator.validateEmptyText("${l10n.password}", value),
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
          SizedBox(height: KSizes.md),

          ///remember me and forgot password
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      value: loginProvider.rememberMe,
                      onChanged: (value) {
                        loginProvider.toggleRememberMe();
                      },
                    ),
                  ),
                  SizedBox(
                    width: KSizes.sm,
                  ),
                  Text(
                    "${l10n.remember_me}",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              //forget password
              GestureDetector(
                onTap: () {},
                child: Text(
                  "${l10n.forgot_password}?",
                  style: TextStyle(
                      color: KColors.darkGrey, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          SizedBox(height: KSizes.defaultSpace),
          CustomButton(
            text: l10n.sign_in,
            isIconShowed: true,
            icon: Icons.arrow_forward,
            onPressed: () {
              if (_loginKey.currentState!.validate()) {}
            },
          ),

          SizedBox(height: KSizes.md),
          Divider(
            color: KColors.grey,
          ),

          SizedBox(height: KSizes.defaultSpace),
          //sign up button
          Row(
            spacing: KSizes.xs,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${l10n.are_you_new_to_the_app}",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              GestureDetector(
                onTap: () {
                  context.pushNamed(RoutesConstant.signup);
                },
                child: Text(
                  "${l10n.sign_up}",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: KColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
