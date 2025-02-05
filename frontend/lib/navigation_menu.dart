import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/alert_box/alert_box.dart';
import 'package:frontend/core/network/connectivity_checker.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/image_strings.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/features/dashboard/screens/home/home.dart';
import 'package:frontend/features/dashboard/screens/jobs/saved_jobs.dart';
import 'package:frontend/features/dashboard/screens/status/status.dart';
import 'package:frontend/features/personalization/screens/profile/profile.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  final storage = GetStorage();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkToken();
    });
  }

  void checkToken() {
    Future.delayed(Duration(seconds: 1), () {
      String? token = storage.read("token");
      if (token == null || token.isEmpty) {
        return;
      }

      if (JwtDecoder.isExpired(token)) {
        storage.remove("token");
        showTokenExpiredDialog();
      }
    });
  }

  void showTokenExpiredDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("Session Expired"),
        content: Text("Your session has expired. Please log in again."),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (context) => LoginScreen()),
              // );
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final box = GetStorage();
    final String? profileImage = box.read("profileImage");
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
              // iconSize: 24,
              iconSize: 18,

              currentIndex: navigationProvider.selectedIndex,
              selectedItemColor: KColors.primary,
              unselectedItemColor: KColors.darkGrey,
              type: BottomNavigationBarType.fixed,
              selectedLabelStyle: TextStyle(
                color: KColors.primary,
                fontSize: 10,
                height: 2,
                fontWeight: FontWeight.w500,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 10,
                height: 2,
                fontWeight: FontWeight.w500,
              ),
              onTap: (value) {
                navigationProvider.onTap(value);
                // Provider.of<LoginProvider>(context, listen: false)
                //     .logout(context);
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
                    width: 18,
                    color: KColors.darkGrey,
                  ),
                  label: "${l10n.matched_jobs}",
                  // activeIcon: Icon(Icons.bookmark),
                  activeIcon: Image.asset(
                    KImages.bookmark,
                    width: 18,
                    color: KColors.primary,
                  ),
                ),
                BottomNavigationBarItem(
                  // icon: Icon(Icons.star_outline),
                  icon: Image.asset(
                    KImages.status,
                    width: 18,
                    color: KColors.darkGrey,
                  ),
                  // activeIcon: Icon(Icons.star),
                  activeIcon: Image.asset(
                    KImages.status,
                    width: 18,
                    color: KColors.primary,
                  ),
                  label: "${l10n.my_status}",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.user),
                  label: "${l10n.profile}",
                  activeIcon: Container(
                    padding: profileImage != null
                        ? EdgeInsets.all(0)
                        : EdgeInsets.all(KSizes.xs - 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: KColors.darkGrey,
                      ),
                    ),
                    child: profileImage != null
                        ? SizedBox(
                            height: 16.h,
                            width: 16.w,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(
                                profileImage,
                                height: 16.h,
                                width: 16.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Icon(
                            Iconsax.user,
                            size: 16.sp,
                            color: KColors.black,
                            weight: 3,
                          ),
                  ),
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
