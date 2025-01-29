import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:frontend/features/authentication/providers/login_provider.dart';
import 'package:frontend/features/personalization/providers/profile_provider.dart';
import 'package:frontend/features/personalization/screens/profile/widgets/profile_without_login.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:iconsax/iconsax.dart';

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

        return Consumer<ProfileProvider>(
          builder: (context, profileProvider, child) {
            if (profileProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (profileProvider.user == null) {
              return const ProfileWithoutLogin();
            }

            final user = profileProvider.user!;

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
              body: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: KSizes.md, vertical: KSizes.md),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      UserIconWithAddButton(),
                      SizedBox(height: KSizes.md),
                      Text(
                        "${user.name}",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      SizedBox(height: KSizes.xs),
                      Text(
                        "977-${user.mobileNumber}",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      SizedBox(height: KSizes.defaultSpace),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text("Jobs Applied"),
                              SizedBox(height: KSizes.xs),
                              Text(
                                "0",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: KColors.primary,
                                    ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text("Profile Visits"),
                              SizedBox(height: KSizes.xs),
                              Text(
                                "0",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: KColors.primary,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: KSizes.sm),
                      Divider(color: KColors.grey),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class UserIconWithAddButton extends StatelessWidget {
  const UserIconWithAddButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(KSizes.sm),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: KColors.grey,
            ),
          ),
          child: Icon(
            Iconsax.user,
            size: 80.sp,
            weight: 3,
          ),
        ),
        Positioned(
          bottom: 7,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: KColors.primary,
            ),
            child: Icon(
              Icons.add,
              color: KColors.white,
            ),
          ),
        )
      ],
    );
  }
}
