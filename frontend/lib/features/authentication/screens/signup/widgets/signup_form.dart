import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/buttons/custom_button.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/image_strings.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/validators/validation.dart';
import 'package:frontend/features/authentication/providers/login_provider.dart';
import 'package:frontend/features/authentication/providers/signup_provider.dart';
import 'package:frontend/features/authentication/screens/signup/widgets/signup_phone_alert.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({
    super.key,
  });

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final _signupKey = GlobalKey<FormState>();
  bool _termsError = false;

  final FocusNode _mobileNumberFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
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
    _mobileNumberFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final signupProvider = Provider.of<SignupProvider>(context);
    bool showPrefixIcon = _mobileNumberFocusNode.hasFocus ||
        _mobileNumberController.text.isNotEmpty;
    return Form(
      key: _signupKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //name
          TextFormField(
            controller: _nameController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontSize: KSizes.fontSizeSm),
            validator: (value) =>
                KValidator.validateEmptyText("${l10n.name}", value),
            decoration: InputDecoration(
              labelText: "${l10n.name}",
            ),
          ),
          SizedBox(
            height: KSizes.defaultSpace,
          ),
          //mobile Number
          TextFormField(
            controller: _mobileNumberController,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.phone,
            focusNode: _mobileNumberFocusNode,
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

//           // Checkbox with Error
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: signupProvider.termsAndConditions,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  onChanged: (value) {
                    signupProvider.toggleTermsAndConditions();
                    if (value == true) {
                      setState(() {
                        _termsError = false;
                      });
                    }
                  },
                ),
              ),
              SizedBox(width: KSizes.sm),
              Expanded(
                child: Row(
                  children: [
                    Text(
                      "${l10n.i_agree_with}",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      " ${l10n.terms_and_condition}",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: KColors.primary,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (_termsError) // Conditionally show error
            Padding(
              padding: EdgeInsets.only(top: KSizes.xs),
              child: Text(l10n.agree_terms_and_conditions,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: KColors.error,
                      )),
            ),
          SizedBox(height: KSizes.defaultSpace),
          CustomButton(
            text: l10n.sign_up,
            onPressed: () async {
              // if (_signupKey.currentState!.validate()) {

              //   await signupPhoneAlert(
              //       context, _mobileNumberController.text.trim());
              // }
              if (_signupKey.currentState!.validate()) {
                if (!signupProvider.termsAndConditions) {
                  setState(() {
                    _termsError = true; // Show error if unchecked
                  });
                  return;
                }

                // Proceed with signup logic
                await signupPhoneAlert(
                    context, _mobileNumberController.text.trim());
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
                "${l10n.already_have_account}",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              GestureDetector(
                onTap: () {
                  context.pushNamed(RoutesConstant.login);
                },
                child: Text(
                  "${l10n.sign_in}",
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
