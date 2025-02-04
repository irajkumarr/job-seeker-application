import 'package:frontend/core/network/connectivity_provider.dart';
import 'package:frontend/features/authentication/providers/details_provider.dart';
import 'package:frontend/features/authentication/providers/location_provider.dart';
import 'package:frontend/features/authentication/providers/login_provider.dart';
import 'package:frontend/features/authentication/providers/password_provider.dart';
import 'package:frontend/features/authentication/providers/signup_provider.dart';
import 'package:frontend/features/authentication/providers/timer_provider.dart';
import 'package:frontend/features/dashboard/providers/blog_provider.dart';
import 'package:frontend/features/dashboard/providers/category_provider.dart';
import 'package:frontend/features/dashboard/providers/job_application_provider.dart';
import 'package:frontend/features/dashboard/providers/job_provider.dart';
import 'package:frontend/features/dashboard/providers/matched_jobs_provider.dart';
import 'package:frontend/features/personalization/providers/contact_information_provider.dart';
import 'package:frontend/features/personalization/providers/document_provider.dart';
import 'package:frontend/features/personalization/providers/education_provider.dart';
import 'package:frontend/features/personalization/providers/experience_provider.dart';
import 'package:frontend/features/personalization/providers/other_information_provider.dart';
import 'package:frontend/features/personalization/providers/profile_provider.dart';
import 'package:frontend/features/personalization/providers/reference_provider.dart';
import 'package:frontend/features/dashboard/providers/saved_jobs_provider.dart';
import 'package:frontend/features/personalization/providers/social_account_provider.dart';
import 'package:frontend/features/personalization/providers/training_provider.dart';
import 'package:frontend/features/personalization/providers/user_language_provider.dart';
import 'package:frontend/l10n/language_provider.dart';
import 'package:frontend/navigation_menu.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AppProviders {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(
        create: (_) => LanguageProvider()..loadSavedLanguage()),
    ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
    ChangeNotifierProvider(create: (_) => NavigationProvider()),
    ChangeNotifierProvider(create: (_) => CategoryProvider()),
    ChangeNotifierProvider(create: (_) => JobProvider()),
    ChangeNotifierProvider(create: (_) => BlogProvider()),
    ChangeNotifierProvider(create: (_) => LoginProvider()),
    ChangeNotifierProvider(create: (_) => SignupProvider()),
    ChangeNotifierProvider(create: (_) => ProfileProvider()),
    ChangeNotifierProvider(create: (_) => LocationProvider()),
    ChangeNotifierProvider(create: (_) => DetailsProvider()),
    ChangeNotifierProvider(create: (_) => DocumentProvider()),
    ChangeNotifierProvider(create: (_) => SocialAccountProvider()),
    ChangeNotifierProvider(create: (_) => ContactInformationProvider()),
    ChangeNotifierProvider(create: (_) => ReferenceProvider()),
    ChangeNotifierProvider(create: (_) => UserLanguageProvider()),
    ChangeNotifierProvider(create: (_) => TrainingProvider()),
    ChangeNotifierProvider(create: (_) => EducationProvider()),
    ChangeNotifierProvider(create: (_) => ExperienceProvider()),
    ChangeNotifierProvider(create: (_) => OtherInformationProvider()),
    ChangeNotifierProvider(create: (_) => SavedJobsProvider()),
    ChangeNotifierProvider(create: (_) => MatchedJobsProvider()),
    ChangeNotifierProvider(create: (_) => JobApplicationProvider()),
    ChangeNotifierProvider(create: (_) => PasswordProvider()),
    ChangeNotifierProvider(create: (_) => ResendTimerProvider()),
  ];
}
