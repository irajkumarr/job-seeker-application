import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/buttons/custom_button.dart';
import 'package:frontend/common/widgets/loaders/full_screen_overlay.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/validators/validation.dart';
import 'package:frontend/features/authentication/providers/password_provider.dart';
import 'package:frontend/features/personalization/providers/profile_provider.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:provider/provider.dart';

void showChangePasswordBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isDismissible: true,
    showDragHandle: false,
    isScrollControlled: true,
    sheetAnimationStyle: AnimationStyle(
      duration: Duration(milliseconds: 500),
      reverseDuration: Duration(milliseconds: 500),
    ),
    backgroundColor: Colors.transparent,
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.75,
        minChildSize: 0.75,
        maxChildSize: 0.75,
        expand: false,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: KColors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(KSizes.md + 3),
              ),
            ),
            child: ChangePasswordScreen(scrollController: scrollController),
          );
        },
      );
    },
  );
}

class ChangePasswordScreen extends StatefulWidget {
  final ScrollController scrollController;

  const ChangePasswordScreen({super.key, required this.scrollController});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final profileProvider = Provider.of<ProfileProvider>(context);
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(KSizes.md + 3),
      ),
      child: FullScreenOverlay(
        isLoading: profileProvider.isLoading,
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              currentFocus.unfocus();
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag Handle
              Padding(
                padding: EdgeInsets.only(
                  top: KSizes.defaultSpace,
                  left: KSizes.defaultSpace,
                  right: KSizes.defaultSpace,
                ),
                child: Center(
                  child: Container(
                    width: 35.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: KColors.darkerGrey,
                      borderRadius: BorderRadius.circular(KSizes.md),
                    ),
                  ),
                ),
              ),
              // const SizedBox(height: KSizes.defaultSpace),
              Expanded(
                child: SingleChildScrollView(
                  controller:
                      widget.scrollController, // Use the passed controller
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: KSizes.spaceBtwSections,
                      horizontal: KSizes.defaultSpace,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${l10n.change_password}',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                        ),
                        SizedBox(height: KSizes.sm),
                        Text(
                          '${l10n.enter_new_password_to_change_your_password}',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                        ),
                        SizedBox(height: KSizes.defaultSpace),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              //old password
                              Consumer<PasswordProvider>(
                                  builder: (context, value, child) {
                                return TextFormField(
                                  controller: _oldPasswordController,
                                  textInputAction: TextInputAction.next,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontSize: KSizes.fontSizeSm),
                                  validator: (value) =>
                                      KValidator.validateEmptyText(
                                          "${l10n.current_password}", value),
                                  obscureText: value.oldPasswordVisible,
                                  decoration: InputDecoration(
                                    labelText: "${l10n.current_password}",
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        value.toggleOldPasswordVisibility();
                                      },
                                      icon: Icon(value.oldPasswordVisible
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined),
                                    ),
                                  ),
                                );
                              }),
                              SizedBox(height: KSizes.md),
                              //new password
                              Consumer<PasswordProvider>(
                                  builder: (context, value, child) {
                                return TextFormField(
                                  controller: _newPasswordController,
                                  textInputAction: TextInputAction.next,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontSize: KSizes.fontSizeSm),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '${l10n.enter_new_password}';
                                    }
                                    if (value == _oldPasswordController.text) {
                                      return '${l10n.new_password_cannot_be_same_as_old_password}';
                                    }
                                    return null;
                                  },
                                  obscureText: value.newPasswordVisible,
                                  decoration: InputDecoration(
                                    labelText: "${l10n.new_password}",
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          value.toggleNewPasswordVisibility();
                                        },
                                        icon: Icon(value.newPasswordVisible
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined)),
                                  ),
                                );
                              }),
                              SizedBox(height: KSizes.md),
                              //confirm new password
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
                                      return '${l10n.please_enter_confirm_password}';
                                    }
                                    if (value != _newPasswordController.text) {
                                      return '${l10n.password_donot_match}';
                                    }
                                    return null;
                                  },
                                  obscureText: value.confirmPasswordVisible,
                                  decoration: InputDecoration(
                                    labelText: "${l10n.confirm_new_password}",
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          value
                                              .toggleConfirmPasswordVisibility();
                                        },
                                        icon: Icon(value.confirmPasswordVisible
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined)),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Divider
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                  ),
                ),
              ),
              // Update password button
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    horizontal: KSizes.md, vertical: KSizes.sm),
                child: CustomButton(
                  text:
                      //  profileProvider.isLoading
                      //     ? "${l10n.loading}"
                      //     :
                      "${l10n.update_password}",
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Handle update logic

                      await profileProvider.changePassword(
                          context,
                          _oldPasswordController.text,
                          _newPasswordController.text);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
