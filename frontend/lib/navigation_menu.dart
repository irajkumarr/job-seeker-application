import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/alert_box/alert_box.dart';
import 'package:frontend/core/network/connectivity_checker.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/image_strings.dart';
import 'package:frontend/features/dashboard/screens/home/home.dart';
import 'package:frontend/features/dashboard/screens/jobs/saved_jobs.dart';
import 'package:frontend/features/dashboard/screens/status/status.dart';
import 'package:frontend/features/personalization/screens/profile/profile.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        return await CustomAlertBox.alertCloseApp(context);
      },
      child: ConnectivityChecker(
        child: Consumer<NavigationProvider>(
            builder: (context, navigationProvider, child) {
          return Scaffold(
            body: navigationProvider.screens
                .elementAt(navigationProvider.selectedIndex),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: KColors.white,
              elevation: 1,
              iconSize: 24,
              currentIndex: navigationProvider.selectedIndex,
              selectedItemColor: KColors.primary,
              unselectedItemColor: KColors.darkGrey,
              type: BottomNavigationBarType.fixed,
              selectedLabelStyle: TextStyle(
                color: KColors.primary,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
              onTap: (value) {
                navigationProvider.onTap(value);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.home_2),
                  label: "${l10n.home}",
                  activeIcon: Icon(Iconsax.home_25),
                ),
                BottomNavigationBarItem(
                  // icon: Icon(Icons.bookmark_outline_outlined),
                  icon: Image.asset(
                    KImages.bookmark,
                    width: 24,
                    color: KColors.darkGrey,
                  ),
                  label: "${l10n.matched_jobs}",
                  // activeIcon: Icon(Icons.bookmark),
                  activeIcon: Image.asset(
                    KImages.bookmark,
                    width: 24,
                    color: KColors.primary,
                  ),
                ),
                BottomNavigationBarItem(
                  // icon: Icon(Icons.star_outline),
                  icon: Image.asset(
                    KImages.status,
                    width: 24,
                    color: KColors.darkGrey,
                  ),
                  // activeIcon: Icon(Icons.star),
                  activeIcon: Image.asset(
                    KImages.status,
                    width: 24,
                    color: KColors.primary,
                  ),
                  label: "${l10n.my_status}",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.user),
                  label: "${l10n.profile}",
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class NavigationProvider with ChangeNotifier {
  List<Widget> screens = [
    HomeScreen(),
    SavedJobsScreen(),
    StatusScreen(),
    ProfileScreen(),
  ];
  int selectedIndex = 0;
  void onTap(index) {
    selectedIndex = index;
    notifyListeners();
  }
}
