import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/custom_screen/custom_screen.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/validators/validation.dart';
import 'package:frontend/features/authentication/providers/timer_provider.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:provider/provider.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final authProvider = Provider.of<AuthProvider>(context);
    final timerProvider =
        Provider.of<ResendTimerProvider>(context, listen: false);
    final l10n = AppLocalizations.of(context)!;

    return CustomScreen(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          timerProvider.startTimer();
        }
      },
      child: Padding(
        padding: EdgeInsets.all(KSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Header Section
            SizedBox(height: KSizes.defaultSpace),

            Text(
              "${l10n.forgot_password}?",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
            ),
            SizedBox(height: KSizes.sm),
            Text(
              "${l10n.enter_phone_and_get_otp}",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: KColors.darkerGrey,
                    fontSize: 17.sp,
                  ),
            ),
            SizedBox(height: KSizes.defaultSpace),

            // Form Section
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    validator: (value) => KValidator.validateEmail(value),
                    decoration: InputDecoration(
                      labelText: "${l10n.email}",
                    ),
                  ),
                  SizedBox(height: KSizes.md),
                  Divider(
                    color: KColors.grey,
                  ),
                  SizedBox(
                    height: KSizes.spaceBtwSections,
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
