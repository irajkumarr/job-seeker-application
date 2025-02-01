import 'package:flutter/material.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/data/models/profile_detail_model.dart';
import 'package:frontend/features/authentication/screens/login/login.dart';
import 'package:frontend/features/authentication/screens/password_confimation/forgot_password.dart';
import 'package:frontend/features/authentication/screens/signup/personal_details_screen.dart';
import 'package:frontend/features/authentication/screens/signup/signup.dart';
import 'package:frontend/features/authentication/screens/signup/signup_password_screen.dart';
import 'package:frontend/features/authentication/screens/signup/signup_preferred_location_screen.dart';
import 'package:frontend/features/authentication/screens/signup/signup_preferred_screen.dart';
import 'package:frontend/features/authentication/screens/signup/signup_status_last_screen.dart';
import 'package:frontend/features/authentication/screens/signup/widgets/signup_form_completed_screen.dart';
import 'package:frontend/features/authentication/screens/splash/splash.dart';
import 'package:frontend/features/dashboard/screens/job_details/job_details_screen.dart';
import 'package:frontend/features/dashboard/widgets/employer_screen.dart';
import 'package:frontend/features/personalization/screens/profile/contact_information_screen.dart';
import 'package:frontend/features/personalization/screens/profile/document_screen.dart';
import 'package:frontend/features/personalization/screens/profile/education_screen.dart';
import 'package:frontend/features/personalization/screens/profile/language_screen.dart';
import 'package:frontend/features/personalization/screens/profile/profile_settings.dart';
import 'package:frontend/features/personalization/screens/profile/reference_screen.dart';
import 'package:frontend/features/personalization/screens/profile/social_account_screen.dart';
import 'package:frontend/features/personalization/screens/profile/training_screen.dart';
import 'package:frontend/navigation_menu.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppRoutes {
  final box = GetStorage();
  late GoRouter router = GoRouter(
    initialLocation: "/navigationMenu",
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        name: RoutesConstant.splash,
        path: "/",
        pageBuilder: (context, state) {
          return MaterialPage(
            child: SplashScreen(),
          );
        },
      ),
      GoRoute(
        name: RoutesConstant.navigationMenu,
        path: "/navigationMenu",
        pageBuilder: (context, state) {
          return MaterialPage(
            child: NavigationMenu(),
          );
        },
      ),
      GoRoute(
        name: RoutesConstant.jobDetails,
        path: "/jobDetails",
        pageBuilder: (context, state) {
          final jobId = state.extra as String;
          return MaterialPage(
            child: JobDetailsScreen(jobId: jobId),
          );
        },
      ),
      GoRoute(
        name: RoutesConstant.login,
        path: "/login",
        pageBuilder: (context, state) {
          return MaterialPage(
            child: LoginScreen(),
          );
        },
      ),
      GoRoute(
        name: RoutesConstant.signup,
        path: "/signup",
        pageBuilder: (context, state) {
          return MaterialPage(
            child: SignupScreen(),
          );
        },
      ),
      GoRoute(
        name: RoutesConstant.signupPassword,
        path: "/signupPassword",
        pageBuilder: (context, state) {
          final extraData = state.extra as Map<String, String>;
          final name = extraData["name"];
          final mobileNumber = extraData["mobileNumber"];
          return MaterialPage(
            child: SignupPasswordScreen(
              mobileNumber: mobileNumber!,
              name: name!,
            ),
          );
        },
      ),
      GoRoute(
        name: RoutesConstant.signupPreferred,
        path: "/signupPreferred",
        pageBuilder: (context, state) {
          return MaterialPage(
            child: SignupPreferredScreen(),
          );
        },
      ),
      GoRoute(
        name: RoutesConstant.signupPreferredLocation,
        path: "/signupPreferredLocation",
        pageBuilder: (context, state) {
          return MaterialPage(
            child: SignupPreferredLocationScreen(),
          );
        },
      ),
      GoRoute(
        name: RoutesConstant.personalDetails,
        path: "/personalDetails",
        pageBuilder: (context, state) {
          return MaterialPage(
            child: PersonalDetailsScreen(),
          );
        },
      ),
      GoRoute(
        name: RoutesConstant.statusDetails,
        path: "/statusDetails",
        pageBuilder: (context, state) {
          return MaterialPage(
            child: SignupStatusLastScreen(),
          );
        },
      ),
      GoRoute(
        name: RoutesConstant.signupFormCompleted,
        path: "/signupFormCompleted",
        pageBuilder: (context, state) {
          return MaterialPage(
            child: SignupFormCompletedScreen(),
          );
        },
      ),
      GoRoute(
        name: RoutesConstant.forgotPassword,
        path: "/forgotPassword",
        pageBuilder: (context, state) {
          return MaterialPage(
            child: ForgetPasswordScreen(),
          );
        },
      ),
      GoRoute(
        name: RoutesConstant.employer,
        path: "/employer",
        pageBuilder: (context, state) {
          return MaterialPage(
            child: EmployerScreen(),
          );
        },
      ),
      GoRoute(
        name: RoutesConstant.profileSettings,
        path: "/profileSettings",
        pageBuilder: (context, state) {
          return MaterialPage(
            child: ProfileSettingsScreen(),
          );
        },
      ),
      GoRoute(
        name: RoutesConstant.socialAccount,
        path: "/socialAccount",
        pageBuilder: (context, state) {
          final socialaccount = state.extra as Socialaccount?;
          return MaterialPage(
            child: SocialAccountScreen(socialaccount: socialaccount),
          );
        },
      ),
      GoRoute(
        name: RoutesConstant.language,
        path: "/language",
        pageBuilder: (context, state) {
          final language = state.extra as Language?;
          return MaterialPage(
            child: LanguageScreen(language: language),
          );
        },
      ),
      GoRoute(
        name: RoutesConstant.training,
        path: "/training",
        pageBuilder: (context, state) {
          return MaterialPage(
            child: TrainingScreen(),
          );
        },
      ),
      GoRoute(
        name: RoutesConstant.education,
        path: "/education",
        pageBuilder: (context, state) {
          return MaterialPage(
            child: EducationScreen(),
          );
        },
      ),
      GoRoute(
        name: RoutesConstant.reference,
        path: "/reference",
        pageBuilder: (context, state) {
          final reference = state.extra as Reference?;
          return MaterialPage(
            child: ReferenceScreen(reference: reference),
          );
        },
      ),
      GoRoute(
        name: RoutesConstant.document,
        path: "/document",
        pageBuilder: (context, state) {
          final document = state.extra as Document?;
          return MaterialPage(
            child: DocumentScreen(document: document),
          );
        },
      ),
      GoRoute(
        name: RoutesConstant.contactInformation,
        path: "/contactInformation",
        pageBuilder: (context, state) {
          final contact = state.extra as Emergencycontact?;
          return MaterialPage(
            child: ContactInformationScreen(
              contact: contact,
            ),
          );
        },
      ),
    ],
    errorPageBuilder: (context, state) {
      return MaterialPage(
        child: Scaffold(
          body: Center(
            child: Text("Route not found"),
          ),
        ),
      );
    },
  );
}
