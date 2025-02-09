import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/services/app_state.dart';
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
import 'package:frontend/features/dashboard/screens/filter/filter_screen.dart';
import 'package:frontend/features/dashboard/screens/job_details/job_details_screen.dart';
import 'package:frontend/features/dashboard/screens/search/search_screen.dart';
import 'package:frontend/features/dashboard/widgets/employer_screen.dart';
import 'package:frontend/features/personalization/screens/profile/contact_information_screen.dart';
import 'package:frontend/features/personalization/screens/profile/document_screen.dart';
import 'package:frontend/features/personalization/screens/profile/education_screen.dart';
import 'package:frontend/features/personalization/screens/profile/experience_screen.dart';
import 'package:frontend/features/personalization/screens/profile/language_screen.dart';
import 'package:frontend/features/personalization/screens/profile/other_information_screen.dart';
import 'package:frontend/features/personalization/screens/profile/profile_category.dart';
import 'package:frontend/features/personalization/screens/profile/profile_job_preference.dart';
import 'package:frontend/features/personalization/screens/profile/profile_personal_information.dart';
import 'package:frontend/features/personalization/screens/profile/profile_settings.dart';
import 'package:frontend/features/personalization/screens/profile/profile_skill.dart';
import 'package:frontend/features/personalization/screens/profile/reference_screen.dart';
import 'package:frontend/features/personalization/screens/profile/social_account_screen.dart';
import 'package:frontend/features/personalization/screens/profile/training_screen.dart';
import 'package:frontend/features/personalization/screens/profile/upload_profile_screen.dart';
import 'package:frontend/features/personalization/screens/profile/widgets/image_preview.dart';
import 'package:frontend/navigation_menu.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppRoutes {
  final box = GetStorage();
  late GoRouter router = GoRouter(
    initialLocation: "/",
    // initialLocation: "/navigationMenu",
    navigatorKey: navigatorKey,
    routes: [
      // GoRoute(
      //   name: RoutesConstant.splash,
      //   path: "/",
      //   pageBuilder: (context, state) {
      //     return MaterialPage(
      //       child: SplashScreen(),
      //     );
      //   },
      // ),
         GoRoute(
        path: '/',
        name: RoutesConstant.splash,
        builder: (context, state) => const SplashScreen(),
        redirect: (context, state) {
          if (AppStateService.isInitialized) {
            return '/navigationMenu';
          }
          return null;
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
          final training = state.extra as Training?;
          return MaterialPage(
            child: TrainingScreen(training: training),
          );
        },
      ),
      GoRoute(
        name: RoutesConstant.education,
        path: "/education",
        // pageBuilder: (context, state) {
        //   final extra = state.extra as Map<String, dynamic>;
        //   final education = extra["education"] as Education?;
        //   final isRemoved = extra["isRemoved"] as bool;
        //   return MaterialPage(
        //     child: EducationScreen(
        //       education: education,
        //       isRemoved: isRemoved,
        //     ),
        //   );
        // },
        pageBuilder: (context, state) {
          // Safely extract the 'extra' parameter, ensuring it's non-null and of the correct type
          final extra = state.extra as Map<String, dynamic>?;

          // Check if 'extra' is not null and contains the required keys
          if (extra != null) {
            final education = extra["education"] as Education?;
            final isRemoved = extra["isRemoved"] as bool? ??
                false; // Default to false if isRemoved is not provided

            return MaterialPage(
              child: EducationScreen(
                education: education,
                isRemoved: isRemoved,
              ),
            );
          } else {
            // Handle the case where 'extra' is null or not provided
            return MaterialPage(
              child: EducationScreen(
                education: null,
                isRemoved:
                    false, // Default to false if isRemoved is not provided
              ),
            );
          }
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
        name: RoutesConstant.experience,
        path: "/experience",
        pageBuilder: (context, state) {
          final experience = state.extra as Experience?;
          return MaterialPage(
            child: ExperienceScreen(experience: experience),
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
      GoRoute(
        name: RoutesConstant.uploadProfile,
        path: "/uploadProfile",
        pageBuilder: (context, state) {
          return MaterialPage(
            child: UploadProfileScreen(),
          );
        },
      ),
      GoRoute(
        name: RoutesConstant.profileCategory,
        path: "/profileCategory",
        pageBuilder: (context, state) {
          return MaterialPage(
            child: ProfileCategory(),
          );
        },
      ),
      GoRoute(
        name: RoutesConstant.profileSkill,
        path: "/profileSkill",
        pageBuilder: (context, state) {
          return MaterialPage(
            child: ProfileSkill(),
          );
        },
      ),
      GoRoute(
        name: RoutesConstant.profileJobPreference,
        path: "/profileJobPreference",
        pageBuilder: (context, state) {
          return MaterialPage(
            child: ProfileJobPreference(),
          );
        },
      ),
      GoRoute(
        name: RoutesConstant.profileOtherInformation,
        path: "/profileOtherInformation",
        pageBuilder: (context, state) {
          final otherInformation = state.extra as Otherinformation?;
          return MaterialPage(
            child: OtherInformationScreen(
              otherInformation: otherInformation,
            ),
          );
        },
      ),
      GoRoute(
        name: RoutesConstant.search,
        path: "/search",
        pageBuilder: (context, state) {
          return MaterialPage(
            child: SearchScreen(),
          );
        },
      ),
      GoRoute(
        name: RoutesConstant.filter,
        path: "/filter",
        pageBuilder: (context, state) {
          final bool isSearch = state.extra as bool;
          return MaterialPage(
            child: FilterScreen(
              isSearch: isSearch,
            ),
          );
        },
      ),
      GoRoute(
        name: RoutesConstant.profilePersonalInformation,
        path: "/profilePersonalInformation",
        pageBuilder: (context, state) {
          // final otherInformation = state.extra as Otherinformation?;
          return MaterialPage(
            child: ProfilePersonalInformation(
                // otherInformation: otherInformation,
                ),
          );
        },
      ),
      GoRoute(
        name: RoutesConstant.imagePreview,
        path: "/imagePreview",
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final file = extra['file'] as File?;
          final image = extra['image'] as String?;
          final isFile = extra['isFile'] as bool;
          return MaterialPage(
            child: ImagePreview(file: file, image: image, isFile: isFile),
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
