import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/buttons/custom_button.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/image_strings.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/validators/validation.dart';
import 'package:frontend/data/models/login_request.dart';
import 'package:frontend/features/authentication/providers/login_provider.dart';
import 'package:frontend/features/authentication/providers/password_provider.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _loginKey = GlobalKey<FormState>();
  final FocusNode _mobileNumberFocusNode = FocusNode();


  @override
  void initState() {
    super.initState();

    /// **Retrieve Saved Credentials**
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final savedCredentials = loginProvider.getSavedCredentials();

    if (savedCredentials["mobile"] != null) {
      _mobileNumberController.text = savedCredentials["mobile"]!;
    }
    if (savedCredentials["password"] != null) {
      _passwordController.text = savedCredentials["password"]!;
    }

    _mobileNumberController.addListener(() {
      setState(() {});
    });
    _mobileNumberFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _mobileNumberController.dispose();
    _passwordController.dispose();
    _mobileNumberFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final loginProvider = Provider.of<LoginProvider>(context);
    bool showPrefixIcon = _mobileNumberFocusNode.hasFocus ||
        _mobileNumberController.text.isNotEmpty;
    return Form(
      key: _loginKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _mobileNumberController,
            textInputAction: TextInputAction.next,
            focusNode: _mobileNumberFocusNode,
            keyboardType: TextInputType.phone,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontSize: KSizes.fontSizeSm),
            validator: (value) => KValidator.validatePhoneNumber(value),
            decoration: InputDecoration(
              labelText: "${l10n.mobileNumber}",
              prefixIcon: showPrefixIcon
                  ? Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            KImages.flagNepal,
                            height: 24,
                            width: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "+977",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: KColors.darkerGrey,
                                ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            height: 28, // Match text field height
                            width: 1, // Set thickness
                            color: Colors.grey, // Divider color
                          ),
                        ],
                      ),
                    )
                  : null,
              prefixIconConstraints: const BoxConstraints(
                minWidth: 0,
                minHeight: 0,
              ),
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
              InkWell(
                onTap: () {
                  loginProvider.toggleRememberMe();
                },
                child: Row(
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
              ),
              //forget password
              GestureDetector(
                onTap: () {
                  context.pushNamed(RoutesConstant.forgotPassword);
                },
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
            onPressed: () async {
              if (_loginKey.currentState!.validate()) {
                LoginRequest model = LoginRequest(
                  mobileNumber: _mobileNumberController.text.trim(),
                  password: _passwordController.text,
                );
                String data = loginRequestToJson(model);
                await loginProvider.login(
                    context,
                    data,
                    _mobileNumberController.text.trim(),
                    _passwordController.text.trim());
              }
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
