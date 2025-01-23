import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/alert_box/alert_box.dart';
import 'package:frontend/core/network/connectivity_checker.dart';
import 'package:frontend/core/utils/constants/colors.dart';
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
                  icon: Icon(Icons.bookmark_outline_outlined),
                  label: "${l10n.matched_jobs}",
                  activeIcon: Icon(Icons.bookmark),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.star_outline),
                  activeIcon: Icon(Icons.star),
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
    Container(
      color: Colors.red,
    ),
    Container(
      color: Colors.amber,
    ),
    Container(
      color: Colors.pink,
    ),
    Container(
      color: Colors.orange,
    ),
  ];
  int selectedIndex = 0;
  void onTap(index) {
    selectedIndex = index;
    notifyListeners();
  }
}
