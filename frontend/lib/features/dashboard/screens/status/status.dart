import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:frontend/features/dashboard/widgets/login_redirect.dart';
import 'package:frontend/features/dashboard/widgets/no_data_widget.dart';
import 'package:frontend/features/dashboard/widgets/status_and_saved_jobs_appbar.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:frontend/navigation_menu.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class StatusScreen extends StatefulWidget {
  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final box = GetStorage();
    final String? token = box.read("token");
    if (token == null) {
      return LoginRedirect(
        isMatchedJobs: false,
      );
    }
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(KDeviceUtils.getAppBarHeight()),
          child: StatusAndSavedJobsAppbar(
            appbarText: l10n.my_status,
          ),
        ),
        body: Column(
          children: [
            Container(
              color: KColors.white,
              padding: EdgeInsets.symmetric(vertical: KSizes.md),
              child: TabBar(
                indicatorColor: KColors.primary,
                labelColor: KColors.black,
                unselectedLabelColor: KColors.darkerGrey,
                dividerColor: Colors.transparent,
                dividerHeight: 1,
                indicatorSize: TabBarIndicatorSize.tab,
                labelPadding: EdgeInsets.zero,
                tabs: [
                  Tab(
                    height: 50.h,
                    child: Column(
                      children: [
                        Text(
                          "Jobs Applied",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        SizedBox(height: KSizes.xs),
                        Text(
                          "0",
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: KColors.primary,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    height: 50.h,
                    child: Column(
                      children: [
                        Text(
                          "Profile Visits",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        SizedBox(height: KSizes.xs),
                        Text(
                          "0",
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: KColors.primary,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Expanded TabBarView
            Expanded(
              child: TabBarView(
                children: [
                  NoDataWidget(
                    title: "No data available",
                    subTitle: "You haven't applied to any jobs.",
                    image: "assets/images/content/my_status_person.gif",
                    isButtonShowed: true,
                    buttonText: "Start Browsing Jobs",
                    onPressed: () {
                      context.read<NavigationProvider>().onTap(0);
                    },
                  ),
                  NoDataWidget(
                    title: "No data available",
                    subTitle: "No profile visitors yet",
                    image: "assets/images/content/my_status_person.gif",
                    isButtonShowed: false,
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
