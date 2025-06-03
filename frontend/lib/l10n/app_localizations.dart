import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ne.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ne')
  ];

  /// No description provided for @your_business_name.
  ///
  /// In en, this message translates to:
  /// **'Rojgari'**
  String get your_business_name;

  /// No description provided for @connection_to_api_server_failed.
  ///
  /// In en, this message translates to:
  /// **'Connection to API server failed due to internet connection'**
  String get connection_to_api_server_failed;

  /// No description provided for @select_language.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get select_language;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'Engligh'**
  String get english;

  /// No description provided for @shoppingList.
  ///
  /// In en, this message translates to:
  /// **'ShoppingList'**
  String get shoppingList;

  /// No description provided for @nepali.
  ///
  /// In en, this message translates to:
  /// **'Nepali'**
  String get nepali;

  /// No description provided for @select_a_language.
  ///
  /// In en, this message translates to:
  /// **'Select a language'**
  String get select_a_language;

  /// No description provided for @on_boarding_1_title.
  ///
  /// In en, this message translates to:
  /// **'Savor Savings 🍔'**
  String get on_boarding_1_title;

  /// No description provided for @on_boarding_2_title.
  ///
  /// In en, this message translates to:
  /// **'Seamless Transactions 💳'**
  String get on_boarding_2_title;

  /// No description provided for @on_boarding_3_title.
  ///
  /// In en, this message translates to:
  /// **'Speedy Satisfaction 🚀'**
  String get on_boarding_3_title;

  /// No description provided for @on_boarding_1_description.
  ///
  /// In en, this message translates to:
  /// **'Feast on fantastic deals! Explore Chulesi for unbeatable discounts on a variety of delicious foods!'**
  String get on_boarding_1_description;

  /// No description provided for @on_boarding_2_description.
  ///
  /// In en, this message translates to:
  /// **'Say goodbye to cash headaches! Chulesi offers hassle-free online payments for a smoother ordering experience. Just click, pay, and enjoy your meal!'**
  String get on_boarding_2_description;

  /// No description provided for @on_boarding_3_description.
  ///
  /// In en, this message translates to:
  /// **'Hungry? Don\'t wait around! With Chulesi\'s swift delivery service, your favorite foods are just moments away from your doorstep. Order now and taste the speed!'**
  String get on_boarding_3_description;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @preview_photo.
  ///
  /// In en, this message translates to:
  /// **'Preview Photo'**
  String get preview_photo;

  /// No description provided for @upload_photo.
  ///
  /// In en, this message translates to:
  /// **'Upload Photo'**
  String get upload_photo;

  /// No description provided for @camera_permission_denied.
  ///
  /// In en, this message translates to:
  /// **'Camera permission denied'**
  String get camera_permission_denied;

  /// No description provided for @upload_from_gallery.
  ///
  /// In en, this message translates to:
  /// **'Upload from Gallery'**
  String get upload_from_gallery;

  /// No description provided for @take_a_photo.
  ///
  /// In en, this message translates to:
  /// **'Take a Photo'**
  String get take_a_photo;

  /// No description provided for @profile_image_updated.
  ///
  /// In en, this message translates to:
  /// **'Profile Image Updated!'**
  String get profile_image_updated;

  /// No description provided for @choose_your_profile_photo.
  ///
  /// In en, this message translates to:
  /// **'Choose your profile photo to upload'**
  String get choose_your_profile_photo;

  /// No description provided for @upload_profile_photo.
  ///
  /// In en, this message translates to:
  /// **'Upload Profile Photo'**
  String get upload_profile_photo;

  /// No description provided for @nrs.
  ///
  /// In en, this message translates to:
  /// **'NRS.'**
  String get nrs;

  /// No description provided for @years.
  ///
  /// In en, this message translates to:
  /// **'years'**
  String get years;

  /// No description provided for @shift.
  ///
  /// In en, this message translates to:
  /// **'Shift'**
  String get shift;

  /// No description provided for @personal_information.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personal_information;

  /// No description provided for @applied_date.
  ///
  /// In en, this message translates to:
  /// **'Applied Date'**
  String get applied_date;

  /// No description provided for @profile_visits.
  ///
  /// In en, this message translates to:
  /// **'Profile Visits'**
  String get profile_visits;

  /// No description provided for @jobs_applied.
  ///
  /// In en, this message translates to:
  /// **'Jobs Applied'**
  String get jobs_applied;

  /// No description provided for @there_are_no_matched_jobs.
  ///
  /// In en, this message translates to:
  /// **'There are no matched jobs available for you at the moment.'**
  String get there_are_no_matched_jobs;

  /// No description provided for @clik_on_the_icon_to_bookmark.
  ///
  /// In en, this message translates to:
  /// **'Click on the icon ❤ to boomark or shortlist any jobs.'**
  String get clik_on_the_icon_to_bookmark;

  /// No description provided for @time_to_find_favourite_jobs.
  ///
  /// In en, this message translates to:
  /// **'It\'s time to find your favourite jobs!'**
  String get time_to_find_favourite_jobs;

  /// No description provided for @start_browsing_jobs.
  ///
  /// In en, this message translates to:
  /// **'Start Browsing Jobs'**
  String get start_browsing_jobs;

  /// No description provided for @no_data_available.
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get no_data_available;

  /// No description provided for @no_profile_visitors_yet.
  ///
  /// In en, this message translates to:
  /// **'No profile visitors yet.'**
  String get no_profile_visitors_yet;

  /// No description provided for @you_have_not_applied_to_any_jobs.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t applied to any jobs.'**
  String get you_have_not_applied_to_any_jobs;

  /// No description provided for @matched_jobs.
  ///
  /// In en, this message translates to:
  /// **'Matched jobs'**
  String get matched_jobs;

  /// No description provided for @job_details.
  ///
  /// In en, this message translates to:
  /// **'Job Details'**
  String get job_details;

  /// No description provided for @basic_information.
  ///
  /// In en, this message translates to:
  /// **'Basic Information'**
  String get basic_information;

  /// No description provided for @job_description.
  ///
  /// In en, this message translates to:
  /// **'Job Description'**
  String get job_description;

  /// No description provided for @apply_now.
  ///
  /// In en, this message translates to:
  /// **'Apply Now'**
  String get apply_now;

  /// No description provided for @responsibilities.
  ///
  /// In en, this message translates to:
  /// **'Responsibilities'**
  String get responsibilities;

  /// No description provided for @requirements.
  ///
  /// In en, this message translates to:
  /// **'Requirements'**
  String get requirements;

  /// No description provided for @benefits.
  ///
  /// In en, this message translates to:
  /// **'Benefits'**
  String get benefits;

  /// No description provided for @skills.
  ///
  /// In en, this message translates to:
  /// **'Skills'**
  String get skills;

  /// No description provided for @skill.
  ///
  /// In en, this message translates to:
  /// **'Skill'**
  String get skill;

  /// No description provided for @document.
  ///
  /// In en, this message translates to:
  /// **'Document'**
  String get document;

  /// No description provided for @social_account.
  ///
  /// In en, this message translates to:
  /// **'Social Account'**
  String get social_account;

  /// No description provided for @reference.
  ///
  /// In en, this message translates to:
  /// **'Reference'**
  String get reference;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @please_select_required_fields.
  ///
  /// In en, this message translates to:
  /// **'Please select required fields'**
  String get please_select_required_fields;

  /// No description provided for @nationality.
  ///
  /// In en, this message translates to:
  /// **'Nationality'**
  String get nationality;

  /// No description provided for @own_two_wheeler.
  ///
  /// In en, this message translates to:
  /// **'Do you own two-wheeler vehicle?'**
  String get own_two_wheeler;

  /// No description provided for @own_four_wheeler.
  ///
  /// In en, this message translates to:
  /// **'Do you own four-wheeler vehicle?'**
  String get own_four_wheeler;

  /// No description provided for @have_four_wheeler_license.
  ///
  /// In en, this message translates to:
  /// **'Do you have a four-wheeler driving license?'**
  String get have_four_wheeler_license;

  /// No description provided for @have_two_wheeler_license.
  ///
  /// In en, this message translates to:
  /// **'Do you have a two-wheeler riding license?'**
  String get have_two_wheeler_license;

  /// No description provided for @will_you_temporarily_relocate_during_job.
  ///
  /// In en, this message translates to:
  /// **'Are you willing to temporarily relocate outside of your residing location during the job period?'**
  String get will_you_temporarily_relocate_during_job;

  /// No description provided for @will_you_travel_outside_during_job.
  ///
  /// In en, this message translates to:
  /// **'Are you willing to travel outside of your residing location during the job?'**
  String get will_you_travel_outside_during_job;

  /// No description provided for @any_disablity.
  ///
  /// In en, this message translates to:
  /// **'Any Disability'**
  String get any_disablity;

  /// No description provided for @disablity.
  ///
  /// In en, this message translates to:
  /// **'Disability'**
  String get disablity;

  /// No description provided for @is_there_any_disability.
  ///
  /// In en, this message translates to:
  /// **'Is there any form of disability?'**
  String get is_there_any_disability;

  /// No description provided for @to_edit_other_info_set_your_job_preference.
  ///
  /// In en, this message translates to:
  /// **'To edit other information, you need to set your job preference first'**
  String get to_edit_other_info_set_your_job_preference;

  /// No description provided for @change_your_education_first.
  ///
  /// In en, this message translates to:
  /// **'You cannot add more education details with this qualification. Please change your education level first.'**
  String get change_your_education_first;

  /// No description provided for @religion.
  ///
  /// In en, this message translates to:
  /// **'Religion'**
  String get religion;

  /// No description provided for @province.
  ///
  /// In en, this message translates to:
  /// **'Province'**
  String get province;

  /// No description provided for @district.
  ///
  /// In en, this message translates to:
  /// **'District'**
  String get district;

  /// No description provided for @adddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get adddress;

  /// No description provided for @in_years.
  ///
  /// In en, this message translates to:
  /// **'in years'**
  String get in_years;

  /// No description provided for @choose_upload_recognizable_photo.
  ///
  /// In en, this message translates to:
  /// **'Choose and upload a clearly recognizable photo'**
  String get choose_upload_recognizable_photo;

  /// No description provided for @upload_your_profile_photo.
  ///
  /// In en, this message translates to:
  /// **'Upload your profile photo'**
  String get upload_your_profile_photo;

  /// No description provided for @mobile_correct.
  ///
  /// In en, this message translates to:
  /// **'Is this mobile number correct?'**
  String get mobile_correct;

  /// No description provided for @you_are_all_set_to_apply.
  ///
  /// In en, this message translates to:
  /// **'You are all set to apply for the jobs.'**
  String get you_are_all_set_to_apply;

  /// No description provided for @signup_form_completed.
  ///
  /// In en, this message translates to:
  /// **'Successfully Completed Signup Forms'**
  String get signup_form_completed;

  /// No description provided for @profile_creation_failed.
  ///
  /// In en, this message translates to:
  /// **'Profile creation failed'**
  String get profile_creation_failed;

  /// No description provided for @profile_created.
  ///
  /// In en, this message translates to:
  /// **'Profile created!, Now you can apply for Jobs.'**
  String get profile_created;

  /// No description provided for @education_qualification.
  ///
  /// In en, this message translates to:
  /// **'Education Qualification'**
  String get education_qualification;

  /// No description provided for @have_you_been_to_foreign_employment.
  ///
  /// In en, this message translates to:
  /// **'Have you been to foreign employement?'**
  String get have_you_been_to_foreign_employment;

  /// No description provided for @municipality.
  ///
  /// In en, this message translates to:
  /// **'Municipality/VDC'**
  String get municipality;

  /// No description provided for @fill_in_your_complete_details.
  ///
  /// In en, this message translates to:
  /// **'Fill your complete details'**
  String get fill_in_your_complete_details;

  /// No description provided for @fill_in_your_personal_details.
  ///
  /// In en, this message translates to:
  /// **'Fill in your personal details'**
  String get fill_in_your_personal_details;

  /// No description provided for @marital_status.
  ///
  /// In en, this message translates to:
  /// **'Marital Status'**
  String get marital_status;

  /// No description provided for @full_name.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get full_name;

  /// No description provided for @search_category.
  ///
  /// In en, this message translates to:
  /// **'Search Category'**
  String get search_category;

  /// No description provided for @where_are_you_looking_for_work.
  ///
  /// In en, this message translates to:
  /// **'Where are you looking for work?'**
  String get where_are_you_looking_for_work;

  /// No description provided for @what_skills_do_you_have.
  ///
  /// In en, this message translates to:
  /// **'What skills do you have'**
  String get what_skills_do_you_have;

  /// No description provided for @select_location_by_priority.
  ///
  /// In en, this message translates to:
  /// **'Select a location by priority'**
  String get select_location_by_priority;

  /// No description provided for @select_preferred_category.
  ///
  /// In en, this message translates to:
  /// **'Select Preferred Category'**
  String get select_preferred_category;

  /// No description provided for @search_skill.
  ///
  /// In en, this message translates to:
  /// **'Search Skill'**
  String get search_skill;

  /// No description provided for @choose_five_jobs_of_your_choice.
  ///
  /// In en, this message translates to:
  /// **'Choose up to five jobs of your choice.'**
  String get choose_five_jobs_of_your_choice;

  /// No description provided for @expected_salary.
  ///
  /// In en, this message translates to:
  /// **'Expected Salary'**
  String get expected_salary;

  /// No description provided for @current_salary.
  ///
  /// In en, this message translates to:
  /// **'Current Salary'**
  String get current_salary;

  /// No description provided for @career_objectives.
  ///
  /// In en, this message translates to:
  /// **'Career Objectives'**
  String get career_objectives;

  /// No description provided for @other_information.
  ///
  /// In en, this message translates to:
  /// **'Other Information'**
  String get other_information;

  /// No description provided for @preferred_shift.
  ///
  /// In en, this message translates to:
  /// **'Preferred Shift'**
  String get preferred_shift;

  /// No description provided for @working_status.
  ///
  /// In en, this message translates to:
  /// **'Working Status'**
  String get working_status;

  /// No description provided for @max_limit_reached.
  ///
  /// In en, this message translates to:
  /// **'Max limit reached'**
  String get max_limit_reached;

  /// No description provided for @choose_five_skills_you_have.
  ///
  /// In en, this message translates to:
  /// **'Choose five skills you have.'**
  String get choose_five_skills_you_have;

  /// No description provided for @please_select_at_least_one_category.
  ///
  /// In en, this message translates to:
  /// **'Please select at least one category'**
  String get please_select_at_least_one_category;

  /// No description provided for @available_for.
  ///
  /// In en, this message translates to:
  /// **'Available for'**
  String get available_for;

  /// No description provided for @preferred_job_location.
  ///
  /// In en, this message translates to:
  /// **'Preferred Job Location'**
  String get preferred_job_location;

  /// No description provided for @salary.
  ///
  /// In en, this message translates to:
  /// **'Salary'**
  String get salary;

  /// No description provided for @work_experience.
  ///
  /// In en, this message translates to:
  /// **'Work Experience'**
  String get work_experience;

  /// No description provided for @job_preference.
  ///
  /// In en, this message translates to:
  /// **'Job Preference'**
  String get job_preference;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// No description provided for @training.
  ///
  /// In en, this message translates to:
  /// **'Training'**
  String get training;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @total_views.
  ///
  /// In en, this message translates to:
  /// **'Total Views'**
  String get total_views;

  /// No description provided for @register_using_name_and_number.
  ///
  /// In en, this message translates to:
  /// **'Register using your name and mobile number'**
  String get register_using_name_and_number;

  /// No description provided for @alert_close_app.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to exit from the Rojgari app?'**
  String get alert_close_app;

  /// No description provided for @press_yes.
  ///
  /// In en, this message translates to:
  /// **'Press \'Yes\' to exit from the app'**
  String get press_yes;

  /// No description provided for @are_you_new_to_the_app.
  ///
  /// In en, this message translates to:
  /// **'Are you new to the Rojgari app?'**
  String get are_you_new_to_the_app;

  /// No description provided for @enter_registered_number.
  ///
  /// In en, this message translates to:
  /// **'Please enter your registered mobile number and password to log in.'**
  String get enter_registered_number;

  /// No description provided for @customize_your_language_setting.
  ///
  /// In en, this message translates to:
  /// **'Customize your language setting on Rojgari.'**
  String get customize_your_language_setting;

  /// No description provided for @education.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get education;

  /// No description provided for @experience.
  ///
  /// In en, this message translates to:
  /// **'Experience'**
  String get experience;

  /// No description provided for @job_level.
  ///
  /// In en, this message translates to:
  /// **'Job Level'**
  String get job_level;

  /// No description provided for @job_type.
  ///
  /// In en, this message translates to:
  /// **'Job Type'**
  String get job_type;

  /// No description provided for @no_of_vacancy.
  ///
  /// In en, this message translates to:
  /// **'No.Of Vacancy'**
  String get no_of_vacancy;

  /// No description provided for @personal_qualities.
  ///
  /// In en, this message translates to:
  /// **'Personal Qualities'**
  String get personal_qualities;

  /// No description provided for @freshers_are_enrouged_to_apply.
  ///
  /// In en, this message translates to:
  /// **'Note: Freshers are encouraged to apply'**
  String get freshers_are_enrouged_to_apply;

  /// No description provided for @discover_and_apply_to_jobs.
  ///
  /// In en, this message translates to:
  /// **'Discover and apply to Jobs for'**
  String get discover_and_apply_to_jobs;

  /// No description provided for @more_than_people_found_jobs.
  ///
  /// In en, this message translates to:
  /// **'More than 12,000 people have found jobs through the Rojgari app.'**
  String get more_than_people_found_jobs;

  /// No description provided for @en.
  ///
  /// In en, this message translates to:
  /// **'EN'**
  String get en;

  /// No description provided for @ne.
  ///
  /// In en, this message translates to:
  /// **'ne'**
  String get ne;

  /// No description provided for @lang.
  ///
  /// In en, this message translates to:
  /// **'EN'**
  String get lang;

  /// No description provided for @my_status.
  ///
  /// In en, this message translates to:
  /// **'My Status'**
  String get my_status;

  /// No description provided for @employer_zone.
  ///
  /// In en, this message translates to:
  /// **'Employer Zone'**
  String get employer_zone;

  /// No description provided for @training_lists.
  ///
  /// In en, this message translates to:
  /// **'Training Lists'**
  String get training_lists;

  /// No description provided for @contact_us.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contact_us;

  /// No description provided for @priorities.
  ///
  /// In en, this message translates to:
  /// **'Priorities'**
  String get priorities;

  /// No description provided for @change_your_priorities.
  ///
  /// In en, this message translates to:
  /// **'Change your priorities'**
  String get change_your_priorities;

  /// No description provided for @read_terms_and_conditions.
  ///
  /// In en, this message translates to:
  /// **'Read the terms and conditions on Rojgari'**
  String get read_terms_and_conditions;

  /// No description provided for @community_standards_legal_policies.
  ///
  /// In en, this message translates to:
  /// **'Community Standards and legal policies'**
  String get community_standards_legal_policies;

  /// No description provided for @search_jobs.
  ///
  /// In en, this message translates to:
  /// **'Search jobs'**
  String get search_jobs;

  /// No description provided for @jobs.
  ///
  /// In en, this message translates to:
  /// **'Jobs'**
  String get jobs;

  /// No description provided for @job.
  ///
  /// In en, this message translates to:
  /// **'Job'**
  String get job;

  /// No description provided for @saved_jobs.
  ///
  /// In en, this message translates to:
  /// **'Saved Jobs'**
  String get saved_jobs;

  /// No description provided for @join_rojgari_today.
  ///
  /// In en, this message translates to:
  /// **'Join Rojgari Today'**
  String get join_rojgari_today;

  /// No description provided for @join_rojgari.
  ///
  /// In en, this message translates to:
  /// **'Join Rojgari'**
  String get join_rojgari;

  /// No description provided for @unlock_new_opportunities_on_rojgari.
  ///
  /// In en, this message translates to:
  /// **'Unlock new opportunities and find your dream job by joining the Rojgari platform today. Take a step toward a brighter future!'**
  String get unlock_new_opportunities_on_rojgari;

  /// No description provided for @expiry_date.
  ///
  /// In en, this message translates to:
  /// **'Expiry date'**
  String get expiry_date;

  /// No description provided for @quick_links.
  ///
  /// In en, this message translates to:
  /// **'Quick Links'**
  String get quick_links;

  /// No description provided for @check_out_our_new_blogs_post.
  ///
  /// In en, this message translates to:
  /// **'Check out our new blog posts.'**
  String get check_out_our_new_blogs_post;

  /// No description provided for @blogs.
  ///
  /// In en, this message translates to:
  /// **'Blogs'**
  String get blogs;

  /// No description provided for @employment_for_women.
  ///
  /// In en, this message translates to:
  /// **'Employment for Women'**
  String get employment_for_women;

  /// No description provided for @jobs_without_experience.
  ///
  /// In en, this message translates to:
  /// **'Jobs Without Experience'**
  String get jobs_without_experience;

  /// No description provided for @urgent_jobs.
  ///
  /// In en, this message translates to:
  /// **'Urgent jobs'**
  String get urgent_jobs;

  /// No description provided for @click_on_the_link_below.
  ///
  /// In en, this message translates to:
  /// **'Click on the link below to get the fastest job!'**
  String get click_on_the_link_below;

  /// No description provided for @where_do_you_want_to_work.
  ///
  /// In en, this message translates to:
  /// **'Where do you want to work?'**
  String get where_do_you_want_to_work;

  /// No description provided for @what_kind_of_job_do_you_want.
  ///
  /// In en, this message translates to:
  /// **'What kind of job do you want?'**
  String get what_kind_of_job_do_you_want;

  /// No description provided for @get_started.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get get_started;

  /// No description provided for @sign_in.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get sign_in;

  /// No description provided for @sign_up.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get sign_up;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'E-mail'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirm_password;

  /// No description provided for @remember_me.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get remember_me;

  /// No description provided for @forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgot_password;

  /// No description provided for @first_name.
  ///
  /// In en, this message translates to:
  /// **'Enter Full Name'**
  String get first_name;

  /// No description provided for @last_name.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get last_name;

  /// No description provided for @mobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get mobileNumber;

  /// No description provided for @your_account.
  ///
  /// In en, this message translates to:
  /// **'Your Account'**
  String get your_account;

  /// No description provided for @buy_again.
  ///
  /// In en, this message translates to:
  /// **'Buy Again'**
  String get buy_again;

  /// No description provided for @enter_your_first_name.
  ///
  /// In en, this message translates to:
  /// **'Enter your first name'**
  String get enter_your_first_name;

  /// No description provided for @enter_your_last_name.
  ///
  /// In en, this message translates to:
  /// **'Enter your last name'**
  String get enter_your_last_name;

  /// No description provided for @enter_email_address.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address'**
  String get enter_email_address;

  /// No description provided for @enter_a_valid_email_address.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get enter_a_valid_email_address;

  /// No description provided for @enter_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get enter_phone_number;

  /// No description provided for @invalid_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number. Please enter your phone number without country code'**
  String get invalid_phone_number;

  /// No description provided for @enter_password.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enter_password;

  /// No description provided for @confirm_password_does_not_matched.
  ///
  /// In en, this message translates to:
  /// **'Confirmed password doesn\'t matched'**
  String get confirm_password_does_not_matched;

  /// No description provided for @password_should_be.
  ///
  /// In en, this message translates to:
  /// **'Password should be greater than 6 characters'**
  String get password_should_be;

  /// No description provided for @otp_verification.
  ///
  /// In en, this message translates to:
  /// **'OTP Verification'**
  String get otp_verification;

  /// No description provided for @enter_the_verification_sent_to.
  ///
  /// In en, this message translates to:
  /// **'Enter the verification code (OTP) sent to'**
  String get enter_the_verification_sent_to;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @did_not_receive_the_code.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive the code?'**
  String get did_not_receive_the_code;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @verified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get verified;

  /// No description provided for @find_restaurants_and_foods.
  ///
  /// In en, this message translates to:
  /// **'Find Restaurants and Foods Near You'**
  String get find_restaurants_and_foods;

  /// No description provided for @by_allowing_location_access.
  ///
  /// In en, this message translates to:
  /// **'By allowing location access, you can search for restaurants and foods near you and receive more accurate delivery.'**
  String get by_allowing_location_access;

  /// No description provided for @user_current_location.
  ///
  /// In en, this message translates to:
  /// **'Use Current Location'**
  String get user_current_location;

  /// No description provided for @set_from_map.
  ///
  /// In en, this message translates to:
  /// **'Set From Map'**
  String get set_from_map;

  /// No description provided for @you_can_change_language.
  ///
  /// In en, this message translates to:
  /// **'*You can change language later from menu bar'**
  String get you_can_change_language;

  /// No description provided for @resend_code_successful.
  ///
  /// In en, this message translates to:
  /// **'Resend code successful'**
  String get resend_code_successful;

  /// No description provided for @pick_an_address.
  ///
  /// In en, this message translates to:
  /// **'Pick an address'**
  String get pick_an_address;

  /// No description provided for @choose_your_interests.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Interests'**
  String get choose_your_interests;

  /// No description provided for @get_personalized_recommendations.
  ///
  /// In en, this message translates to:
  /// **'Get personalized food recommendations'**
  String get get_personalized_recommendations;

  /// No description provided for @search_food_or_restaurant.
  ///
  /// In en, this message translates to:
  /// **'Search your desired foods or restaurants'**
  String get search_food_or_restaurant;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @find_your_desired_food_by_categories.
  ///
  /// In en, this message translates to:
  /// **'Find your desired food by categories'**
  String get find_your_desired_food_by_categories;

  /// No description provided for @popular_foods_nearby.
  ///
  /// In en, this message translates to:
  /// **'Popular Foods Nearby'**
  String get popular_foods_nearby;

  /// No description provided for @restaurants.
  ///
  /// In en, this message translates to:
  /// **'Restaurants'**
  String get restaurants;

  /// No description provided for @all_restaurants.
  ///
  /// In en, this message translates to:
  /// **'All Restaurants'**
  String get all_restaurants;

  /// No description provided for @please_enter_mobile.
  ///
  /// In en, this message translates to:
  /// **'Please enter your registered Mobile Number so that we can help you to recover your password.'**
  String get please_enter_mobile;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @enter_new_password.
  ///
  /// In en, this message translates to:
  /// **'Enter your new password and confirm.'**
  String get enter_new_password;

  /// No description provided for @new_password.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get new_password;

  /// No description provided for @reset_password.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get reset_password;

  /// No description provided for @name_of_institute.
  ///
  /// In en, this message translates to:
  /// **'Name of Institute'**
  String get name_of_institute;

  /// No description provided for @currently_studying.
  ///
  /// In en, this message translates to:
  /// **'Currently studying?'**
  String get currently_studying;

  /// No description provided for @education_program.
  ///
  /// In en, this message translates to:
  /// **'Education Program'**
  String get education_program;

  /// No description provided for @web_address_cannot_be_empty.
  ///
  /// In en, this message translates to:
  /// **'Web Address cannot be empty'**
  String get web_address_cannot_be_empty;

  /// No description provided for @web_address.
  ///
  /// In en, this message translates to:
  /// **'Web Address'**
  String get web_address;

  /// No description provided for @training_name.
  ///
  /// In en, this message translates to:
  /// **'Training Name'**
  String get training_name;

  /// No description provided for @no_results_found.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get no_results_found;

  /// No description provided for @your_search_returned_no_results.
  ///
  /// In en, this message translates to:
  /// **'Your search returned no results'**
  String get your_search_returned_no_results;

  /// No description provided for @select_job_level.
  ///
  /// In en, this message translates to:
  /// **'Please select a job level'**
  String get select_job_level;

  /// No description provided for @try_remove_filter.
  ///
  /// In en, this message translates to:
  /// **'Try removing filters or rephrasing your search'**
  String get try_remove_filter;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// No description provided for @edit_search.
  ///
  /// In en, this message translates to:
  /// **'Edit Search'**
  String get edit_search;

  /// No description provided for @all_filters.
  ///
  /// In en, this message translates to:
  /// **'All Filters'**
  String get all_filters;

  /// No description provided for @job_location.
  ///
  /// In en, this message translates to:
  /// **'Job Location'**
  String get job_location;

  /// No description provided for @clear_filters.
  ///
  /// In en, this message translates to:
  /// **'Clear filters'**
  String get clear_filters;

  /// No description provided for @easy_filter.
  ///
  /// In en, this message translates to:
  /// **'Select the preferred job filters to make the job search easy and quick.'**
  String get easy_filter;

  /// No description provided for @industry.
  ///
  /// In en, this message translates to:
  /// **'Industry'**
  String get industry;

  /// No description provided for @started_date.
  ///
  /// In en, this message translates to:
  /// **'Started Date'**
  String get started_date;

  /// No description provided for @job_category.
  ///
  /// In en, this message translates to:
  /// **'Job Category'**
  String get job_category;

  /// No description provided for @hint_text_professional_goal.
  ///
  /// In en, this message translates to:
  /// **'Write a brief summary of your professional goals to enhance the possibility of getting employment.'**
  String get hint_text_professional_goal;

  /// No description provided for @roles_and_responsiblity.
  ///
  /// In en, this message translates to:
  /// **'Roles and Responsibilities'**
  String get roles_and_responsiblity;

  /// No description provided for @are_you_currently_working.
  ///
  /// In en, this message translates to:
  /// **'Are you currently working here?'**
  String get are_you_currently_working;

  /// No description provided for @duration_type.
  ///
  /// In en, this message translates to:
  /// **'Duration Type'**
  String get duration_type;

  /// No description provided for @completion_year.
  ///
  /// In en, this message translates to:
  /// **'Completion Year'**
  String get completion_year;

  /// No description provided for @designation.
  ///
  /// In en, this message translates to:
  /// **'Designation'**
  String get designation;

  /// No description provided for @organization_name.
  ///
  /// In en, this message translates to:
  /// **'Organization Name'**
  String get organization_name;

  /// No description provided for @started_year.
  ///
  /// In en, this message translates to:
  /// **'Started Year'**
  String get started_year;

  /// No description provided for @education_board.
  ///
  /// In en, this message translates to:
  /// **'Education Board'**
  String get education_board;

  /// No description provided for @select_social_media.
  ///
  /// In en, this message translates to:
  /// **'Please select a social media platform'**
  String get select_social_media;

  /// No description provided for @relation.
  ///
  /// In en, this message translates to:
  /// **'Relation'**
  String get relation;

  /// No description provided for @social_media.
  ///
  /// In en, this message translates to:
  /// **'Social Media'**
  String get social_media;

  /// No description provided for @select_grade_type.
  ///
  /// In en, this message translates to:
  /// **'Please select a grade type'**
  String get select_grade_type;

  /// No description provided for @please_enter_marks.
  ///
  /// In en, this message translates to:
  /// **'Please enter marks'**
  String get please_enter_marks;

  /// No description provided for @grade_type.
  ///
  /// In en, this message translates to:
  /// **'Grade Type'**
  String get grade_type;

  /// No description provided for @score.
  ///
  /// In en, this message translates to:
  /// **'Score'**
  String get score;

  /// No description provided for @marks_secured.
  ///
  /// In en, this message translates to:
  /// **'Marks Secured'**
  String get marks_secured;

  /// No description provided for @percentage_must_be.
  ///
  /// In en, this message translates to:
  /// **'Percentage must be between 0 and 100'**
  String get percentage_must_be;

  /// No description provided for @cgpa_must_be.
  ///
  /// In en, this message translates to:
  /// **'CGPA must be between 0 and 4'**
  String get cgpa_must_be;

  /// No description provided for @please_enter_valid_number.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid number'**
  String get please_enter_valid_number;

  /// No description provided for @graduation_year.
  ///
  /// In en, this message translates to:
  /// **'Graduation Year'**
  String get graduation_year;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @add_education.
  ///
  /// In en, this message translates to:
  /// **'Add Education'**
  String get add_education;

  /// No description provided for @add_document_category.
  ///
  /// In en, this message translates to:
  /// **'Add Document Category'**
  String get add_document_category;

  /// No description provided for @select_education_qualification.
  ///
  /// In en, this message translates to:
  /// **'Please select an education qualification'**
  String get select_education_qualification;

  /// No description provided for @number_type.
  ///
  /// In en, this message translates to:
  /// **'Number Type'**
  String get number_type;

  /// No description provided for @select_document_category.
  ///
  /// In en, this message translates to:
  /// **'Please select a document category'**
  String get select_document_category;

  /// No description provided for @upload_document.
  ///
  /// In en, this message translates to:
  /// **'Please upload a document'**
  String get upload_document;

  /// No description provided for @failed_to_pick_document.
  ///
  /// In en, this message translates to:
  /// **'Failed to pick document'**
  String get failed_to_pick_document;

  /// No description provided for @contact_person_full_name.
  ///
  /// In en, this message translates to:
  /// **'Contact Person Full Name'**
  String get contact_person_full_name;

  /// No description provided for @thank_you.
  ///
  /// In en, this message translates to:
  /// **'Thankyou!!!'**
  String get thank_you;

  /// No description provided for @please_select_relation.
  ///
  /// In en, this message translates to:
  /// **'Please select a relation'**
  String get please_select_relation;

  /// No description provided for @you_have_applied_for_the_job.
  ///
  /// In en, this message translates to:
  /// **'You have successfully applied for the job'**
  String get you_have_applied_for_the_job;

  /// No description provided for @unsaved_changes.
  ///
  /// In en, this message translates to:
  /// **'Unsaved Changes'**
  String get unsaved_changes;

  /// No description provided for @session_expired.
  ///
  /// In en, this message translates to:
  /// **'Session Expired'**
  String get session_expired;

  /// No description provided for @your_sessio_has_expired.
  ///
  /// In en, this message translates to:
  /// **'Your session has expired. Please log in again.'**
  String get your_sessio_has_expired;

  /// No description provided for @press_yes_to_apply.
  ///
  /// In en, this message translates to:
  /// **'Press \'Yes\' to apply for the job'**
  String get press_yes_to_apply;

  /// No description provided for @are_you_sure_to_apply_job.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to apply for this job?'**
  String get are_you_sure_to_apply_job;

  /// No description provided for @you_have_unsaved_changes.
  ///
  /// In en, this message translates to:
  /// **'You have unsaved changes. Do you want to leave without saving?'**
  String get you_have_unsaved_changes;

  /// No description provided for @you_will_not_be_able_to_recover.
  ///
  /// In en, this message translates to:
  /// **'You won\'t be able to recover it after you delete it'**
  String get you_will_not_be_able_to_recover;

  /// No description provided for @do_you_want_to_delete_this.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete this?'**
  String get do_you_want_to_delete_this;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'Order History'**
  String get history;

  /// No description provided for @clear_all.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get clear_all;

  /// No description provided for @suggestions.
  ///
  /// In en, this message translates to:
  /// **'Suggestions'**
  String get suggestions;

  /// No description provided for @item_name.
  ///
  /// In en, this message translates to:
  /// **'Item Name'**
  String get item_name;

  /// No description provided for @approximately.
  ///
  /// In en, this message translates to:
  /// **'Approximately'**
  String get approximately;

  /// No description provided for @results.
  ///
  /// In en, this message translates to:
  /// **'results'**
  String get results;

  /// No description provided for @food.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get food;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @sort_by.
  ///
  /// In en, this message translates to:
  /// **'Sort by'**
  String get sort_by;

  /// No description provided for @nearest.
  ///
  /// In en, this message translates to:
  /// **'Nearest'**
  String get nearest;

  /// No description provided for @rating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating;

  /// No description provided for @popularity.
  ///
  /// In en, this message translates to:
  /// **'Popularity'**
  String get popularity;

  /// No description provided for @delivery_charge.
  ///
  /// In en, this message translates to:
  /// **'Delivery Charge'**
  String get delivery_charge;

  /// No description provided for @filter_by.
  ///
  /// In en, this message translates to:
  /// **'Filter by'**
  String get filter_by;

  /// No description provided for @currently_available_foods.
  ///
  /// In en, this message translates to:
  /// **'Currently Available Foods'**
  String get currently_available_foods;

  /// No description provided for @discounted_foods.
  ///
  /// In en, this message translates to:
  /// **'Discounted Foods'**
  String get discounted_foods;

  /// No description provided for @offer.
  ///
  /// In en, this message translates to:
  /// **'Offer'**
  String get offer;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @apply_filters.
  ///
  /// In en, this message translates to:
  /// **'Apply Filters'**
  String get apply_filters;

  /// No description provided for @daily_time.
  ///
  /// In en, this message translates to:
  /// **'Daily time'**
  String get daily_time;

  /// No description provided for @free_delivery.
  ///
  /// In en, this message translates to:
  /// **'Free Delivery'**
  String get free_delivery;

  /// No description provided for @min.
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get min;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @addons.
  ///
  /// In en, this message translates to:
  /// **'Addons'**
  String get addons;

  /// No description provided for @total_amount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get total_amount;

  /// No description provided for @add_to_cart.
  ///
  /// In en, this message translates to:
  /// **'Add To Cart'**
  String get add_to_cart;

  /// No description provided for @item_added_to_cart.
  ///
  /// In en, this message translates to:
  /// **'Item added to cart'**
  String get item_added_to_cart;

  /// No description provided for @already_added_in_cart.
  ///
  /// In en, this message translates to:
  /// **'Already Added in Cart'**
  String get already_added_in_cart;

  /// No description provided for @out_of_stock.
  ///
  /// In en, this message translates to:
  /// **'Out of Stock'**
  String get out_of_stock;

  /// No description provided for @my_cart.
  ///
  /// In en, this message translates to:
  /// **'My Cart'**
  String get my_cart;

  /// No description provided for @removed_from_cart.
  ///
  /// In en, this message translates to:
  /// **'Removed from cart'**
  String get removed_from_cart;

  /// No description provided for @enter_promo_code.
  ///
  /// In en, this message translates to:
  /// **'Enter Promo Code'**
  String get enter_promo_code;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @delivery_type.
  ///
  /// In en, this message translates to:
  /// **'Delivery Type'**
  String get delivery_type;

  /// No description provided for @home_delivery.
  ///
  /// In en, this message translates to:
  /// **'Home Delivery'**
  String get home_delivery;

  /// No description provided for @take_away.
  ///
  /// In en, this message translates to:
  /// **'Take Away'**
  String get take_away;

  /// No description provided for @item_price.
  ///
  /// In en, this message translates to:
  /// **'Item Price'**
  String get item_price;

  /// No description provided for @vat_tax.
  ///
  /// In en, this message translates to:
  /// **'Vat/Tax'**
  String get vat_tax;

  /// No description provided for @subtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// No description provided for @discount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get discount;

  /// No description provided for @coupon_discount.
  ///
  /// In en, this message translates to:
  /// **'Coupon Discount'**
  String get coupon_discount;

  /// No description provided for @delivery_fee.
  ///
  /// In en, this message translates to:
  /// **'Delivery Fee'**
  String get delivery_fee;

  /// No description provided for @deliver_to.
  ///
  /// In en, this message translates to:
  /// **'Deliver To'**
  String get deliver_to;

  /// No description provided for @place_order.
  ///
  /// In en, this message translates to:
  /// **'Place Order'**
  String get place_order;

  /// No description provided for @favorite.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get favorite;

  /// No description provided for @my_orders.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get my_orders;

  /// No description provided for @running.
  ///
  /// In en, this message translates to:
  /// **'Running Order'**
  String get running;

  /// No description provided for @order_id.
  ///
  /// In en, this message translates to:
  /// **'Order ID'**
  String get order_id;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @track_order.
  ///
  /// In en, this message translates to:
  /// **'Track Order'**
  String get track_order;

  /// No description provided for @re_order.
  ///
  /// In en, this message translates to:
  /// **'Re-Order'**
  String get re_order;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @coupon.
  ///
  /// In en, this message translates to:
  /// **'Coupon'**
  String get coupon;

  /// No description provided for @privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacy_policy;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @about_us.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get about_us;

  /// No description provided for @terms_conditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get terms_conditions;

  /// No description provided for @help_support.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get help_support;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @type_here.
  ///
  /// In en, this message translates to:
  /// **'Type here.....'**
  String get type_here;

  /// No description provided for @available.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get available;

  /// No description provided for @used.
  ///
  /// In en, this message translates to:
  /// **'Used'**
  String get used;

  /// No description provided for @valid_until.
  ///
  /// In en, this message translates to:
  /// **'Valid until'**
  String get valid_until;

  /// No description provided for @are_you_sure_to_logout.
  ///
  /// In en, this message translates to:
  /// **'Are you sure want to logout?'**
  String get are_you_sure_to_logout;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @notification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notification;

  /// No description provided for @guest_mode.
  ///
  /// In en, this message translates to:
  /// **'Guest Mode'**
  String get guest_mode;

  /// No description provided for @now_you_are_in_guest_mode.
  ///
  /// In en, this message translates to:
  /// **'Now you are in guest mode.Please login to enjoy the more awesome features.'**
  String get now_you_are_in_guest_mode;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @change_something_to_update.
  ///
  /// In en, this message translates to:
  /// **'Change something to update'**
  String get change_something_to_update;

  /// No description provided for @view_all.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get view_all;

  /// No description provided for @oops.
  ///
  /// In en, this message translates to:
  /// **'Oops!'**
  String get oops;

  /// No description provided for @sorry.
  ///
  /// In en, this message translates to:
  /// **'Sorry!'**
  String get sorry;

  /// No description provided for @cart_is_empty.
  ///
  /// In en, this message translates to:
  /// **'Your cart is empty'**
  String get cart_is_empty;

  /// No description provided for @no_data_found.
  ///
  /// In en, this message translates to:
  /// **'No data found'**
  String get no_data_found;

  /// No description provided for @you_are_not_logged_in.
  ///
  /// In en, this message translates to:
  /// **'You are not logged in'**
  String get you_are_not_logged_in;

  /// No description provided for @login_to_continue.
  ///
  /// In en, this message translates to:
  /// **'Login to Continue'**
  String get login_to_continue;

  /// No description provided for @trending_food_offers.
  ///
  /// In en, this message translates to:
  /// **'Trending Food Offers'**
  String get trending_food_offers;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @off.
  ///
  /// In en, this message translates to:
  /// **'OFF'**
  String get off;

  /// No description provided for @enjoy.
  ///
  /// In en, this message translates to:
  /// **'Enjoy'**
  String get enjoy;

  /// No description provided for @off_on_all_categories.
  ///
  /// In en, this message translates to:
  /// **'off on all categories'**
  String get off_on_all_categories;

  /// No description provided for @set_location.
  ///
  /// In en, this message translates to:
  /// **'Set Location'**
  String get set_location;

  /// No description provided for @search_address_here.
  ///
  /// In en, this message translates to:
  /// **'Search address here'**
  String get search_address_here;

  /// No description provided for @my_address.
  ///
  /// In en, this message translates to:
  /// **'My Address'**
  String get my_address;

  /// No description provided for @saved_address.
  ///
  /// In en, this message translates to:
  /// **'Saved Address'**
  String get saved_address;

  /// No description provided for @add_new_address.
  ///
  /// In en, this message translates to:
  /// **'Add New Address'**
  String get add_new_address;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @office.
  ///
  /// In en, this message translates to:
  /// **'Office'**
  String get office;

  /// No description provided for @others.
  ///
  /// In en, this message translates to:
  /// **'Your Current Location'**
  String get others;

  /// No description provided for @delivery_address.
  ///
  /// In en, this message translates to:
  /// **'Delivery Address'**
  String get delivery_address;

  /// No description provided for @add_the_location_correctly.
  ///
  /// In en, this message translates to:
  /// **'Add the location Correctly'**
  String get add_the_location_correctly;

  /// No description provided for @contact_person_name.
  ///
  /// In en, this message translates to:
  /// **'Contact Person Name'**
  String get contact_person_name;

  /// No description provided for @contact_person_number.
  ///
  /// In en, this message translates to:
  /// **'Contact Person Number'**
  String get contact_person_number;

  /// No description provided for @label_as.
  ///
  /// In en, this message translates to:
  /// **'Label As'**
  String get label_as;

  /// No description provided for @save_location.
  ///
  /// In en, this message translates to:
  /// **'Save Location'**
  String get save_location;

  /// No description provided for @pick_address.
  ///
  /// In en, this message translates to:
  /// **'Pick Address'**
  String get pick_address;

  /// No description provided for @are_you_sure_to_reset.
  ///
  /// In en, this message translates to:
  /// **'Are you sure want to reset?'**
  String get are_you_sure_to_reset;

  /// No description provided for @if_you_change_location.
  ///
  /// In en, this message translates to:
  /// **'You have some foods in your cart. If you change your location, your cart and other data related to your current delivery location will be reset.'**
  String get if_you_change_location;

  /// No description provided for @if_you_continue.
  ///
  /// In en, this message translates to:
  /// **'You have food from another restaurant in cart. If you continue, your all previous food from cart will be removed.'**
  String get if_you_continue;

  /// No description provided for @yes_and_continue.
  ///
  /// In en, this message translates to:
  /// **'Yes and Continue'**
  String get yes_and_continue;

  /// No description provided for @total_order.
  ///
  /// In en, this message translates to:
  /// **'Total Order'**
  String get total_order;

  /// No description provided for @dark_theme.
  ///
  /// In en, this message translates to:
  /// **'Dark Theme'**
  String get dark_theme;

  /// No description provided for @change_password.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get change_password;

  /// No description provided for @edit_profile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get edit_profile;

  /// No description provided for @quick_contact.
  ///
  /// In en, this message translates to:
  /// **'QUICK CONTACT'**
  String get quick_contact;

  /// No description provided for @enter_message.
  ///
  /// In en, this message translates to:
  /// **'Enter message'**
  String get enter_message;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @checkout.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkout;

  /// No description provided for @preference_time.
  ///
  /// In en, this message translates to:
  /// **'Schedule Time'**
  String get preference_time;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @tomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get tomorrow;

  /// No description provided for @now.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get now;

  /// No description provided for @delivery_to.
  ///
  /// In en, this message translates to:
  /// **'Delivery To'**
  String get delivery_to;

  /// No description provided for @confirm_order.
  ///
  /// In en, this message translates to:
  /// **'Confirm Order'**
  String get confirm_order;

  /// No description provided for @proceed_to_checkout.
  ///
  /// In en, this message translates to:
  /// **'Proceed to Checkout'**
  String get proceed_to_checkout;

  /// No description provided for @you_placed_the_order_successfully.
  ///
  /// In en, this message translates to:
  /// **'You Place The Order Successfully'**
  String get you_placed_the_order_successfully;

  /// No description provided for @your_order_is_failed_to_place.
  ///
  /// In en, this message translates to:
  /// **'Your Order is Failed to Place'**
  String get your_order_is_failed_to_place;

  /// No description provided for @your_order_is_failed_to_place_because.
  ///
  /// In en, this message translates to:
  /// **'Your order is failed to place because your payment got failed. Please make sure a successful payment to place an order.'**
  String get your_order_is_failed_to_place_because;

  /// No description provided for @your_order_is_placed_successfully.
  ///
  /// In en, this message translates to:
  /// **'Your order is placed successfully. We start our delivery process and you will receive your food soon.'**
  String get your_order_is_placed_successfully;

  /// No description provided for @order_racking.
  ///
  /// In en, this message translates to:
  /// **'Order Tracking'**
  String get order_racking;

  /// No description provided for @delivery_man.
  ///
  /// In en, this message translates to:
  /// **'Delivery Man'**
  String get delivery_man;

  /// No description provided for @order_placed.
  ///
  /// In en, this message translates to:
  /// **'Order Placed'**
  String get order_placed;

  /// No description provided for @order_confirmed.
  ///
  /// In en, this message translates to:
  /// **'Order Confirmed'**
  String get order_confirmed;

  /// No description provided for @preparing_food.
  ///
  /// In en, this message translates to:
  /// **'Preparing Food'**
  String get preparing_food;

  /// No description provided for @food_on_the_way.
  ///
  /// In en, this message translates to:
  /// **'Food on the way'**
  String get food_on_the_way;

  /// No description provided for @view_on_map.
  ///
  /// In en, this message translates to:
  /// **'View on Map'**
  String get view_on_map;

  /// No description provided for @back_to_home.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get back_to_home;

  /// No description provided for @trip_route.
  ///
  /// In en, this message translates to:
  /// **'Trip Route'**
  String get trip_route;

  /// No description provided for @call.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get call;

  /// No description provided for @order_details.
  ///
  /// In en, this message translates to:
  /// **'Order Details'**
  String get order_details;

  /// No description provided for @rate_and_review.
  ///
  /// In en, this message translates to:
  /// **'Rate & Review'**
  String get rate_and_review;

  /// No description provided for @rate_the_food.
  ///
  /// In en, this message translates to:
  /// **'Rate the Food'**
  String get rate_the_food;

  /// No description provided for @rate_the_delivery_man.
  ///
  /// In en, this message translates to:
  /// **'Rate the Delivery Man'**
  String get rate_the_delivery_man;

  /// No description provided for @share_your_opinion.
  ///
  /// In en, this message translates to:
  /// **'Share Your Opinion'**
  String get share_your_opinion;

  /// No description provided for @write_your_review_here.
  ///
  /// In en, this message translates to:
  /// **'Write your review here....'**
  String get write_your_review_here;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @verification_code.
  ///
  /// In en, this message translates to:
  /// **'Verification Code'**
  String get verification_code;

  /// No description provided for @item.
  ///
  /// In en, this message translates to:
  /// **'Item'**
  String get item;

  /// No description provided for @review_now.
  ///
  /// In en, this message translates to:
  /// **'Review Now'**
  String get review_now;

  /// No description provided for @digital_payment.
  ///
  /// In en, this message translates to:
  /// **'Digital Payment'**
  String get digital_payment;

  /// No description provided for @cash_on_delivery.
  ///
  /// In en, this message translates to:
  /// **'Cash on Delivery'**
  String get cash_on_delivery;

  /// No description provided for @faster_and_safe_way.
  ///
  /// In en, this message translates to:
  /// **'Faster and safer way to send money'**
  String get faster_and_safe_way;

  /// No description provided for @pay_your_payment_after_getting_food.
  ///
  /// In en, this message translates to:
  /// **'Pay your payment after getting food'**
  String get pay_your_payment_after_getting_food;

  /// No description provided for @update_in_cart.
  ///
  /// In en, this message translates to:
  /// **'Update In Cart'**
  String get update_in_cart;

  /// No description provided for @not_available_now_break.
  ///
  /// In en, this message translates to:
  /// **'Not Available Now'**
  String get not_available_now_break;

  /// No description provided for @not_available_now.
  ///
  /// In en, this message translates to:
  /// **'Not Available Now'**
  String get not_available_now;

  /// No description provided for @available_will_be.
  ///
  /// In en, this message translates to:
  /// **'Available will be'**
  String get available_will_be;

  /// No description provided for @one_or_more_product_unavailable.
  ///
  /// In en, this message translates to:
  /// **'One or more products in your cart are not available at this time'**
  String get one_or_more_product_unavailable;

  /// No description provided for @enter_a_coupon_code.
  ///
  /// In en, this message translates to:
  /// **'Enter a coupon code'**
  String get enter_a_coupon_code;

  /// No description provided for @invalid_code_or.
  ///
  /// In en, this message translates to:
  /// **'Invalid code or failed to get discount'**
  String get invalid_code_or;

  /// No description provided for @choose_payment_method.
  ///
  /// In en, this message translates to:
  /// **'Choose Payment Method'**
  String get choose_payment_method;

  /// No description provided for @no_slot_available.
  ///
  /// In en, this message translates to:
  /// **'No slots are available'**
  String get no_slot_available;

  /// No description provided for @select_a_time.
  ///
  /// In en, this message translates to:
  /// **'Select a time'**
  String get select_a_time;

  /// No description provided for @free.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get free;

  /// No description provided for @delivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get delivery;

  /// No description provided for @campaign_schedule.
  ///
  /// In en, this message translates to:
  /// **'Campaign Schedule'**
  String get campaign_schedule;

  /// No description provided for @order_amount.
  ///
  /// In en, this message translates to:
  /// **'Order Amount'**
  String get order_amount;

  /// No description provided for @one_or_more_products_are_not_available_for_this_selected_time.
  ///
  /// In en, this message translates to:
  /// **'One or more products are not available for this selected time'**
  String get one_or_more_products_are_not_available_for_this_selected_time;

  /// No description provided for @item_campaigns.
  ///
  /// In en, this message translates to:
  /// **'Item Campaigns'**
  String get item_campaigns;

  /// No description provided for @basic_campaigns.
  ///
  /// In en, this message translates to:
  /// **'Basic Campaigns'**
  String get basic_campaigns;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @enter_your_name.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get enter_your_name;

  /// No description provided for @enter_your_message.
  ///
  /// In en, this message translates to:
  /// **'Enter your message'**
  String get enter_your_message;

  /// No description provided for @email_us.
  ///
  /// In en, this message translates to:
  /// **'Email Us'**
  String get email_us;

  /// No description provided for @since_joining.
  ///
  /// In en, this message translates to:
  /// **'Since Joining'**
  String get since_joining;

  /// No description provided for @dark_mode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get dark_mode;

  /// No description provided for @guest.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get guest;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get days;

  /// No description provided for @order_now.
  ///
  /// In en, this message translates to:
  /// **'Order Now'**
  String get order_now;

  /// No description provided for @cancel_order.
  ///
  /// In en, this message translates to:
  /// **'Cancel Order'**
  String get cancel_order;

  /// No description provided for @order_cancelled.
  ///
  /// In en, this message translates to:
  /// **'Order Cancelled'**
  String get order_cancelled;

  /// No description provided for @ordered_at.
  ///
  /// In en, this message translates to:
  /// **'Ordered at'**
  String get ordered_at;

  /// No description provided for @paid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paid;

  /// No description provided for @unpaid.
  ///
  /// In en, this message translates to:
  /// **'Unpaid'**
  String get unpaid;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @accepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get accepted;

  /// No description provided for @processing.
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get processing;

  /// No description provided for @confirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get confirmed;

  /// No description provided for @handover.
  ///
  /// In en, this message translates to:
  /// **'Handover'**
  String get handover;

  /// No description provided for @picked_up.
  ///
  /// In en, this message translates to:
  /// **'Out For Delivery'**
  String get picked_up;

  /// No description provided for @delivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get delivered;

  /// No description provided for @refund_requested.
  ///
  /// In en, this message translates to:
  /// **'Refund Requested'**
  String get refund_requested;

  /// No description provided for @refunded.
  ///
  /// In en, this message translates to:
  /// **'Refunded'**
  String get refunded;

  /// No description provided for @returned.
  ///
  /// In en, this message translates to:
  /// **'Returned'**
  String get returned;

  /// No description provided for @failed.
  ///
  /// In en, this message translates to:
  /// **'Payment Failed'**
  String get failed;

  /// No description provided for @canceled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get canceled;

  /// No description provided for @delivered_at.
  ///
  /// In en, this message translates to:
  /// **'Delivered at'**
  String get delivered_at;

  /// No description provided for @payment_info.
  ///
  /// In en, this message translates to:
  /// **'Payment Info'**
  String get payment_info;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @method.
  ///
  /// In en, this message translates to:
  /// **'Method'**
  String get method;

  /// No description provided for @review.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get review;

  /// No description provided for @submitted.
  ///
  /// In en, this message translates to:
  /// **'Submitted'**
  String get submitted;

  /// No description provided for @give_a_rating.
  ///
  /// In en, this message translates to:
  /// **'Give a rating'**
  String get give_a_rating;

  /// No description provided for @write_a_review.
  ///
  /// In en, this message translates to:
  /// **'Write a review'**
  String get write_a_review;

  /// No description provided for @rate_his_service.
  ///
  /// In en, this message translates to:
  /// **'Rate His Service'**
  String get rate_his_service;

  /// No description provided for @rate_review.
  ///
  /// In en, this message translates to:
  /// **'Rate & Review'**
  String get rate_review;

  /// No description provided for @items.
  ///
  /// In en, this message translates to:
  /// **'Items'**
  String get items;

  /// No description provided for @you_can_not_reorder_a_campaign.
  ///
  /// In en, this message translates to:
  /// **'You can not reorder a campaign'**
  String get you_can_not_reorder_a_campaign;

  /// No description provided for @reorder.
  ///
  /// In en, this message translates to:
  /// **'Re-order'**
  String get reorder;

  /// No description provided for @order_tracking.
  ///
  /// In en, this message translates to:
  /// **'Current Order Tracking'**
  String get order_tracking;

  /// No description provided for @closed_now.
  ///
  /// In en, this message translates to:
  /// **'Closed Now'**
  String get closed_now;

  /// No description provided for @purchaseHistory.
  ///
  /// In en, this message translates to:
  /// **'Purchase History'**
  String get purchaseHistory;

  /// No description provided for @are_you_sure_to_cancel.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel this order?'**
  String get are_you_sure_to_cancel;

  /// No description provided for @if_you_exit_from_payment.
  ///
  /// In en, this message translates to:
  /// **'If you exit from this payment process then your order will be failed.'**
  String get if_you_exit_from_payment;

  /// No description provided for @favourite.
  ///
  /// In en, this message translates to:
  /// **'Favourite'**
  String get favourite;

  /// No description provided for @menu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menu;

  /// No description provided for @continue_as.
  ///
  /// In en, this message translates to:
  /// **'Continue as'**
  String get continue_as;

  /// No description provided for @save_and_continue.
  ///
  /// In en, this message translates to:
  /// **'Save & Continue'**
  String get save_and_continue;

  /// No description provided for @pick_location.
  ///
  /// In en, this message translates to:
  /// **'Pick Location'**
  String get pick_location;

  /// No description provided for @ascending.
  ///
  /// In en, this message translates to:
  /// **'Ascending (A-Z)'**
  String get ascending;

  /// No description provided for @descending.
  ///
  /// In en, this message translates to:
  /// **'Descending (Z-A)'**
  String get descending;

  /// No description provided for @minimum_purchase.
  ///
  /// In en, this message translates to:
  /// **'Minimum Purchase'**
  String get minimum_purchase;

  /// No description provided for @maximum_discount.
  ///
  /// In en, this message translates to:
  /// **'Maximum Discount'**
  String get maximum_discount;

  /// No description provided for @minimum_order_amount_is.
  ///
  /// In en, this message translates to:
  /// **'Minimum order amount is'**
  String get minimum_order_amount_is;

  /// No description provided for @you_got_discount_of.
  ///
  /// In en, this message translates to:
  /// **'You got discount of'**
  String get you_got_discount_of;

  /// No description provided for @are_you_agree_with_this_order_fail.
  ///
  /// In en, this message translates to:
  /// **'Are you agree with this order fail?'**
  String get are_you_agree_with_this_order_fail;

  /// No description provided for @if_you_do_not_pay.
  ///
  /// In en, this message translates to:
  /// **'If you do not continue with your order payment system then your order will be failed. You can switch your order to Cash On Delivery now.'**
  String get if_you_do_not_pay;

  /// No description provided for @continue_with_order_fail.
  ///
  /// In en, this message translates to:
  /// **'Continue with Order Fail'**
  String get continue_with_order_fail;

  /// No description provided for @switch_to_cash_on_delivery.
  ///
  /// In en, this message translates to:
  /// **'Switch to COD'**
  String get switch_to_cash_on_delivery;

  /// No description provided for @results_found.
  ///
  /// In en, this message translates to:
  /// **'results found'**
  String get results_found;

  /// No description provided for @additional_note.
  ///
  /// In en, this message translates to:
  /// **'Additional Note/Cake Message'**
  String get additional_note;

  /// No description provided for @no_suggestions_available.
  ///
  /// In en, this message translates to:
  /// **'No suggestions available'**
  String get no_suggestions_available;

  /// No description provided for @delivery_verification_code.
  ///
  /// In en, this message translates to:
  /// **'Delivery Verification Code'**
  String get delivery_verification_code;

  /// No description provided for @variations.
  ///
  /// In en, this message translates to:
  /// **'Variations'**
  String get variations;

  /// No description provided for @restaurant_details.
  ///
  /// In en, this message translates to:
  /// **'Restaurant Details'**
  String get restaurant_details;

  /// No description provided for @direction.
  ///
  /// In en, this message translates to:
  /// **'Direction'**
  String get direction;

  /// No description provided for @restaurant_is_closed_now.
  ///
  /// In en, this message translates to:
  /// **'Restaurant is closed now'**
  String get restaurant_is_closed_now;

  /// No description provided for @km.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get km;

  /// No description provided for @restaurant.
  ///
  /// In en, this message translates to:
  /// **'Restaurant'**
  String get restaurant;

  /// No description provided for @back_press_again_to_exit.
  ///
  /// In en, this message translates to:
  /// **'Back press again to exit'**
  String get back_press_again_to_exit;

  /// No description provided for @no_saved_address_found.
  ///
  /// In en, this message translates to:
  /// **'No saved address found'**
  String get no_saved_address_found;

  /// No description provided for @no_category_food_found.
  ///
  /// In en, this message translates to:
  /// **'No category food found'**
  String get no_category_food_found;

  /// No description provided for @no_category_found.
  ///
  /// In en, this message translates to:
  /// **'No category found'**
  String get no_category_found;

  /// No description provided for @no_coupon_found.
  ///
  /// In en, this message translates to:
  /// **'No coupon found'**
  String get no_coupon_found;

  /// No description provided for @no_wish_data_found.
  ///
  /// In en, this message translates to:
  /// **'No favourite data found'**
  String get no_wish_data_found;

  /// No description provided for @no_campaign_found.
  ///
  /// In en, this message translates to:
  /// **'No campaign found'**
  String get no_campaign_found;

  /// No description provided for @no_food_available.
  ///
  /// In en, this message translates to:
  /// **'No food available'**
  String get no_food_available;

  /// No description provided for @no_restaurant_available.
  ///
  /// In en, this message translates to:
  /// **'No restaurant available'**
  String get no_restaurant_available;

  /// No description provided for @no_notification_found.
  ///
  /// In en, this message translates to:
  /// **'No notification found'**
  String get no_notification_found;

  /// No description provided for @no_order_found.
  ///
  /// In en, this message translates to:
  /// **'No order found'**
  String get no_order_found;

  /// No description provided for @update_now.
  ///
  /// In en, this message translates to:
  /// **'Update Now'**
  String get update_now;

  /// No description provided for @your_app_is_deprecated.
  ///
  /// In en, this message translates to:
  /// **'The app you using is deprecated. A newer version of this app is available. Please update your app.'**
  String get your_app_is_deprecated;

  /// No description provided for @can_not_launch.
  ///
  /// In en, this message translates to:
  /// **'Can\'t launch'**
  String get can_not_launch;

  /// No description provided for @i_agree_with.
  ///
  /// In en, this message translates to:
  /// **'I agree with'**
  String get i_agree_with;

  /// No description provided for @service_not_available_in_this_area.
  ///
  /// In en, this message translates to:
  /// **'Service not available in this area'**
  String get service_not_available_in_this_area;

  /// No description provided for @you_have_to_allow.
  ///
  /// In en, this message translates to:
  /// **'You have to allow location permission to use your location'**
  String get you_have_to_allow;

  /// No description provided for @you_denied_location_permission.
  ///
  /// In en, this message translates to:
  /// **'You denied location permission forever. Please allow location permission from your app settings and receive more accurate delivery.'**
  String get you_denied_location_permission;

  /// No description provided for @view_cart.
  ///
  /// In en, this message translates to:
  /// **'View Cart'**
  String get view_cart;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @service_not_available_in_current_location.
  ///
  /// In en, this message translates to:
  /// **'Service not available in your current location'**
  String get service_not_available_in_current_location;

  /// No description provided for @currently_opened_restaurants.
  ///
  /// In en, this message translates to:
  /// **'Currently Opened Restaurants'**
  String get currently_opened_restaurants;

  /// No description provided for @discounted_restaurants.
  ///
  /// In en, this message translates to:
  /// **'Discounted Restaurants'**
  String get discounted_restaurants;

  /// No description provided for @the_minimum_item_purchase_amount_for_this_coupon_is.
  ///
  /// In en, this message translates to:
  /// **'The minimum purchase amount for this coupon is'**
  String get the_minimum_item_purchase_amount_for_this_coupon_is;

  /// No description provided for @but_you_have.
  ///
  /// In en, this message translates to:
  /// **'but you have'**
  String get but_you_have;

  /// No description provided for @non_changeable.
  ///
  /// In en, this message translates to:
  /// **'Non changeable'**
  String get non_changeable;

  /// No description provided for @delivery_man_not_assigned.
  ///
  /// In en, this message translates to:
  /// **'Delivery man has not been assigned yet'**
  String get delivery_man_not_assigned;

  /// No description provided for @payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// No description provided for @scheduled_at.
  ///
  /// In en, this message translates to:
  /// **'Scheduled at'**
  String get scheduled_at;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @unable_to_launch_google_map.
  ///
  /// In en, this message translates to:
  /// **'Unable to launch google map'**
  String get unable_to_launch_google_map;

  /// No description provided for @connected.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get connected;

  /// No description provided for @no_connection.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get no_connection;

  /// No description provided for @ready_for_handover.
  ///
  /// In en, this message translates to:
  /// **'Ready for handover'**
  String get ready_for_handover;

  /// No description provided for @for_demo_purpose.
  ///
  /// In en, this message translates to:
  /// **'For demo purpose please use 1234 as OTP'**
  String get for_demo_purpose;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @we_are_under_maintenance.
  ///
  /// In en, this message translates to:
  /// **'We Are Under Maintenance'**
  String get we_are_under_maintenance;

  /// No description provided for @we_will_be_right_back.
  ///
  /// In en, this message translates to:
  /// **'We Will Be Right Back'**
  String get we_will_be_right_back;

  /// No description provided for @are_you_sure_to_switch.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to switch this order to Cash On Delivery?'**
  String get are_you_sure_to_switch;

  /// No description provided for @search_location.
  ///
  /// In en, this message translates to:
  /// **'Search Location'**
  String get search_location;

  /// No description provided for @profile_updated_successfully.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get profile_updated_successfully;

  /// No description provided for @password_updated_successfully.
  ///
  /// In en, this message translates to:
  /// **'Password updated successfully'**
  String get password_updated_successfully;

  /// No description provided for @new_address_added_successfully.
  ///
  /// In en, this message translates to:
  /// **'New address added successfully'**
  String get new_address_added_successfully;

  /// No description provided for @restaurant_reviews.
  ///
  /// In en, this message translates to:
  /// **'Restaurant Reviews'**
  String get restaurant_reviews;

  /// No description provided for @popular_restaurants.
  ///
  /// In en, this message translates to:
  /// **'Popular Restaurants'**
  String get popular_restaurants;

  /// No description provided for @new_on.
  ///
  /// In en, this message translates to:
  /// **'New on'**
  String get new_on;

  /// No description provided for @restaurant_is_closed.
  ///
  /// In en, this message translates to:
  /// **'Restaurant is closed'**
  String get restaurant_is_closed;

  /// No description provided for @id.
  ///
  /// In en, this message translates to:
  /// **'ID'**
  String get id;

  /// No description provided for @no_review_found.
  ///
  /// In en, this message translates to:
  /// **'No review found'**
  String get no_review_found;

  /// No description provided for @delivery_time.
  ///
  /// In en, this message translates to:
  /// **'Delivery Time'**
  String get delivery_time;

  /// No description provided for @minimum_order.
  ///
  /// In en, this message translates to:
  /// **'Minimum Order'**
  String get minimum_order;

  /// No description provided for @best_reviewed_food.
  ///
  /// In en, this message translates to:
  /// **'Best Reviewed food'**
  String get best_reviewed_food;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @no_internet_connection.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get no_internet_connection;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @update_address.
  ///
  /// In en, this message translates to:
  /// **'Update Address'**
  String get update_address;

  /// No description provided for @add_new.
  ///
  /// In en, this message translates to:
  /// **'Add New'**
  String get add_new;

  /// No description provided for @your_selected_location_is_from_different_zone.
  ///
  /// In en, this message translates to:
  /// **'Your selected location is out of coverage for this restaurant'**
  String get your_selected_location_is_from_different_zone;

  /// No description provided for @veg.
  ///
  /// In en, this message translates to:
  /// **'Veg'**
  String get veg;

  /// No description provided for @non_veg.
  ///
  /// In en, this message translates to:
  /// **'Non-Veg'**
  String get non_veg;

  /// No description provided for @no_category_restaurant_found.
  ///
  /// In en, this message translates to:
  /// **'No category restaurant found'**
  String get no_category_restaurant_found;

  /// No description provided for @social_login.
  ///
  /// In en, this message translates to:
  /// **'Social Login'**
  String get social_login;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @restaurant_wise.
  ///
  /// In en, this message translates to:
  /// **'Restaurant Wise'**
  String get restaurant_wise;

  /// No description provided for @zone_wise.
  ///
  /// In en, this message translates to:
  /// **'Zone Wise'**
  String get zone_wise;

  /// No description provided for @default_name.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get default_name;

  /// No description provided for @min_purchase.
  ///
  /// In en, this message translates to:
  /// **'Min Purchase'**
  String get min_purchase;

  /// No description provided for @max_discount.
  ///
  /// In en, this message translates to:
  /// **'Max Discount'**
  String get max_discount;

  /// No description provided for @coupon_code_copied.
  ///
  /// In en, this message translates to:
  /// **'Coupon code copied'**
  String get coupon_code_copied;

  /// No description provided for @join_as_a_delivery_man.
  ///
  /// In en, this message translates to:
  /// **'Join as a Delivery Man'**
  String get join_as_a_delivery_man;

  /// No description provided for @join_as_a_restaurant.
  ///
  /// In en, this message translates to:
  /// **'Join as a Restaurant'**
  String get join_as_a_restaurant;

  /// No description provided for @are_you_sure_want_to_delete_address.
  ///
  /// In en, this message translates to:
  /// **'Are you sure want to delete address'**
  String get are_you_sure_want_to_delete_address;

  /// No description provided for @join_us.
  ///
  /// In en, this message translates to:
  /// **'Join Us'**
  String get join_us;

  /// No description provided for @calculating.
  ///
  /// In en, this message translates to:
  /// **'Calculating'**
  String get calculating;

  /// No description provided for @delivery_fee_not_set_yet.
  ///
  /// In en, this message translates to:
  /// **'Delivery fee not set yet'**
  String get delivery_fee_not_set_yet;

  /// No description provided for @first_order.
  ///
  /// In en, this message translates to:
  /// **'First Order'**
  String get first_order;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @no_payment_method_is_enabled.
  ///
  /// In en, this message translates to:
  /// **'No payment method is enabled'**
  String get no_payment_method_is_enabled;

  /// No description provided for @ratings.
  ///
  /// In en, this message translates to:
  /// **'ratings'**
  String get ratings;

  /// No description provided for @wallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get wallet;

  /// No description provided for @convert_to_currency.
  ///
  /// In en, this message translates to:
  /// **'Convert to currency'**
  String get convert_to_currency;

  /// No description provided for @add_amount.
  ///
  /// In en, this message translates to:
  /// **'Add Amount'**
  String get add_amount;

  /// No description provided for @loyalty_points.
  ///
  /// In en, this message translates to:
  /// **'Loyalty Points'**
  String get loyalty_points;

  /// No description provided for @loyalty_point.
  ///
  /// In en, this message translates to:
  /// **'Loyalty Point'**
  String get loyalty_point;

  /// No description provided for @enter_points.
  ///
  /// In en, this message translates to:
  /// **'Enter points..'**
  String get enter_points;

  /// No description provided for @wallet_amount.
  ///
  /// In en, this message translates to:
  /// **'Your Wallet Amount'**
  String get wallet_amount;

  /// No description provided for @enter_amount.
  ///
  /// In en, this message translates to:
  /// **'Enter Amount..'**
  String get enter_amount;

  /// No description provided for @congratulations.
  ///
  /// In en, this message translates to:
  /// **'Congratulations !'**
  String get congratulations;

  /// No description provided for @you_have_earned.
  ///
  /// In en, this message translates to:
  /// **'You have earned'**
  String get you_have_earned;

  /// No description provided for @points.
  ///
  /// In en, this message translates to:
  /// **'points'**
  String get points;

  /// No description provided for @points_it_will_add_to.
  ///
  /// In en, this message translates to:
  /// **'points. It will add to your balance when the order is delivered.'**
  String get points_it_will_add_to;

  /// No description provided for @point_to_wallet.
  ///
  /// In en, this message translates to:
  /// **'Point to wallet'**
  String get point_to_wallet;

  /// No description provided for @order_place.
  ///
  /// In en, this message translates to:
  /// **'Order place'**
  String get order_place;

  /// No description provided for @order_refund.
  ///
  /// In en, this message translates to:
  /// **'Order refund'**
  String get order_refund;

  /// No description provided for @input_field_is_empty.
  ///
  /// In en, this message translates to:
  /// **'Input field is empty'**
  String get input_field_is_empty;

  /// No description provided for @transaction_history.
  ///
  /// In en, this message translates to:
  /// **'Transaction History'**
  String get transaction_history;

  /// No description provided for @please_exchange_more_then.
  ///
  /// In en, this message translates to:
  /// **'please exchange more then'**
  String get please_exchange_more_then;

  /// No description provided for @converted_successfully_transfer_to_your_wallet.
  ///
  /// In en, this message translates to:
  /// **'Converted successfully transfer to your wallet'**
  String get converted_successfully_transfer_to_your_wallet;

  /// No description provided for @your_loyalty_point_will_convert_to_currency_and_transfer_to_your_wallet.
  ///
  /// In en, this message translates to:
  /// **'Your loyalty point will convert to currency and transfer to your wallet'**
  String get your_loyalty_point_will_convert_to_currency_and_transfer_to_your_wallet;

  /// No description provided for @add_fund_by_admin.
  ///
  /// In en, this message translates to:
  /// **'Add fund by admin'**
  String get add_fund_by_admin;

  /// No description provided for @credit.
  ///
  /// In en, this message translates to:
  /// **'Credit'**
  String get credit;

  /// No description provided for @debit.
  ///
  /// In en, this message translates to:
  /// **'Debit'**
  String get debit;

  /// No description provided for @wallet_payment.
  ///
  /// In en, this message translates to:
  /// **'Wallet Payment'**
  String get wallet_payment;

  /// No description provided for @pay_from_your_existing_balance.
  ///
  /// In en, this message translates to:
  /// **'Pay from your existing balance'**
  String get pay_from_your_existing_balance;

  /// No description provided for @you_do_not_have_sufficient_balance_in_wallet.
  ///
  /// In en, this message translates to:
  /// **'You do not have sufficient balance in wallet'**
  String get you_do_not_have_sufficient_balance_in_wallet;

  /// No description provided for @product_images.
  ///
  /// In en, this message translates to:
  /// **'Product Images'**
  String get product_images;

  /// No description provided for @refer_code.
  ///
  /// In en, this message translates to:
  /// **'Refer Code (Optional)'**
  String get refer_code;

  /// No description provided for @delivery_man_tips.
  ///
  /// In en, this message translates to:
  /// **'Delivery Man Tips '**
  String get delivery_man_tips;

  /// No description provided for @street_number.
  ///
  /// In en, this message translates to:
  /// **'Street/Galli Name'**
  String get street_number;

  /// No description provided for @house.
  ///
  /// In en, this message translates to:
  /// **'House No'**
  String get house;

  /// No description provided for @floor.
  ///
  /// In en, this message translates to:
  /// **'Alter. Mobile Number'**
  String get floor;

  /// No description provided for @number.
  ///
  /// In en, this message translates to:
  /// **'Number'**
  String get number;

  /// No description provided for @your_food_will_delivered_within.
  ///
  /// In en, this message translates to:
  /// **'Your food will delivered within '**
  String get your_food_will_delivered_within;

  /// No description provided for @invalid_refer_code.
  ///
  /// In en, this message translates to:
  /// **'Invalid refer code'**
  String get invalid_refer_code;

  /// No description provided for @search_item_in_store.
  ///
  /// In en, this message translates to:
  /// **'Search food in restaurant'**
  String get search_item_in_store;

  /// No description provided for @refer_and_earn.
  ///
  /// In en, this message translates to:
  /// **'Refer & Earn'**
  String get refer_and_earn;

  /// No description provided for @earn_money_on_every_referral.
  ///
  /// In en, this message translates to:
  /// **'Earn money on every referral'**
  String get earn_money_on_every_referral;

  /// No description provided for @one_referral.
  ///
  /// In en, this message translates to:
  /// **'1 Referral'**
  String get one_referral;

  /// No description provided for @refer_your_code_to_your_friend.
  ///
  /// In en, this message translates to:
  /// **'Refer your code to your friends'**
  String get refer_your_code_to_your_friend;

  /// No description provided for @get.
  ///
  /// In en, this message translates to:
  /// **'Get'**
  String get get;

  /// No description provided for @on_joining.
  ///
  /// In en, this message translates to:
  /// **'on joining'**
  String get on_joining;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @tap_to_copy.
  ///
  /// In en, this message translates to:
  /// **'Tap to copy'**
  String get tap_to_copy;

  /// No description provided for @your_referral_code.
  ///
  /// In en, this message translates to:
  /// **'Your Referral Code'**
  String get your_referral_code;

  /// No description provided for @referral_code_copied.
  ///
  /// In en, this message translates to:
  /// **'Referral Code Copied'**
  String get referral_code_copied;

  /// No description provided for @view_more.
  ///
  /// In en, this message translates to:
  /// **'View More'**
  String get view_more;

  /// No description provided for @write_item_name.
  ///
  /// In en, this message translates to:
  /// **'Write item name'**
  String get write_item_name;

  /// No description provided for @referrer.
  ///
  /// In en, this message translates to:
  /// **'Referrer'**
  String get referrer;

  /// No description provided for @your_account_remove_successfully.
  ///
  /// In en, this message translates to:
  /// **'Your account remove successfully'**
  String get your_account_remove_successfully;

  /// No description provided for @there_is_a_problem_on_removing_your_account.
  ///
  /// In en, this message translates to:
  /// **'There is a problem on removing your account'**
  String get there_is_a_problem_on_removing_your_account;

  /// No description provided for @delete_account.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get delete_account;

  /// No description provided for @are_you_sure_to_delete_account.
  ///
  /// In en, this message translates to:
  /// **'Are you sure to delete your account?'**
  String get are_you_sure_to_delete_account;

  /// No description provided for @it_will_remove_your_all_information.
  ///
  /// In en, this message translates to:
  /// **'You want to delete this account? If you delete your account your all data will be deleted permanently.'**
  String get it_will_remove_your_all_information;

  /// No description provided for @no_restaurant_data_found.
  ///
  /// In en, this message translates to:
  /// **'No restaurant data found'**
  String get no_restaurant_data_found;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @cart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart;

  /// No description provided for @order_status.
  ///
  /// In en, this message translates to:
  /// **'Order status'**
  String get order_status;

  /// No description provided for @cooking.
  ///
  /// In en, this message translates to:
  /// **'Cooking'**
  String get cooking;

  /// No description provided for @deliveryman_will_soon_pick_your_order.
  ///
  /// In en, this message translates to:
  /// **'Deliveryman will soon pick your order'**
  String get deliveryman_will_soon_pick_your_order;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @food_is_on_the_way.
  ///
  /// In en, this message translates to:
  /// **'Food is on the way !'**
  String get food_is_on_the_way;

  /// No description provided for @ex_24th_street.
  ///
  /// In en, this message translates to:
  /// **'EX: 24th Street'**
  String get ex_24th_street;

  /// No description provided for @ex_34.
  ///
  /// In en, this message translates to:
  /// **'EX: 34'**
  String get ex_34;

  /// No description provided for @ex_3a.
  ///
  /// In en, this message translates to:
  /// **'EX: 3A'**
  String get ex_3a;

  /// No description provided for @promo_code.
  ///
  /// In en, this message translates to:
  /// **'Promo Code'**
  String get promo_code;

  /// No description provided for @add_voucher.
  ///
  /// In en, this message translates to:
  /// **'Add Voucher'**
  String get add_voucher;

  /// No description provided for @ex_please_provide_extra_napkin.
  ///
  /// In en, this message translates to:
  /// **'Ex: Please provide extra napkin'**
  String get ex_please_provide_extra_napkin;

  /// No description provided for @select_a_address.
  ///
  /// In en, this message translates to:
  /// **'Select a address'**
  String get select_a_address;

  /// No description provided for @the_restaurant_will_soon_accept_your_order.
  ///
  /// In en, this message translates to:
  /// **'The restaurant will soon accept your order'**
  String get the_restaurant_will_soon_accept_your_order;

  /// No description provided for @deliveryman_just_picked_your_order.
  ///
  /// In en, this message translates to:
  /// **'Deliveryman just picked your order'**
  String get deliveryman_just_picked_your_order;

  /// No description provided for @deliveryman_accept_your_order.
  ///
  /// In en, this message translates to:
  /// **'Deliveryman accept your order'**
  String get deliveryman_accept_your_order;

  /// No description provided for @write_something.
  ///
  /// In en, this message translates to:
  /// **'Write Something...'**
  String get write_something;

  /// No description provided for @live_chat.
  ///
  /// In en, this message translates to:
  /// **'Live Chat'**
  String get live_chat;

  /// No description provided for @chat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chat;

  /// No description provided for @whatsapp.
  ///
  /// In en, this message translates to:
  /// **'Whatsapp'**
  String get whatsapp;

  /// No description provided for @restaurant_name.
  ///
  /// In en, this message translates to:
  /// **'Restaurant Name'**
  String get restaurant_name;

  /// No description provided for @deliveryman_name.
  ///
  /// In en, this message translates to:
  /// **'Deliveryman Name'**
  String get deliveryman_name;

  /// No description provided for @conversation_list.
  ///
  /// In en, this message translates to:
  /// **'Conversation List'**
  String get conversation_list;

  /// No description provided for @receiver_name.
  ///
  /// In en, this message translates to:
  /// **'Receiver Name'**
  String get receiver_name;

  /// No description provided for @vendor.
  ///
  /// In en, this message translates to:
  /// **'Restaurant'**
  String get vendor;

  /// No description provided for @admin.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get admin;

  /// No description provided for @restaurant_registration.
  ///
  /// In en, this message translates to:
  /// **'Restaurant Registration'**
  String get restaurant_registration;

  /// No description provided for @enter_restaurant_name.
  ///
  /// In en, this message translates to:
  /// **'Enter restaurant name'**
  String get enter_restaurant_name;

  /// No description provided for @restaurant_address.
  ///
  /// In en, this message translates to:
  /// **'Restaurant Address'**
  String get restaurant_address;

  /// No description provided for @enter_restaurant_address.
  ///
  /// In en, this message translates to:
  /// **'Enter restaurant address'**
  String get enter_restaurant_address;

  /// No description provided for @enter_vat_amount.
  ///
  /// In en, this message translates to:
  /// **'Enter VAT amount'**
  String get enter_vat_amount;

  /// No description provided for @minimum_delivery_time.
  ///
  /// In en, this message translates to:
  /// **'Minimum Delivery Time'**
  String get minimum_delivery_time;

  /// No description provided for @enter_minimum_delivery_time.
  ///
  /// In en, this message translates to:
  /// **'Enter minimum delivery time'**
  String get enter_minimum_delivery_time;

  /// No description provided for @maximum_delivery_time.
  ///
  /// In en, this message translates to:
  /// **'Maximum Delivery Time'**
  String get maximum_delivery_time;

  /// No description provided for @enter_maximum_delivery_time.
  ///
  /// In en, this message translates to:
  /// **'Enter maximum delivery time'**
  String get enter_maximum_delivery_time;

  /// No description provided for @logo.
  ///
  /// In en, this message translates to:
  /// **'Logo'**
  String get logo;

  /// No description provided for @cover_photo.
  ///
  /// In en, this message translates to:
  /// **'Cover Photo'**
  String get cover_photo;

  /// No description provided for @select_restaurant_logo.
  ///
  /// In en, this message translates to:
  /// **'Select restaurant logo'**
  String get select_restaurant_logo;

  /// No description provided for @select_restaurant_cover_photo.
  ///
  /// In en, this message translates to:
  /// **'Select restaurant cover photo'**
  String get select_restaurant_cover_photo;

  /// No description provided for @zone.
  ///
  /// In en, this message translates to:
  /// **'Zone'**
  String get zone;

  /// No description provided for @set_restaurant_location.
  ///
  /// In en, this message translates to:
  /// **'Set restaurant location'**
  String get set_restaurant_location;

  /// No description provided for @owner_information.
  ///
  /// In en, this message translates to:
  /// **'Owner Information'**
  String get owner_information;

  /// No description provided for @login_information.
  ///
  /// In en, this message translates to:
  /// **'Login Information'**
  String get login_information;

  /// No description provided for @latitude.
  ///
  /// In en, this message translates to:
  /// **'Latitude'**
  String get latitude;

  /// No description provided for @longitude.
  ///
  /// In en, this message translates to:
  /// **'Longitude'**
  String get longitude;

  /// No description provided for @add_delivery_man.
  ///
  /// In en, this message translates to:
  /// **'Add Delivery Man'**
  String get add_delivery_man;

  /// No description provided for @enter_delivery_man_first_name.
  ///
  /// In en, this message translates to:
  /// **'Enter delivery man first name'**
  String get enter_delivery_man_first_name;

  /// No description provided for @enter_delivery_man_last_name.
  ///
  /// In en, this message translates to:
  /// **'Enter delivery man last name'**
  String get enter_delivery_man_last_name;

  /// No description provided for @enter_delivery_man_email_address.
  ///
  /// In en, this message translates to:
  /// **'Enter delivery man email address'**
  String get enter_delivery_man_email_address;

  /// No description provided for @enter_delivery_man_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Enter delivery man phone number'**
  String get enter_delivery_man_phone_number;

  /// No description provided for @enter_password_for_delivery_man.
  ///
  /// In en, this message translates to:
  /// **'Enter password for delivery man'**
  String get enter_password_for_delivery_man;

  /// No description provided for @enter_delivery_man_identity_number.
  ///
  /// In en, this message translates to:
  /// **'Enter delivery man identity number'**
  String get enter_delivery_man_identity_number;

  /// No description provided for @upload_delivery_man_image.
  ///
  /// In en, this message translates to:
  /// **'Upload delivery man image'**
  String get upload_delivery_man_image;

  /// No description provided for @delivery_man_registration_successful.
  ///
  /// In en, this message translates to:
  /// **'Delivery man registration successful'**
  String get delivery_man_registration_successful;

  /// No description provided for @restaurant_registration_successful.
  ///
  /// In en, this message translates to:
  /// **'Restaurant registration successful'**
  String get restaurant_registration_successful;

  /// No description provided for @passport.
  ///
  /// In en, this message translates to:
  /// **'Passport'**
  String get passport;

  /// No description provided for @driving_license.
  ///
  /// In en, this message translates to:
  /// **'Driving License'**
  String get driving_license;

  /// No description provided for @nid.
  ///
  /// In en, this message translates to:
  /// **'NID'**
  String get nid;

  /// No description provided for @identity_type.
  ///
  /// In en, this message translates to:
  /// **'Identity Type'**
  String get identity_type;

  /// No description provided for @identity_number.
  ///
  /// In en, this message translates to:
  /// **'Identity Number'**
  String get identity_number;

  /// No description provided for @enter_identity_number.
  ///
  /// In en, this message translates to:
  /// **'Enter identity number'**
  String get enter_identity_number;

  /// No description provided for @delivery_man_image.
  ///
  /// In en, this message translates to:
  /// **'Delivery Man Image'**
  String get delivery_man_image;

  /// No description provided for @identity_images.
  ///
  /// In en, this message translates to:
  /// **'Identity Images'**
  String get identity_images;

  /// No description provided for @delivery_man_registration.
  ///
  /// In en, this message translates to:
  /// **'Delivery Man Registration'**
  String get delivery_man_registration;

  /// No description provided for @delivery_man_type.
  ///
  /// In en, this message translates to:
  /// **'Delivery Man Type'**
  String get delivery_man_type;

  /// No description provided for @freelancer.
  ///
  /// In en, this message translates to:
  /// **'Freelancer'**
  String get freelancer;

  /// No description provided for @salary_based.
  ///
  /// In en, this message translates to:
  /// **'Salary Based'**
  String get salary_based;

  /// No description provided for @find_nearby_restaurant_near_you.
  ///
  /// In en, this message translates to:
  /// **'Find Nearby \nRestaurant Near You'**
  String get find_nearby_restaurant_near_you;

  /// No description provided for @see_location.
  ///
  /// In en, this message translates to:
  /// **'See Location'**
  String get see_location;

  /// No description provided for @nearby_restaurants.
  ///
  /// In en, this message translates to:
  /// **'Nearby Restaurants'**
  String get nearby_restaurants;

  /// No description provided for @can_not_add_more_than_3_image.
  ///
  /// In en, this message translates to:
  /// **'Can not add more than 3 image'**
  String get can_not_add_more_than_3_image;

  /// No description provided for @no_conversation_found.
  ///
  /// In en, this message translates to:
  /// **'No conversation found'**
  String get no_conversation_found;

  /// No description provided for @no_message_found.
  ///
  /// In en, this message translates to:
  /// **'No message found'**
  String get no_message_found;

  /// No description provided for @refer.
  ///
  /// In en, this message translates to:
  /// **'Refer'**
  String get refer;

  /// No description provided for @not_found.
  ///
  /// In en, this message translates to:
  /// **'Not Found'**
  String get not_found;

  /// No description provided for @no_address_found.
  ///
  /// In en, this message translates to:
  /// **'No Address Found'**
  String get no_address_found;

  /// No description provided for @chat_with.
  ///
  /// In en, this message translates to:
  /// **'Chat with'**
  String get chat_with;

  /// No description provided for @user_deleted.
  ///
  /// In en, this message translates to:
  /// **'User Deleted'**
  String get user_deleted;

  /// No description provided for @maximum_delivery_time_can_not_be_smaller_then_minimum_delivery_time.
  ///
  /// In en, this message translates to:
  /// **'Maximum Delivery Time Can Not Be Smaller Then Minimum Delivery Time'**
  String get maximum_delivery_time_can_not_be_smaller_then_minimum_delivery_time;

  /// No description provided for @general_information.
  ///
  /// In en, this message translates to:
  /// **'General Information'**
  String get general_information;

  /// No description provided for @business_plan.
  ///
  /// In en, this message translates to:
  /// **'Business Plan'**
  String get business_plan;

  /// No description provided for @complete.
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get complete;

  /// No description provided for @choose_your_business_plan.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Business Plan'**
  String get choose_your_business_plan;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @continue_with.
  ///
  /// In en, this message translates to:
  /// **'Continue with'**
  String get continue_with;

  /// No description provided for @days_free_trial.
  ///
  /// In en, this message translates to:
  /// **'Days Free Trial'**
  String get days_free_trial;

  /// No description provided for @pay_manually.
  ///
  /// In en, this message translates to:
  /// **'Pay Manually'**
  String get pay_manually;

  /// No description provided for @refund_request.
  ///
  /// In en, this message translates to:
  /// **'Refund Request'**
  String get refund_request;

  /// No description provided for @what_is_wrong_with_this_order.
  ///
  /// In en, this message translates to:
  /// **'What’s wrong with this order?'**
  String get what_is_wrong_with_this_order;

  /// No description provided for @refund.
  ///
  /// In en, this message translates to:
  /// **'Refund'**
  String get refund;

  /// No description provided for @submit_refund_request.
  ///
  /// In en, this message translates to:
  /// **'Submit Refund Request'**
  String get submit_refund_request;

  /// No description provided for @please_select_reason.
  ///
  /// In en, this message translates to:
  /// **'Please Select Reason'**
  String get please_select_reason;

  /// No description provided for @ex_please_provide_any_note.
  ///
  /// In en, this message translates to:
  /// **'Ex: Please provide any Note'**
  String get ex_please_provide_any_note;

  /// No description provided for @upload_image.
  ///
  /// In en, this message translates to:
  /// **'Upload Image'**
  String get upload_image;

  /// No description provided for @max_order.
  ///
  /// In en, this message translates to:
  /// **'Max Order'**
  String get max_order;

  /// No description provided for @max_product.
  ///
  /// In en, this message translates to:
  /// **'Max Product'**
  String get max_product;

  /// No description provided for @pos.
  ///
  /// In en, this message translates to:
  /// **'Pos'**
  String get pos;

  /// No description provided for @mobile_app.
  ///
  /// In en, this message translates to:
  /// **'Mobile App'**
  String get mobile_app;

  /// No description provided for @self_delivery.
  ///
  /// In en, this message translates to:
  /// **'Self Delivery'**
  String get self_delivery;

  /// No description provided for @select_an_option.
  ///
  /// In en, this message translates to:
  /// **'Select an option'**
  String get select_an_option;

  /// No description provided for @from_each_order_You_will_get_access_of_all.
  ///
  /// In en, this message translates to:
  /// **'from each order. You will get access of all the features and options  in restaurant panel , app and interaction with user.'**
  String get from_each_order_You_will_get_access_of_all;

  /// No description provided for @run_restaurant_by_purchasing_subscription_packages.
  ///
  /// In en, this message translates to:
  /// **'Run restaurant by purchasing subscription  packages. You will have access the features of in restaurant panel , app and interaction with user according to the subscription packages.'**
  String get run_restaurant_by_purchasing_subscription_packages;

  /// No description provided for @refund_request_canceled.
  ///
  /// In en, this message translates to:
  /// **'Refund Request Canceled'**
  String get refund_request_canceled;

  /// No description provided for @request_for_refund.
  ///
  /// In en, this message translates to:
  /// **'Request for Refund'**
  String get request_for_refund;

  /// No description provided for @your_business_plan_not_setup_yet.
  ///
  /// In en, this message translates to:
  /// **'Your business plan not setup yet'**
  String get your_business_plan_not_setup_yet;

  /// No description provided for @your_registration_not_setup_yet.
  ///
  /// In en, this message translates to:
  /// **'Your Registration Not Setup Yet'**
  String get your_registration_not_setup_yet;

  /// No description provided for @are_you_sure_to_go_back.
  ///
  /// In en, this message translates to:
  /// **'Are you sure to go back?'**
  String get are_you_sure_to_go_back;

  /// No description provided for @optional.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get optional;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required;

  /// No description provided for @maximum_variation_for.
  ///
  /// In en, this message translates to:
  /// **'Maximum variation for'**
  String get maximum_variation_for;

  /// No description provided for @is_name.
  ///
  /// In en, this message translates to:
  /// **'is'**
  String get is_name;

  /// No description provided for @choose_a_variation_from.
  ///
  /// In en, this message translates to:
  /// **'Choose a variation from'**
  String get choose_a_variation_from;

  /// No description provided for @choose_at_least.
  ///
  /// In en, this message translates to:
  /// **'Choose at least'**
  String get choose_at_least;

  /// No description provided for @variations_from.
  ///
  /// In en, this message translates to:
  /// **'variations from'**
  String get variations_from;

  /// No description provided for @minimum.
  ///
  /// In en, this message translates to:
  /// **'Min'**
  String get minimum;

  /// No description provided for @maximum.
  ///
  /// In en, this message translates to:
  /// **'Max'**
  String get maximum;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get and;

  /// No description provided for @you_need_to_select_minimum.
  ///
  /// In en, this message translates to:
  /// **'You need to select minimum'**
  String get you_need_to_select_minimum;

  /// No description provided for @to_maximum.
  ///
  /// In en, this message translates to:
  /// **'to maximum'**
  String get to_maximum;

  /// No description provided for @options.
  ///
  /// In en, this message translates to:
  /// **'options'**
  String get options;

  /// No description provided for @option.
  ///
  /// In en, this message translates to:
  /// **'option'**
  String get option;

  /// No description provided for @options_from.
  ///
  /// In en, this message translates to:
  /// **'options from'**
  String get options_from;

  /// No description provided for @variation.
  ///
  /// In en, this message translates to:
  /// **'variation'**
  String get variation;

  /// No description provided for @shipping_policy.
  ///
  /// In en, this message translates to:
  /// **'Shipping Policy'**
  String get shipping_policy;

  /// No description provided for @cancellation_policy.
  ///
  /// In en, this message translates to:
  /// **'Cancellation Policy'**
  String get cancellation_policy;

  /// No description provided for @refund_policy.
  ///
  /// In en, this message translates to:
  /// **'Refund Policy'**
  String get refund_policy;

  /// No description provided for @restaurant_will_pay.
  ///
  /// In en, this message translates to:
  /// **'Restaurant will pay'**
  String get restaurant_will_pay;

  /// No description provided for @commission_to.
  ///
  /// In en, this message translates to:
  /// **'commission to'**
  String get commission_to;

  /// No description provided for @your_registration_has_been_completed_successfully.
  ///
  /// In en, this message translates to:
  /// **'Your Registration Has been Completed Successfully.\n Admin will confirm your registration request provide review within 48 hour'**
  String get your_registration_has_been_completed_successfully;

  /// No description provided for @restaurant_not_found.
  ///
  /// In en, this message translates to:
  /// **'Restaurant not found'**
  String get restaurant_not_found;

  /// No description provided for @no_package_available.
  ///
  /// In en, this message translates to:
  /// **'No package available'**
  String get no_package_available;

  /// No description provided for @no_package_found.
  ///
  /// In en, this message translates to:
  /// **'No package found'**
  String get no_package_found;

  /// No description provided for @restaurant_is_not_available.
  ///
  /// In en, this message translates to:
  /// **'Restaurant is not available'**
  String get restaurant_is_not_available;

  /// No description provided for @item_is_not_available.
  ///
  /// In en, this message translates to:
  /// **'Item is not available'**
  String get item_is_not_available;

  /// No description provided for @refund_note.
  ///
  /// In en, this message translates to:
  /// **'Refund Note'**
  String get refund_note;

  /// No description provided for @refund_cancellation_note.
  ///
  /// In en, this message translates to:
  /// **'Refund Cancellation Note'**
  String get refund_cancellation_note;

  /// No description provided for @your_order_is.
  ///
  /// In en, this message translates to:
  /// **'Your order is'**
  String get your_order_is;

  /// No description provided for @order.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get order;

  /// No description provided for @item_not_found.
  ///
  /// In en, this message translates to:
  /// **'Item not found'**
  String get item_not_found;

  /// No description provided for @you_cant_order_more_then.
  ///
  /// In en, this message translates to:
  /// **'You can\'t order more then'**
  String get you_cant_order_more_then;

  /// No description provided for @in_cash_on_delivery.
  ///
  /// In en, this message translates to:
  /// **'in COD order'**
  String get in_cash_on_delivery;

  /// No description provided for @select_cancellation_reasons.
  ///
  /// In en, this message translates to:
  /// **'Select Cancellation Reason'**
  String get select_cancellation_reasons;

  /// No description provided for @no_reasons_available.
  ///
  /// In en, this message translates to:
  /// **'No Reasons Available'**
  String get no_reasons_available;

  /// No description provided for @tax_included.
  ///
  /// In en, this message translates to:
  /// **'(Tax Included)'**
  String get tax_included;

  /// No description provided for @cuisines.
  ///
  /// In en, this message translates to:
  /// **'Cuisines'**
  String get cuisines;

  /// No description provided for @cuisine.
  ///
  /// In en, this message translates to:
  /// **'Cuisine'**
  String get cuisine;

  /// No description provided for @cancellation_note.
  ///
  /// In en, this message translates to:
  /// **'Cancellation Note'**
  String get cancellation_note;

  /// No description provided for @recommended_items.
  ///
  /// In en, this message translates to:
  /// **'Recommended items'**
  String get recommended_items;

  /// No description provided for @please_select_cancel_reason.
  ///
  /// In en, this message translates to:
  /// **'Please select cancel reason'**
  String get please_select_cancel_reason;

  /// No description provided for @please_select_cuisine_for_the_restaurant.
  ///
  /// In en, this message translates to:
  /// **'Please select cuisine for the restaurant'**
  String get please_select_cuisine_for_the_restaurant;

  /// No description provided for @vehicle_type.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Type'**
  String get vehicle_type;

  /// No description provided for @please_select_vehicle_for_the_deliveryman.
  ///
  /// In en, this message translates to:
  /// **'Please select vehicle for the deliveryman'**
  String get please_select_vehicle_for_the_deliveryman;

  /// No description provided for @you_did_not_select_select_any_reason.
  ///
  /// In en, this message translates to:
  /// **'You did not select select any reason.'**
  String get you_did_not_select_select_any_reason;

  /// No description provided for @recently_viewed_restaurants.
  ///
  /// In en, this message translates to:
  /// **'Recently Viewed Restaurants'**
  String get recently_viewed_restaurants;

  /// No description provided for @order_type.
  ///
  /// In en, this message translates to:
  /// **'Order Type'**
  String get order_type;

  /// No description provided for @regular_order.
  ///
  /// In en, this message translates to:
  /// **'Regular Order'**
  String get regular_order;

  /// No description provided for @place_an_order_and_enjoy.
  ///
  /// In en, this message translates to:
  /// **'Place an order and enjoy'**
  String get place_an_order_and_enjoy;

  /// No description provided for @subscription_date.
  ///
  /// In en, this message translates to:
  /// **'Subscription Date'**
  String get subscription_date;

  /// No description provided for @choose_subscription_date.
  ///
  /// In en, this message translates to:
  /// **'Choose subscription date'**
  String get choose_subscription_date;

  /// No description provided for @subscription_type.
  ///
  /// In en, this message translates to:
  /// **'Subscription Type'**
  String get subscription_type;

  /// No description provided for @subscription_schedule.
  ///
  /// In en, this message translates to:
  /// **'Subscription Schedule'**
  String get subscription_schedule;

  /// No description provided for @subscription_order.
  ///
  /// In en, this message translates to:
  /// **'Subscription Order'**
  String get subscription_order;

  /// No description provided for @place_order_and_enjoy_it_everytime.
  ///
  /// In en, this message translates to:
  /// **'Place order and enjoy it everytime'**
  String get place_order_and_enjoy_it_everytime;

  /// No description provided for @day_capital.
  ///
  /// In en, this message translates to:
  /// **'Day Capital'**
  String get day_capital;

  /// No description provided for @choose_time.
  ///
  /// In en, this message translates to:
  /// **'Choose Time'**
  String get choose_time;

  /// No description provided for @subscription_order_count.
  ///
  /// In en, this message translates to:
  /// **'Subscription Order Count'**
  String get subscription_order_count;

  /// No description provided for @select_a_date_range_for_subscription.
  ///
  /// In en, this message translates to:
  /// **'Select a date range for subscription'**
  String get select_a_date_range_for_subscription;

  /// No description provided for @select_at_least_one_day_for_subscription.
  ///
  /// In en, this message translates to:
  /// **'Select at least one day for subscription'**
  String get select_at_least_one_day_for_subscription;

  /// No description provided for @delivery_log.
  ///
  /// In en, this message translates to:
  /// **'Delivery Log'**
  String get delivery_log;

  /// No description provided for @pause_log.
  ///
  /// In en, this message translates to:
  /// **'Pause Log'**
  String get pause_log;

  /// No description provided for @log_id.
  ///
  /// In en, this message translates to:
  /// **'Log Id'**
  String get log_id;

  /// No description provided for @no_log_found.
  ///
  /// In en, this message translates to:
  /// **'No log found'**
  String get no_log_found;

  /// No description provided for @subscription_details.
  ///
  /// In en, this message translates to:
  /// **'Subscription Details'**
  String get subscription_details;

  /// No description provided for @subscription_id.
  ///
  /// In en, this message translates to:
  /// **'Subscription Id'**
  String get subscription_id;

  /// No description provided for @pause_subscription.
  ///
  /// In en, this message translates to:
  /// **'Pause Subscription'**
  String get pause_subscription;

  /// No description provided for @choose_subscription_pause_date.
  ///
  /// In en, this message translates to:
  /// **'Choose subscription pause date'**
  String get choose_subscription_pause_date;

  /// No description provided for @write_cancellation_reason.
  ///
  /// In en, this message translates to:
  /// **'Write cancellation reason'**
  String get write_cancellation_reason;

  /// No description provided for @are_you_sure_to_pause_subscription.
  ///
  /// In en, this message translates to:
  /// **'Are you sure to pause subscription'**
  String get are_you_sure_to_pause_subscription;

  /// No description provided for @are_you_sure_to_cancel_subscription.
  ///
  /// In en, this message translates to:
  /// **'Are you sure to cancel subscription'**
  String get are_you_sure_to_cancel_subscription;

  /// No description provided for @cancel_subscription.
  ///
  /// In en, this message translates to:
  /// **'Cancel Subscription'**
  String get cancel_subscription;

  /// No description provided for @subscription_paused_successfully.
  ///
  /// In en, this message translates to:
  /// **'Subscription paused successfully'**
  String get subscription_paused_successfully;

  /// No description provided for @subscription_cancelled_successfully.
  ///
  /// In en, this message translates to:
  /// **'Subscription cancelled successfully'**
  String get subscription_cancelled_successfully;

  /// No description provided for @you_cant_reorder_this_again.
  ///
  /// In en, this message translates to:
  /// **'You can\'t reorder this again'**
  String get you_cant_reorder_this_again;

  /// No description provided for @daily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get daily;

  /// No description provided for @weekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get weekly;

  /// No description provided for @monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthly;

  /// No description provided for @monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get friday;

  /// No description provided for @saturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sunday;

  /// No description provided for @day.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get day;

  /// No description provided for @select_cancel_reason.
  ///
  /// In en, this message translates to:
  /// **'Select cancel reason'**
  String get select_cancel_reason;

  /// No description provided for @please_select_cancellation_reason_first.
  ///
  /// In en, this message translates to:
  /// **'Please select cancel reason first'**
  String get please_select_cancellation_reason_first;

  /// No description provided for @subscription.
  ///
  /// In en, this message translates to:
  /// **'Subscription Order'**
  String get subscription;

  /// No description provided for @cancellation_reason.
  ///
  /// In en, this message translates to:
  /// **'Cancellation Reason'**
  String get cancellation_reason;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @track_subscription.
  ///
  /// In en, this message translates to:
  /// **'Track Subscription'**
  String get track_subscription;

  /// No description provided for @you_are_not_in_the_order_zone.
  ///
  /// In en, this message translates to:
  /// **'You are not in the order zone'**
  String get you_are_not_in_the_order_zone;

  /// No description provided for @your_restaurants.
  ///
  /// In en, this message translates to:
  /// **'Recently Viewed Restaurants'**
  String get your_restaurants;

  /// No description provided for @this_ordered_products_are_updated_so_can_not_reorder_this_order.
  ///
  /// In en, this message translates to:
  /// **'This ordered products are updated so can\'t reorder this order'**
  String get this_ordered_products_are_updated_so_can_not_reorder_this_order;

  /// No description provided for @start_date_and_end_date_can_not_be_same_for_subscription_order.
  ///
  /// In en, this message translates to:
  /// **'Start date and end date can\'t be same for subscription order'**
  String get start_date_and_end_date_can_not_be_same_for_subscription_order;

  /// No description provided for @by_login_i_agree_with_all_the.
  ///
  /// In en, this message translates to:
  /// **'By login I Agree with all the'**
  String get by_login_i_agree_with_all_the;

  /// No description provided for @do_not_have_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have account?'**
  String get do_not_have_account;

  /// No description provided for @already_have_account.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get already_have_account;

  /// No description provided for @enter_email.
  ///
  /// In en, this message translates to:
  /// **'Enter Email'**
  String get enter_email;

  /// No description provided for @please_enter.
  ///
  /// In en, this message translates to:
  /// **'Please enter'**
  String get please_enter;

  /// No description provided for @enter_phone_and_get_otp.
  ///
  /// In en, this message translates to:
  /// **'Enter your mobile number and we will send you OTP number to reset your password.'**
  String get enter_phone_and_get_otp;

  /// No description provided for @confirm_your_password.
  ///
  /// In en, this message translates to:
  /// **'confirm your password'**
  String get confirm_your_password;

  /// No description provided for @agree_terms_and_conditions.
  ///
  /// In en, this message translates to:
  /// **'Terms and conditions must be agreed'**
  String get agree_terms_and_conditions;

  /// No description provided for @if_you_have_any_queries_feel_free_to_contact_with_our.
  ///
  /// In en, this message translates to:
  /// **'If you have any queries feel free to contact with our'**
  String get if_you_have_any_queries_feel_free_to_contact_with_our;

  /// No description provided for @help_and_support.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get help_and_support;

  /// No description provided for @wallet_balance.
  ///
  /// In en, this message translates to:
  /// **'Wallet Balance'**
  String get wallet_balance;

  /// No description provided for @are_you_sure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get are_you_sure;

  /// No description provided for @you_want_to_delete.
  ///
  /// In en, this message translates to:
  /// **'You want to delete this account? If you delete your account your all data will be deleted permanently.'**
  String get you_want_to_delete;

  /// No description provided for @convert_to_wallet_money.
  ///
  /// In en, this message translates to:
  /// **'Convert to Wallet Money'**
  String get convert_to_wallet_money;

  /// No description provided for @amount_can_be_convert_into_wallet_money.
  ///
  /// In en, this message translates to:
  /// **'Amount can be convert into wallet money'**
  String get amount_can_be_convert_into_wallet_money;

  /// No description provided for @invite_friends_and_business.
  ///
  /// In en, this message translates to:
  /// **'Invite friends & businesses'**
  String get invite_friends_and_business;

  /// No description provided for @copy_your_code_share_it_with_your_friends.
  ///
  /// In en, this message translates to:
  /// **'Copy your code, share it with your friends'**
  String get copy_your_code_share_it_with_your_friends;

  /// No description provided for @your_personal_code.
  ///
  /// In en, this message translates to:
  /// **'Your personal code-T&C Applied'**
  String get your_personal_code;

  /// No description provided for @how_it_works.
  ///
  /// In en, this message translates to:
  /// **'How it works ?'**
  String get how_it_works;

  /// No description provided for @complete_registration_process_to_serve_as_delivery_man_in_this_platform.
  ///
  /// In en, this message translates to:
  /// **'Complete registration process to serve as delivery man in this platform'**
  String get complete_registration_process_to_serve_as_delivery_man_in_this_platform;

  /// No description provided for @upload_deliveryman_photo.
  ///
  /// In en, this message translates to:
  /// **'Upload deliveryman photo'**
  String get upload_deliveryman_photo;

  /// No description provided for @select_vehicle_type.
  ///
  /// In en, this message translates to:
  /// **'Select Vehicle Type'**
  String get select_vehicle_type;

  /// No description provided for @upload_identity_image.
  ///
  /// In en, this message translates to:
  /// **'Upload Identity Image'**
  String get upload_identity_image;

  /// No description provided for @pick_delivery_man_profile_image.
  ///
  /// In en, this message translates to:
  /// **'Pick delivery man profile image'**
  String get pick_delivery_man_profile_image;

  /// No description provided for @enter_a_valid_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid phone number'**
  String get enter_a_valid_phone_number;

  /// No description provided for @open_store.
  ///
  /// In en, this message translates to:
  /// **'Open Restaurant'**
  String get open_store;

  /// No description provided for @provide_store_information_to_proceed_next.
  ///
  /// In en, this message translates to:
  /// **'Provide store information to proceed next'**
  String get provide_store_information_to_proceed_next;

  /// No description provided for @upload_store_logo.
  ///
  /// In en, this message translates to:
  /// **'Upload Restaurant Logo'**
  String get upload_store_logo;

  /// No description provided for @upload_store_cover.
  ///
  /// In en, this message translates to:
  /// **'Upload Restaurant Cover'**
  String get upload_store_cover;

  /// No description provided for @store_name.
  ///
  /// In en, this message translates to:
  /// **'Restaurant Name'**
  String get store_name;

  /// No description provided for @set_your_store_location.
  ///
  /// In en, this message translates to:
  /// **'Set Your Restaurant Location'**
  String get set_your_store_location;

  /// No description provided for @please_add_your_address_for_your_better_experience.
  ///
  /// In en, this message translates to:
  /// **'Please add your address for your\nbetter experience'**
  String get please_add_your_address_for_your_better_experience;

  /// No description provided for @add_address.
  ///
  /// In en, this message translates to:
  /// **'Add Address'**
  String get add_address;

  /// No description provided for @level_name.
  ///
  /// In en, this message translates to:
  /// **'Level Name'**
  String get level_name;

  /// No description provided for @more_option.
  ///
  /// In en, this message translates to:
  /// **'more'**
  String get more_option;

  /// No description provided for @select_minimum.
  ///
  /// In en, this message translates to:
  /// **'Select minimum'**
  String get select_minimum;

  /// No description provided for @and_up_to.
  ///
  /// In en, this message translates to:
  /// **'& Up to'**
  String get and_up_to;

  /// No description provided for @add_more_items.
  ///
  /// In en, this message translates to:
  /// **'Add more items'**
  String get add_more_items;

  /// No description provided for @if_any_product_is_not_available.
  ///
  /// In en, this message translates to:
  /// **'If any product is not available'**
  String get if_any_product_is_not_available;

  /// No description provided for @add_cutlery.
  ///
  /// In en, this message translates to:
  /// **'Add cutlery'**
  String get add_cutlery;

  /// No description provided for @delivery_option.
  ///
  /// In en, this message translates to:
  /// **'Delivery Option'**
  String get delivery_option;

  /// No description provided for @add_more_delivery_instruction.
  ///
  /// In en, this message translates to:
  /// **'Add more delivery instruction'**
  String get add_more_delivery_instruction;

  /// No description provided for @schedule_time_tool_tip.
  ///
  /// In en, this message translates to:
  /// **'You can order instantly or you can also order by scheduling the time'**
  String get schedule_time_tool_tip;

  /// No description provided for @how_we_can_help_you.
  ///
  /// In en, this message translates to:
  /// **'How We Can Help You?'**
  String get how_we_can_help_you;

  /// No description provided for @hey_let_us_know_your_problem.
  ///
  /// In en, this message translates to:
  /// **'Hey, Let us know your problem here!'**
  String get hey_let_us_know_your_problem;

  /// No description provided for @general_info.
  ///
  /// In en, this message translates to:
  /// **'General Info'**
  String get general_info;

  /// No description provided for @item_info.
  ///
  /// In en, this message translates to:
  /// **'Item Info'**
  String get item_info;

  /// No description provided for @delivery_man_details.
  ///
  /// In en, this message translates to:
  /// **'Delivery Man Details'**
  String get delivery_man_details;

  /// No description provided for @cutlery.
  ///
  /// In en, this message translates to:
  /// **'Cutlery'**
  String get cutlery;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @ex_jhon.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get ex_jhon;

  /// No description provided for @ex_doe.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get ex_doe;

  /// No description provided for @select_delivery_type.
  ///
  /// In en, this message translates to:
  /// **'Select delivery type'**
  String get select_delivery_type;

  /// No description provided for @select_vehicle.
  ///
  /// In en, this message translates to:
  /// **'Select vehicle'**
  String get select_vehicle;

  /// No description provided for @please_select_identity_type_for_the_deliveryman.
  ///
  /// In en, this message translates to:
  /// **'Please select identity type for the deliveryman'**
  String get please_select_identity_type_for_the_deliveryman;

  /// No description provided for @provide_owner_information_to_confirm.
  ///
  /// In en, this message translates to:
  /// **'Provide owner information to confirm!'**
  String get provide_owner_information_to_confirm;

  /// No description provided for @please_enter_the_max_min_delivery_time.
  ///
  /// In en, this message translates to:
  /// **'Please enter the max-min delivery time'**
  String get please_enter_the_max_min_delivery_time;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @all_products.
  ///
  /// In en, this message translates to:
  /// **'All Products'**
  String get all_products;

  /// No description provided for @guest_user.
  ///
  /// In en, this message translates to:
  /// **'Guest User'**
  String get guest_user;

  /// No description provided for @login_to_view_all_feature.
  ///
  /// In en, this message translates to:
  /// **'Login to view all the features'**
  String get login_to_view_all_feature;

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// No description provided for @promotional_activity.
  ///
  /// In en, this message translates to:
  /// **'Promotional Activity'**
  String get promotional_activity;

  /// No description provided for @earnings.
  ///
  /// In en, this message translates to:
  /// **'Earnings'**
  String get earnings;

  /// No description provided for @my_wallet.
  ///
  /// In en, this message translates to:
  /// **'My Wallet'**
  String get my_wallet;

  /// No description provided for @you_want_to_delete_this_location.
  ///
  /// In en, this message translates to:
  /// **'You want to delete this location?'**
  String get you_want_to_delete_this_location;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @hey_welcome_back.
  ///
  /// In en, this message translates to:
  /// **'Hey Welcome Back!'**
  String get hey_welcome_back;

  /// No description provided for @which_location_do_you_want_to_select.
  ///
  /// In en, this message translates to:
  /// **'Which location do you want to select?'**
  String get which_location_do_you_want_to_select;

  /// No description provided for @use_current_location.
  ///
  /// In en, this message translates to:
  /// **'Use my current location'**
  String get use_current_location;

  /// No description provided for @you_will_earn.
  ///
  /// In en, this message translates to:
  /// **'You will earn'**
  String get you_will_earn;

  /// No description provided for @points_after_completing_this_order.
  ///
  /// In en, this message translates to:
  /// **'points after completing this order'**
  String get points_after_completing_this_order;

  /// No description provided for @visit_loyalty_points.
  ///
  /// In en, this message translates to:
  /// **'Visit Loyalty Points'**
  String get visit_loyalty_points;

  /// No description provided for @do_not_have_cutlery.
  ///
  /// In en, this message translates to:
  /// **'Don’t have cutlery? Restaurant will provide you.'**
  String get do_not_have_cutlery;

  /// No description provided for @you_dont_have_any_saved_address_yet.
  ///
  /// In en, this message translates to:
  /// **'You don’t have any saved address yet. please save address or use your current location'**
  String get you_dont_have_any_saved_address_yet;

  /// No description provided for @available_promo.
  ///
  /// In en, this message translates to:
  /// **'Available Coupon Code For You !'**
  String get available_promo;

  /// No description provided for @on_all_store.
  ///
  /// In en, this message translates to:
  /// **'On all restaurant!'**
  String get on_all_store;

  /// No description provided for @not_now.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get not_now;

  /// No description provided for @custom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get custom;

  /// No description provided for @save_for_later.
  ///
  /// In en, this message translates to:
  /// **'Save for later'**
  String get save_for_later;

  /// No description provided for @please_provide_extra_napkin.
  ///
  /// In en, this message translates to:
  /// **'Ex: Please provide extra napkin'**
  String get please_provide_extra_napkin;

  /// No description provided for @i_have_read_and_agreed_with.
  ///
  /// In en, this message translates to:
  /// **'I have read and agreed with'**
  String get i_have_read_and_agreed_with;

  /// No description provided for @no_thanks.
  ///
  /// In en, this message translates to:
  /// **'No Thanks'**
  String get no_thanks;

  /// No description provided for @yes_accept.
  ///
  /// In en, this message translates to:
  /// **'Yes Accept'**
  String get yes_accept;

  /// No description provided for @remove_it_from_my_cart.
  ///
  /// In en, this message translates to:
  /// **'Remove it from my cart'**
  String get remove_it_from_my_cart;

  /// No description provided for @i_wait_until_it_restocked.
  ///
  /// In en, this message translates to:
  /// **'I’ll wait until it’s restocked'**
  String get i_wait_until_it_restocked;

  /// No description provided for @enter_your_password.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enter_your_password;

  /// No description provided for @payment_method.
  ///
  /// In en, this message translates to:
  /// **'Select Payment Method'**
  String get payment_method;

  /// No description provided for @cash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get cash;

  /// No description provided for @digital.
  ///
  /// In en, this message translates to:
  /// **'Digital'**
  String get digital;

  /// No description provided for @from_restaurant.
  ///
  /// In en, this message translates to:
  /// **'From Restaurant'**
  String get from_restaurant;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get to;

  /// No description provided for @delivery_details.
  ///
  /// In en, this message translates to:
  /// **'Delivery Details'**
  String get delivery_details;

  /// No description provided for @please_select_deliveryman_type.
  ///
  /// In en, this message translates to:
  /// **'Please select deliveryman type'**
  String get please_select_deliveryman_type;

  /// No description provided for @select_identity_type.
  ///
  /// In en, this message translates to:
  /// **'Select identity type'**
  String get select_identity_type;

  /// No description provided for @please_select_identity_image.
  ///
  /// In en, this message translates to:
  /// **'Please select identity image'**
  String get please_select_identity_image;

  /// No description provided for @please_setup_the_marker_in_your_required_location.
  ///
  /// In en, this message translates to:
  /// **'Please setup the marker in your required location'**
  String get please_setup_the_marker_in_your_required_location;

  /// No description provided for @delivery_instruction.
  ///
  /// In en, this message translates to:
  /// **'Delivery Instruction'**
  String get delivery_instruction;

  /// No description provided for @if_item_is_not_available.
  ///
  /// In en, this message translates to:
  /// **'If item isn\'t available'**
  String get if_item_is_not_available;

  /// No description provided for @it_s_a_great_way_to_show_your_appreciation_for_their_hard_work.
  ///
  /// In en, this message translates to:
  /// **'It\'s a great way to show your appreciation for their hard work'**
  String get it_s_a_great_way_to_show_your_appreciation_for_their_hard_work;

  /// No description provided for @coupon_applied.
  ///
  /// In en, this message translates to:
  /// **'Coupon Applied'**
  String get coupon_applied;

  /// No description provided for @more_for_free_delivery.
  ///
  /// In en, this message translates to:
  /// **'more for free delivery'**
  String get more_for_free_delivery;

  /// No description provided for @you_may_also_like.
  ///
  /// In en, this message translates to:
  /// **'You May Also Like!'**
  String get you_may_also_like;

  /// No description provided for @estimated_delivery_time.
  ///
  /// In en, this message translates to:
  /// **'Estimated Delivery Time'**
  String get estimated_delivery_time;

  /// No description provided for @this_item_will_be_shown_in_the_user_app_website.
  ///
  /// In en, this message translates to:
  /// **'This item will be shown in the user app website'**
  String get this_item_will_be_shown_in_the_user_app_website;

  /// No description provided for @delivery_man_information.
  ///
  /// In en, this message translates to:
  /// **'Delivery Man Information'**
  String get delivery_man_information;

  /// No description provided for @driving_license_number.
  ///
  /// In en, this message translates to:
  /// **'Driving license number'**
  String get driving_license_number;

  /// No description provided for @nid_number.
  ///
  /// In en, this message translates to:
  /// **'NID number'**
  String get nid_number;

  /// No description provided for @select_dm_type.
  ///
  /// In en, this message translates to:
  /// **'Select deliveryman type'**
  String get select_dm_type;

  /// No description provided for @select_zone.
  ///
  /// In en, this message translates to:
  /// **'Select zone'**
  String get select_zone;

  /// No description provided for @please_select_zone_for_the_deliveryman.
  ///
  /// In en, this message translates to:
  /// **'Please select zone for the deliveryman'**
  String get please_select_zone_for_the_deliveryman;

  /// No description provided for @login_info.
  ///
  /// In en, this message translates to:
  /// **'Login Info'**
  String get login_info;

  /// No description provided for @no_payment_method_available.
  ///
  /// In en, this message translates to:
  /// **'No payment method available'**
  String get no_payment_method_available;

  /// No description provided for @commission_base.
  ///
  /// In en, this message translates to:
  /// **'Commission Base'**
  String get commission_base;

  /// No description provided for @subscription_base.
  ///
  /// In en, this message translates to:
  /// **'Subscription Base'**
  String get subscription_base;

  /// No description provided for @unlimited.
  ///
  /// In en, this message translates to:
  /// **'Unlimited'**
  String get unlimited;

  /// No description provided for @tips_can_not_be_negative.
  ///
  /// In en, this message translates to:
  /// **'Tips can\'t be negative'**
  String get tips_can_not_be_negative;

  /// No description provided for @select_one.
  ///
  /// In en, this message translates to:
  /// **'Select One'**
  String get select_one;

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @for_users.
  ///
  /// In en, this message translates to:
  /// **'For users'**
  String get for_users;

  /// No description provided for @get_app.
  ///
  /// In en, this message translates to:
  /// **'Get App'**
  String get get_app;

  /// No description provided for @news_letter.
  ///
  /// In en, this message translates to:
  /// **'News letter'**
  String get news_letter;

  /// No description provided for @subscribe_to_out_new_channel_to_get_latest_updates.
  ///
  /// In en, this message translates to:
  /// **'Subscribe to our news letter to get latest updates'**
  String get subscribe_to_out_new_channel_to_get_latest_updates;

  /// No description provided for @your_email_address.
  ///
  /// In en, this message translates to:
  /// **'Your Email Address'**
  String get your_email_address;

  /// No description provided for @find_restaurants_near_you.
  ///
  /// In en, this message translates to:
  /// **'Find Restaurants Near You'**
  String get find_restaurants_near_you;

  /// No description provided for @type_your_address_here_to_pick_form_map.
  ///
  /// In en, this message translates to:
  /// **'Type your address here to pick form map'**
  String get type_your_address_here_to_pick_form_map;

  /// No description provided for @wish_list.
  ///
  /// In en, this message translates to:
  /// **'Wish List'**
  String get wish_list;

  /// No description provided for @search_for_products.
  ///
  /// In en, this message translates to:
  /// **'Search for products'**
  String get search_for_products;

  /// No description provided for @click_one_of_the_option_below.
  ///
  /// In en, this message translates to:
  /// **'(click one of the option below)'**
  String get click_one_of_the_option_below;

  /// No description provided for @pay_via_online.
  ///
  /// In en, this message translates to:
  /// **'Pay Via Online'**
  String get pay_via_online;

  /// No description provided for @faster_and_secure_way_to_pay_bill.
  ///
  /// In en, this message translates to:
  /// **'(Pay Online & Get Reward Points)'**
  String get faster_and_secure_way_to_pay_bill;

  /// No description provided for @add_fund_to_wallet.
  ///
  /// In en, this message translates to:
  /// **'Add Fund to Wallet'**
  String get add_fund_to_wallet;

  /// No description provided for @please_provide_transfer_amount.
  ///
  /// In en, this message translates to:
  /// **'Please provide transfer amount'**
  String get please_provide_transfer_amount;

  /// No description provided for @please_select_payment_method.
  ///
  /// In en, this message translates to:
  /// **'Please select payment method'**
  String get please_select_payment_method;

  /// No description provided for @do_you_want_to_cancel_this_add_fund.
  ///
  /// In en, this message translates to:
  /// **'Do you want to cancel this add fund?'**
  String get do_you_want_to_cancel_this_add_fund;

  /// No description provided for @cancel_add_fund.
  ///
  /// In en, this message translates to:
  /// **'Cancel Add Fund'**
  String get cancel_add_fund;

  /// No description provided for @your_have_balance_in_your_wallet.
  ///
  /// In en, this message translates to:
  /// **'Your total wallet balance'**
  String get your_have_balance_in_your_wallet;

  /// No description provided for @you_can_not_user_wallet_in_partial_payment.
  ///
  /// In en, this message translates to:
  /// **'You can\'t user wallet in partial payment'**
  String get you_can_not_user_wallet_in_partial_payment;

  /// No description provided for @convert_your_loyalty_point_to_wallet_money.
  ///
  /// In en, this message translates to:
  /// **'Convert your loyalty point to wallet money.'**
  String get convert_your_loyalty_point_to_wallet_money;

  /// No description provided for @points_required_to_convert_into_currency.
  ///
  /// In en, this message translates to:
  /// **'points required to convert into currency'**
  String get points_required_to_convert_into_currency;

  /// No description provided for @convert_to_currency_now.
  ///
  /// In en, this message translates to:
  /// **'Convert to Currency Now'**
  String get convert_to_currency_now;

  /// No description provided for @earn_money_to_your_wallet_by_completing_the_offer_challenged.
  ///
  /// In en, this message translates to:
  /// **'Earn money to your wallet by completing the offer & challenged'**
  String get earn_money_to_your_wallet_by_completing_the_offer_challenged;

  /// No description provided for @convert_your_loyalty_points_into_wallet_money.
  ///
  /// In en, this message translates to:
  /// **'Convert your loyalty points into wallet money'**
  String get convert_your_loyalty_points_into_wallet_money;

  /// No description provided for @amin_also_reward_their_top_customers_with_wallet_money.
  ///
  /// In en, this message translates to:
  /// **'Amin also reward their top customers with wallet money'**
  String get amin_also_reward_their_top_customers_with_wallet_money;

  /// No description provided for @send_your_wallet_money_while_order.
  ///
  /// In en, this message translates to:
  /// **'Send your wallet money while order'**
  String get send_your_wallet_money_while_order;

  /// No description provided for @wallet_history.
  ///
  /// In en, this message translates to:
  /// **'Wallet History'**
  String get wallet_history;

  /// No description provided for @valid_till.
  ///
  /// In en, this message translates to:
  /// **'Valid till'**
  String get valid_till;

  /// No description provided for @and_enjoy.
  ///
  /// In en, this message translates to:
  /// **'and enjoy'**
  String get and_enjoy;

  /// No description provided for @bonus.
  ///
  /// In en, this message translates to:
  /// **'bonus'**
  String get bonus;

  /// No description provided for @add_fund_to_wallet_minimum.
  ///
  /// In en, this message translates to:
  /// **'Add Fund to Wallet minimum'**
  String get add_fund_to_wallet_minimum;

  /// No description provided for @paid_by_wallet.
  ///
  /// In en, this message translates to:
  /// **'Paid by wallet'**
  String get paid_by_wallet;

  /// No description provided for @fund_successfully_added_to_wallet.
  ///
  /// In en, this message translates to:
  /// **'Fund successfully added to wallet'**
  String get fund_successfully_added_to_wallet;

  /// No description provided for @fund_not_added_to_wallet.
  ///
  /// In en, this message translates to:
  /// **'Fund not added to wallet'**
  String get fund_not_added_to_wallet;

  /// No description provided for @confirmation_promo_code_apply.
  ///
  /// In en, this message translates to:
  /// **'Confirmation Promo Code Apply'**
  String get confirmation_promo_code_apply;

  /// No description provided for @are_you_sure_to_remove_your_applied_partial_payment_then_apply_promo_code.
  ///
  /// In en, this message translates to:
  /// **'Are you sure to remove your applied partial payment, then apply promo code'**
  String get are_you_sure_to_remove_your_applied_partial_payment_then_apply_promo_code;

  /// No description provided for @not_choose.
  ///
  /// In en, this message translates to:
  /// **'Not choose'**
  String get not_choose;

  /// No description provided for @please_select_payment_method_first.
  ///
  /// In en, this message translates to:
  /// **'Please select payment method first'**
  String get please_select_payment_method_first;

  /// No description provided for @partially_paid_amount.
  ///
  /// In en, this message translates to:
  /// **'Partially paid amount'**
  String get partially_paid_amount;

  /// No description provided for @pay_via_wallet.
  ///
  /// In en, this message translates to:
  /// **'Pay via Wallet'**
  String get pay_via_wallet;

  /// No description provided for @applied.
  ///
  /// In en, this message translates to:
  /// **'Applied!'**
  String get applied;

  /// No description provided for @has_paid_by_your_wallet.
  ///
  /// In en, this message translates to:
  /// **'Has paid by your wallet.'**
  String get has_paid_by_your_wallet;

  /// No description provided for @due_payment.
  ///
  /// In en, this message translates to:
  /// **'Due Payment'**
  String get due_payment;

  /// No description provided for @note.
  ///
  /// In en, this message translates to:
  /// **'Note!'**
  String get note;

  /// No description provided for @you_do_not_have_sufficient_balance_to_pay_full_amount_via_wallet.
  ///
  /// In en, this message translates to:
  /// **'You do not have sufficient balance to pay full amount via wallet.'**
  String get you_do_not_have_sufficient_balance_to_pay_full_amount_via_wallet;

  /// No description provided for @want_to_pay_partially_with_wallet.
  ///
  /// In en, this message translates to:
  /// **'Want to pay partially with wallet ?'**
  String get want_to_pay_partially_with_wallet;

  /// No description provided for @yes_pay.
  ///
  /// In en, this message translates to:
  /// **'Yes, Pay'**
  String get yes_pay;

  /// No description provided for @can_be_paid_via_wallet.
  ///
  /// In en, this message translates to:
  /// **'Can be paid via wallet'**
  String get can_be_paid_via_wallet;

  /// No description provided for @remaining_wallet_balance.
  ///
  /// In en, this message translates to:
  /// **'Remaining Wallet Balance'**
  String get remaining_wallet_balance;

  /// No description provided for @want_to_pay_via_wallet.
  ///
  /// In en, this message translates to:
  /// **'Want to pay via wallet ?'**
  String get want_to_pay_via_wallet;

  /// No description provided for @you_can_pay_the_full_amount_with_your_wallet.
  ///
  /// In en, this message translates to:
  /// **'You can pay the full amount with your wallet.'**
  String get you_can_pay_the_full_amount_with_your_wallet;

  /// No description provided for @all_transactions.
  ///
  /// In en, this message translates to:
  /// **'All Transactions'**
  String get all_transactions;

  /// No description provided for @order_transactions.
  ///
  /// In en, this message translates to:
  /// **'Order Transactions'**
  String get order_transactions;

  /// No description provided for @converted_from_loyalty_point.
  ///
  /// In en, this message translates to:
  /// **'Converted from Loyalty Point'**
  String get converted_from_loyalty_point;

  /// No description provided for @added_via_payment_method.
  ///
  /// In en, this message translates to:
  /// **'Added via Payment Method'**
  String get added_via_payment_method;

  /// No description provided for @earned_by_referral.
  ///
  /// In en, this message translates to:
  /// **'Earned by Referral'**
  String get earned_by_referral;

  /// No description provided for @added_via.
  ///
  /// In en, this message translates to:
  /// **'Added via'**
  String get added_via;

  /// No description provided for @spend_on_order.
  ///
  /// In en, this message translates to:
  /// **'Spend on Order'**
  String get spend_on_order;

  /// No description provided for @add_payment_method.
  ///
  /// In en, this message translates to:
  /// **'Add Payment Method'**
  String get add_payment_method;

  /// No description provided for @how_to_use.
  ///
  /// In en, this message translates to:
  /// **'How to use'**
  String get how_to_use;

  /// No description provided for @messages.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get messages;

  /// No description provided for @search_.
  ///
  /// In en, this message translates to:
  /// **'Search...'**
  String get search_;

  /// No description provided for @start_a_new_message.
  ///
  /// In en, this message translates to:
  /// **'Start a new message'**
  String get start_a_new_message;

  /// No description provided for @no_conversation_selected.
  ///
  /// In en, this message translates to:
  /// **'No conversation selected'**
  String get no_conversation_selected;

  /// No description provided for @please_enter_the_delivery_address.
  ///
  /// In en, this message translates to:
  /// **'Please enter the delivery address'**
  String get please_enter_the_delivery_address;

  /// No description provided for @please_enter_the_contact_person_name.
  ///
  /// In en, this message translates to:
  /// **'Please enter the contact person name'**
  String get please_enter_the_contact_person_name;

  /// No description provided for @please_enter_the_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Please enter the phone number'**
  String get please_enter_the_phone_number;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @you_can_not_add_zero_amount_in_wallet.
  ///
  /// In en, this message translates to:
  /// **'You can\'t add zero amount in wallet'**
  String get you_can_not_add_zero_amount_in_wallet;

  /// No description provided for @service_charge.
  ///
  /// In en, this message translates to:
  /// **'Service charge'**
  String get service_charge;

  /// No description provided for @add_fund.
  ///
  /// In en, this message translates to:
  /// **'Add Fund'**
  String get add_fund;

  /// No description provided for @add_fund_from_your_digital_account.
  ///
  /// In en, this message translates to:
  /// **'Add fund from your digital account'**
  String get add_fund_from_your_digital_account;

  /// No description provided for @maximum_quantity_limit.
  ///
  /// In en, this message translates to:
  /// **'Maximum quantity limit'**
  String get maximum_quantity_limit;

  /// No description provided for @partial_payment.
  ///
  /// In en, this message translates to:
  /// **'Partial Payment'**
  String get partial_payment;

  /// No description provided for @your_wallet_have_not_sufficient_balance.
  ///
  /// In en, this message translates to:
  /// **'Your wallet have not sufficient balance'**
  String get your_wallet_have_not_sufficient_balance;

  /// No description provided for @do_you_want_to_use_now.
  ///
  /// In en, this message translates to:
  /// **'Do you want to use now?'**
  String get do_you_want_to_use_now;

  /// No description provided for @your_wallet_balance_is.
  ///
  /// In en, this message translates to:
  /// **'Your wallet balance is'**
  String get your_wallet_balance_is;

  /// No description provided for @use.
  ///
  /// In en, this message translates to:
  /// **'Use'**
  String get use;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @if_you_want_to_add_fund_to_your_wallet_then_click_add_fund_button.
  ///
  /// In en, this message translates to:
  /// **'If you want to add fund to your wallet then click add fund button'**
  String get if_you_want_to_add_fund_to_your_wallet_then_click_add_fund_button;

  /// No description provided for @add_fund_form_secured_digital_payment_gateways.
  ///
  /// In en, this message translates to:
  /// **'Add fund Form secured Digital payment gateways'**
  String get add_fund_form_secured_digital_payment_gateways;

  /// No description provided for @select_payment_method.
  ///
  /// In en, this message translates to:
  /// **'Select Payment Method'**
  String get select_payment_method;

  /// No description provided for @update_profile.
  ///
  /// In en, this message translates to:
  /// **'Update Profile'**
  String get update_profile;

  /// No description provided for @code_copied.
  ///
  /// In en, this message translates to:
  /// **'Code copied'**
  String get code_copied;

  /// No description provided for @invite_your_friends_and_business.
  ///
  /// In en, this message translates to:
  /// **'Invite your friends & businesses'**
  String get invite_your_friends_and_business;

  /// No description provided for @they_register.
  ///
  /// In en, this message translates to:
  /// **'They register'**
  String get they_register;

  /// No description provided for @with_special_offer.
  ///
  /// In en, this message translates to:
  /// **'with special offer'**
  String get with_special_offer;

  /// No description provided for @you_made_your_earning.
  ///
  /// In en, this message translates to:
  /// **'You made your earning !'**
  String get you_made_your_earning;

  /// No description provided for @order_summary.
  ///
  /// In en, this message translates to:
  /// **'Bill Details'**
  String get order_summary;

  /// No description provided for @find_stores.
  ///
  /// In en, this message translates to:
  /// **'Find Stores'**
  String get find_stores;

  /// No description provided for @money_refund.
  ///
  /// In en, this message translates to:
  /// **'Money Refund'**
  String get money_refund;

  /// No description provided for @shipping.
  ///
  /// In en, this message translates to:
  /// **'Shipping'**
  String get shipping;

  /// No description provided for @terms_and_condition.
  ///
  /// In en, this message translates to:
  /// **'Terms & Condition'**
  String get terms_and_condition;

  /// No description provided for @become_a_vendor.
  ///
  /// In en, this message translates to:
  /// **'Become a Restaurant'**
  String get become_a_vendor;

  /// No description provided for @become_a_delivery_man.
  ///
  /// In en, this message translates to:
  /// **'Become a Delivery Man'**
  String get become_a_delivery_man;

  /// No description provided for @most_tipped.
  ///
  /// In en, this message translates to:
  /// **'Most Tipped'**
  String get most_tipped;

  /// No description provided for @add_coupon.
  ///
  /// In en, this message translates to:
  /// **'Add Coupon'**
  String get add_coupon;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good Morning'**
  String get goodMorning;

  /// No description provided for @goodEvening.
  ///
  /// In en, this message translates to:
  /// **'Good Evening'**
  String get goodEvening;

  /// No description provided for @goodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good Afternoon'**
  String get goodAfternoon;

  /// No description provided for @let_start_week_strong.
  ///
  /// In en, this message translates to:
  /// **'Let\'s start the week strong! 💪'**
  String get let_start_week_strong;

  /// No description provided for @have_a_great_weekend.
  ///
  /// In en, this message translates to:
  /// **'Have a great weekend! ✨'**
  String get have_a_great_weekend;

  /// No description provided for @happy_friday.
  ///
  /// In en, this message translates to:
  /// **'Happy Friday! 🎉'**
  String get happy_friday;

  /// No description provided for @check_internet.
  ///
  /// In en, this message translates to:
  /// **'Check your internet connnection and try again.'**
  String get check_internet;

  /// No description provided for @apply_job_without_cost.
  ///
  /// In en, this message translates to:
  /// **'Apply for job according to skills with no additional costs.'**
  String get apply_job_without_cost;

  /// No description provided for @point_history.
  ///
  /// In en, this message translates to:
  /// **'Point History'**
  String get point_history;

  /// No description provided for @select_your_expected_salary.
  ///
  /// In en, this message translates to:
  /// **'Select your expected salary'**
  String get select_your_expected_salary;

  /// No description provided for @select_your_expected_salary_for_job.
  ///
  /// In en, this message translates to:
  /// **'Select your expected salary for the job'**
  String get select_your_expected_salary_for_job;

  /// No description provided for @select_your_district.
  ///
  /// In en, this message translates to:
  /// **'Select your district to get specific information'**
  String get select_your_district;

  /// No description provided for @select_preferred_location.
  ///
  /// In en, this message translates to:
  /// **'Select Preferred Job Location'**
  String get select_preferred_location;

  /// No description provided for @due_amount.
  ///
  /// In en, this message translates to:
  /// **'Due Amount'**
  String get due_amount;

  /// No description provided for @select_your_desired_job_category.
  ///
  /// In en, this message translates to:
  /// **'Select your desired job category to get specific information'**
  String get select_your_desired_job_category;

  /// No description provided for @select_your_education.
  ///
  /// In en, this message translates to:
  /// **'Select your educational level'**
  String get select_your_education;

  /// No description provided for @select_your_highest_education.
  ///
  /// In en, this message translates to:
  /// **'Select your highest educational level'**
  String get select_your_highest_education;

  /// No description provided for @search_food_and_restaurant.
  ///
  /// In en, this message translates to:
  /// **'Search food and Restaurants'**
  String get search_food_and_restaurant;

  /// No description provided for @recent_search.
  ///
  /// In en, this message translates to:
  /// **'Recent Searches'**
  String get recent_search;

  /// No description provided for @select_years_of_experience.
  ///
  /// In en, this message translates to:
  /// **'Select years of work experience'**
  String get select_years_of_experience;

  /// No description provided for @choose_years_of_experience.
  ///
  /// In en, this message translates to:
  /// **'Choose the number of years you have worked on your related job'**
  String get choose_years_of_experience;

  /// No description provided for @recommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended'**
  String get recommended;

  /// No description provided for @what_on_your_mind.
  ///
  /// In en, this message translates to:
  /// **'What’s Your Craving Today?'**
  String get what_on_your_mind;

  /// No description provided for @today_trends.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Best Deals & Combos'**
  String get today_trends;

  /// No description provided for @here_what_you_might_like_to_taste.
  ///
  /// In en, this message translates to:
  /// **'Order Your Perfect Combo and Save'**
  String get here_what_you_might_like_to_taste;

  /// No description provided for @order_again.
  ///
  /// In en, this message translates to:
  /// **'Order Again!'**
  String get order_again;

  /// No description provided for @recently_you_ordered_from.
  ///
  /// In en, this message translates to:
  /// **'Recently You Ordered from'**
  String get recently_you_ordered_from;

  /// No description provided for @best_review_item.
  ///
  /// In en, this message translates to:
  /// **'Best Review Item'**
  String get best_review_item;

  /// No description provided for @new_on_Chulesi.
  ///
  /// In en, this message translates to:
  /// **'New Restaurant Partners'**
  String get new_on_Chulesi;

  /// No description provided for @refer_now.
  ///
  /// In en, this message translates to:
  /// **'Refer Now'**
  String get refer_now;

  /// No description provided for @refer_an_friend.
  ///
  /// In en, this message translates to:
  /// **'Refer an Friend'**
  String get refer_an_friend;

  /// No description provided for @earn.
  ///
  /// In en, this message translates to:
  /// **'Earn'**
  String get earn;

  /// No description provided for @when_you.
  ///
  /// In en, this message translates to:
  /// **'when you'**
  String get when_you;

  /// No description provided for @popular.
  ///
  /// In en, this message translates to:
  /// **'Popular'**
  String get popular;

  /// No description provided for @new_arrivals.
  ///
  /// In en, this message translates to:
  /// **'New Arrivals'**
  String get new_arrivals;

  /// No description provided for @discounted.
  ///
  /// In en, this message translates to:
  /// **'Discounted'**
  String get discounted;

  /// No description provided for @start_from.
  ///
  /// In en, this message translates to:
  /// **'Start From'**
  String get start_from;

  /// No description provided for @popular_in_this_restaurant.
  ///
  /// In en, this message translates to:
  /// **'Popular In This Restaurant'**
  String get popular_in_this_restaurant;

  /// No description provided for @here_is_what_you_might_like_to_test.
  ///
  /// In en, this message translates to:
  /// **'Here\'s what you might like to test'**
  String get here_is_what_you_might_like_to_test;

  /// No description provided for @restaurant_url_copied.
  ///
  /// In en, this message translates to:
  /// **'Restaurant url copied'**
  String get restaurant_url_copied;

  /// No description provided for @find_nearby.
  ///
  /// In en, this message translates to:
  /// **'Find Restaurants Nearby'**
  String get find_nearby;

  /// No description provided for @restaurant_near_from_you.
  ///
  /// In en, this message translates to:
  /// **'Restaurant Near from You'**
  String get restaurant_near_from_you;

  /// No description provided for @are_you_hungry.
  ///
  /// In en, this message translates to:
  /// **'Want to order food nearby? Let’s find some great options!'**
  String get are_you_hungry;

  /// No description provided for @latest.
  ///
  /// In en, this message translates to:
  /// **'Latest'**
  String get latest;

  /// No description provided for @top_rated.
  ///
  /// In en, this message translates to:
  /// **'Top Rated'**
  String get top_rated;

  /// No description provided for @restaurants_near_you.
  ///
  /// In en, this message translates to:
  /// **'Restaurants near you'**
  String get restaurants_near_you;

  /// No description provided for @your_location.
  ///
  /// In en, this message translates to:
  /// **'Your Current Location'**
  String get your_location;

  /// No description provided for @phone_verification.
  ///
  /// In en, this message translates to:
  /// **'Phone Verification'**
  String get phone_verification;

  /// No description provided for @resent_it.
  ///
  /// In en, this message translates to:
  /// **'Resend it'**
  String get resent_it;

  /// No description provided for @invalid_input.
  ///
  /// In en, this message translates to:
  /// **'Invalid input'**
  String get invalid_input;

  /// No description provided for @use_my_current_location.
  ///
  /// In en, this message translates to:
  /// **'Use My Current Location'**
  String get use_my_current_location;

  /// No description provided for @please_enable_location_permission_from_browser_settings.
  ///
  /// In en, this message translates to:
  /// **'Please enable location permission from browser settings'**
  String get please_enable_location_permission_from_browser_settings;

  /// No description provided for @subscribed_successfully.
  ///
  /// In en, this message translates to:
  /// **'Subscribed Successfully'**
  String get subscribed_successfully;

  /// No description provided for @pay_online.
  ///
  /// In en, this message translates to:
  /// **'Pay Online'**
  String get pay_online;

  /// No description provided for @your_payment_is_successfully_placed.
  ///
  /// In en, this message translates to:
  /// **'Your payment is successfully placed'**
  String get your_payment_is_successfully_placed;

  /// No description provided for @your_payment_is_not_done.
  ///
  /// In en, this message translates to:
  /// **'Your payment is not done'**
  String get your_payment_is_not_done;

  /// No description provided for @paid_by.
  ///
  /// In en, this message translates to:
  /// **'Paid by'**
  String get paid_by;

  /// No description provided for @order_proof.
  ///
  /// In en, this message translates to:
  /// **'Order Proof'**
  String get order_proof;

  /// No description provided for @do_you_want_to_cancel_this_payment.
  ///
  /// In en, this message translates to:
  /// **'Do you want to cancel this payment'**
  String get do_you_want_to_cancel_this_payment;

  /// No description provided for @cancel_payment.
  ///
  /// In en, this message translates to:
  /// **'Cancel Payment'**
  String get cancel_payment;

  /// No description provided for @subscribe.
  ///
  /// In en, this message translates to:
  /// **'Subscribe'**
  String get subscribe;

  /// No description provided for @sorry_no_data_found_related_to_your_search.
  ///
  /// In en, this message translates to:
  /// **'Sorry no data found related to your search'**
  String get sorry_no_data_found_related_to_your_search;

  /// No description provided for @no_promo_available.
  ///
  /// In en, this message translates to:
  /// **'No promo available'**
  String get no_promo_available;

  /// No description provided for @please_add_manually_or_collect_promo_from.
  ///
  /// In en, this message translates to:
  /// **'Please add manually or collect promo from'**
  String get please_add_manually_or_collect_promo_from;

  /// No description provided for @no_contact_information_added.
  ///
  /// In en, this message translates to:
  /// **'No Contact Information Added'**
  String get no_contact_information_added;

  /// No description provided for @continue_name.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continue_name;

  /// No description provided for @contact_information.
  ///
  /// In en, this message translates to:
  /// **'Contact Information'**
  String get contact_information;

  /// No description provided for @please_setup_your_delivery_address_first.
  ///
  /// In en, this message translates to:
  /// **'Please setup your delivery address first'**
  String get please_setup_your_delivery_address_first;

  /// No description provided for @please_enter_contact_person_name.
  ///
  /// In en, this message translates to:
  /// **'Please enter contact person name'**
  String get please_enter_contact_person_name;

  /// No description provided for @please_enter_contact_person_number.
  ///
  /// In en, this message translates to:
  /// **'Please enter contact person number'**
  String get please_enter_contact_person_number;

  /// No description provided for @pay_offline.
  ///
  /// In en, this message translates to:
  /// **'Pay Half Amount'**
  String get pay_offline;

  /// No description provided for @offline_payment.
  ///
  /// In en, this message translates to:
  /// **'Advance Payment'**
  String get offline_payment;

  /// No description provided for @pay_your_bill_using_the_info.
  ///
  /// In en, this message translates to:
  /// **'Pay your bill using the info'**
  String get pay_your_bill_using_the_info;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @write_your_note.
  ///
  /// In en, this message translates to:
  /// **'Write your note'**
  String get write_your_note;

  /// No description provided for @bank_info.
  ///
  /// In en, this message translates to:
  /// **'Bank/Wallet Info'**
  String get bank_info;

  /// No description provided for @pay_on_this_account.
  ///
  /// In en, this message translates to:
  /// **'Pay on this account'**
  String get pay_on_this_account;

  /// No description provided for @select_payment_information.
  ///
  /// In en, this message translates to:
  /// **'Select Payment Information'**
  String get select_payment_information;

  /// No description provided for @bank_information.
  ///
  /// In en, this message translates to:
  /// **'Bank/Wallet Information'**
  String get bank_information;

  /// No description provided for @order_placed_successfully.
  ///
  /// In en, this message translates to:
  /// **'Order Placed Successfully !'**
  String get order_placed_successfully;

  /// No description provided for @your_payment_has_been_successfully_processed_and_your_order.
  ///
  /// In en, this message translates to:
  /// **'Your payment has been successfully processed and your order'**
  String get your_payment_has_been_successfully_processed_and_your_order;

  /// No description provided for @has_been_placed.
  ///
  /// In en, this message translates to:
  /// **'has been placed.'**
  String get has_been_placed;

  /// No description provided for @offline_order_note.
  ///
  /// In en, this message translates to:
  /// **'If you accidentally provided incorrect payment information, you can edit the details in the order details section while the order is still pending.'**
  String get offline_order_note;

  /// No description provided for @seller_payment_info.
  ///
  /// In en, this message translates to:
  /// **'Seller Payment Info'**
  String get seller_payment_info;

  /// No description provided for @my_payment_info.
  ///
  /// In en, this message translates to:
  /// **'My Payment Info'**
  String get my_payment_info;

  /// No description provided for @edit_details.
  ///
  /// In en, this message translates to:
  /// **'Edit Details'**
  String get edit_details;

  /// No description provided for @update_payment_info.
  ///
  /// In en, this message translates to:
  /// **'Update Payment Info'**
  String get update_payment_info;

  /// No description provided for @please_provide_every_information.
  ///
  /// In en, this message translates to:
  /// **'Please provide every information'**
  String get please_provide_every_information;

  /// No description provided for @offline_payment_note_line_one.
  ///
  /// In en, this message translates to:
  /// **'To pay offline you have to pay the bill from a option below'**
  String get offline_payment_note_line_one;

  /// No description provided for @offline_payment_note_line_two.
  ///
  /// In en, this message translates to:
  /// **'Save the necessary information that is necessary to identify or confirmation of  the payment'**
  String get offline_payment_note_line_two;

  /// No description provided for @offline_payment_note_line_three.
  ///
  /// In en, this message translates to:
  /// **'insert the information and proceed'**
  String get offline_payment_note_line_three;

  /// No description provided for @your_order.
  ///
  /// In en, this message translates to:
  /// **'Your Order'**
  String get your_order;

  /// No description provided for @order_accepted.
  ///
  /// In en, this message translates to:
  /// **'Order Accepted'**
  String get order_accepted;

  /// No description provided for @order_is_on_the_way.
  ///
  /// In en, this message translates to:
  /// **'Order is on the way'**
  String get order_is_on_the_way;

  /// No description provided for @your_delivery_man_is_coming.
  ///
  /// In en, this message translates to:
  /// **'Your delivery man is coming'**
  String get your_delivery_man_is_coming;

  /// No description provided for @order_delivered.
  ///
  /// In en, this message translates to:
  /// **'Order Delivered'**
  String get order_delivered;

  /// No description provided for @view_details.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get view_details;

  /// No description provided for @please_select_order_preference_time.
  ///
  /// In en, this message translates to:
  /// **'Please select order preference time'**
  String get please_select_order_preference_time;

  /// No description provided for @select_preference_time.
  ///
  /// In en, this message translates to:
  /// **'Select preference time'**
  String get select_preference_time;

  /// No description provided for @not_available.
  ///
  /// In en, this message translates to:
  /// **'Not Available'**
  String get not_available;

  /// No description provided for @custom_date.
  ///
  /// In en, this message translates to:
  /// **'Custom Date'**
  String get custom_date;

  /// No description provided for @set_date_and_time.
  ///
  /// In en, this message translates to:
  /// **'Set date and time'**
  String get set_date_and_time;

  /// No description provided for @please_upload_lower_size_file.
  ///
  /// In en, this message translates to:
  /// **'Please upload lower size file'**
  String get please_upload_lower_size_file;

  /// No description provided for @can_not_be_empty.
  ///
  /// In en, this message translates to:
  /// **'can not be empty'**
  String get can_not_be_empty;

  /// No description provided for @please_add.
  ///
  /// In en, this message translates to:
  /// **'Please add'**
  String get please_add;

  /// No description provided for @not_set_yet.
  ///
  /// In en, this message translates to:
  /// **'Not set yet'**
  String get not_set_yet;

  /// No description provided for @please_set_data_in.
  ///
  /// In en, this message translates to:
  /// **'Please set data in'**
  String get please_set_data_in;

  /// No description provided for @additional_information.
  ///
  /// In en, this message translates to:
  /// **'Additional Information'**
  String get additional_information;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// No description provided for @convert.
  ///
  /// In en, this message translates to:
  /// **'Convert'**
  String get convert;

  /// No description provided for @from.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get from;

  /// No description provided for @please_provide_contact_person_name.
  ///
  /// In en, this message translates to:
  /// **'Please provide contact person name'**
  String get please_provide_contact_person_name;

  /// No description provided for @please_provide_contact_person_number.
  ///
  /// In en, this message translates to:
  /// **'Please provide contact person number'**
  String get please_provide_contact_person_number;

  /// No description provided for @please_select_zone_for_the_restaurant.
  ///
  /// In en, this message translates to:
  /// **'Please select zone for the restaurant'**
  String get please_select_zone_for_the_restaurant;

  /// No description provided for @restaurant_is_unavailable.
  ///
  /// In en, this message translates to:
  /// **'Restaurant is unavailable'**
  String get restaurant_is_unavailable;

  /// No description provided for @schedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get schedule;

  /// No description provided for @currently_digital_payment_is_not_available.
  ///
  /// In en, this message translates to:
  /// **'Currently digital payment is not available'**
  String get currently_digital_payment_is_not_available;

  /// No description provided for @all_food_items.
  ///
  /// In en, this message translates to:
  /// **'All Food Items'**
  String get all_food_items;

  /// No description provided for @this_is_my_refer_code.
  ///
  /// In en, this message translates to:
  /// **'This is my refer code'**
  String get this_is_my_refer_code;

  /// No description provided for @instance_order_is_not_active.
  ///
  /// In en, this message translates to:
  /// **'Instance order is not active'**
  String get instance_order_is_not_active;

  /// No description provided for @review_submitted_successfully.
  ///
  /// In en, this message translates to:
  /// **'Review submitted successfully'**
  String get review_submitted_successfully;

  /// No description provided for @joined.
  ///
  /// In en, this message translates to:
  /// **'Joined'**
  String get joined;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @searching.
  ///
  /// In en, this message translates to:
  /// **'Searching...'**
  String get searching;

  /// No description provided for @is_required.
  ///
  /// In en, this message translates to:
  /// **'is required'**
  String get is_required;

  /// No description provided for @region.
  ///
  /// In en, this message translates to:
  /// **'Region'**
  String get region;

  /// No description provided for @old_password.
  ///
  /// In en, this message translates to:
  /// **'Old Password'**
  String get old_password;

  /// No description provided for @new_password_cannot_be_same_as_old_password.
  ///
  /// In en, this message translates to:
  /// **'New password cannot be the same as old password'**
  String get new_password_cannot_be_same_as_old_password;

  /// No description provided for @password_should_be_8_characters.
  ///
  /// In en, this message translates to:
  /// **'Password should be 8 characters'**
  String get password_should_be_8_characters;

  /// No description provided for @password_protected.
  ///
  /// In en, this message translates to:
  /// **'Ensure your new password is strong and unique'**
  String get password_protected;

  /// No description provided for @please_enter_order_id.
  ///
  /// In en, this message translates to:
  /// **'Please enter order id'**
  String get please_enter_order_id;

  /// No description provided for @password_donot_match.
  ///
  /// In en, this message translates to:
  /// **'Password don’t match'**
  String get password_donot_match;

  /// No description provided for @restaurant_logo.
  ///
  /// In en, this message translates to:
  /// **'Restaurant Logo'**
  String get restaurant_logo;

  /// No description provided for @restaurant_cover.
  ///
  /// In en, this message translates to:
  /// **'Restaurant Cover'**
  String get restaurant_cover;

  /// No description provided for @restaurant_info.
  ///
  /// In en, this message translates to:
  /// **'Restaurant Info'**
  String get restaurant_info;

  /// No description provided for @write_restaurant_name.
  ///
  /// In en, this message translates to:
  /// **'Write restaurant name'**
  String get write_restaurant_name;

  /// No description provided for @restaurant_name_field_is_required.
  ///
  /// In en, this message translates to:
  /// **'Restaurant name field is required'**
  String get restaurant_name_field_is_required;

  /// No description provided for @this_field_is_required.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get this_field_is_required;

  /// No description provided for @write_restaurant_address.
  ///
  /// In en, this message translates to:
  /// **'Write restaurant address'**
  String get write_restaurant_address;

  /// No description provided for @write_vat_tax_amount.
  ///
  /// In en, this message translates to:
  /// **'Write vat/tax amount'**
  String get write_vat_tax_amount;

  /// No description provided for @select_time.
  ///
  /// In en, this message translates to:
  /// **'Select Time'**
  String get select_time;

  /// No description provided for @returnPolicy.
  ///
  /// In en, this message translates to:
  /// **'Return Policy'**
  String get returnPolicy;

  /// No description provided for @restaurant_vat_tax_field_is_required.
  ///
  /// In en, this message translates to:
  /// **'Restaurant Vat/Tax field is required'**
  String get restaurant_vat_tax_field_is_required;

  /// No description provided for @write_first_name.
  ///
  /// In en, this message translates to:
  /// **'Write First Name'**
  String get write_first_name;

  /// No description provided for @write_last_name.
  ///
  /// In en, this message translates to:
  /// **'Write Last Name'**
  String get write_last_name;

  /// No description provided for @first_name_field_is_required.
  ///
  /// In en, this message translates to:
  /// **'First name field is required'**
  String get first_name_field_is_required;

  /// No description provided for @last_name_field_is_required.
  ///
  /// In en, this message translates to:
  /// **'Last name field is required'**
  String get last_name_field_is_required;

  /// No description provided for @email_field_is_required.
  ///
  /// In en, this message translates to:
  /// **'Email field is required'**
  String get email_field_is_required;

  /// No description provided for @enter_valid_email_address.
  ///
  /// In en, this message translates to:
  /// **'Enter valid email address'**
  String get enter_valid_email_address;

  /// No description provided for @write_email.
  ///
  /// In en, this message translates to:
  /// **'Write Email'**
  String get write_email;

  /// No description provided for @password_field_is_required.
  ///
  /// In en, this message translates to:
  /// **'Password field is required'**
  String get password_field_is_required;

  /// No description provided for @additional_info.
  ///
  /// In en, this message translates to:
  /// **'Additional Info'**
  String get additional_info;

  /// No description provided for @identity_image.
  ///
  /// In en, this message translates to:
  /// **'Identity Image'**
  String get identity_image;

  /// No description provided for @upload_jpg_png_gif_maximum_2_mb.
  ///
  /// In en, this message translates to:
  /// **'Upload jpg, png ,gif \nmaximum 2 MB'**
  String get upload_jpg_png_gif_maximum_2_mb;

  /// No description provided for @deliveryman_info.
  ///
  /// In en, this message translates to:
  /// **'Deliveryman Info'**
  String get deliveryman_info;

  /// No description provided for @write_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Write Phone Number'**
  String get write_phone_number;

  /// No description provided for @provide_valid_password.
  ///
  /// In en, this message translates to:
  /// **'Provide valid password'**
  String get provide_valid_password;

  /// No description provided for @this_info_will_need_for_delivery_app_login.
  ///
  /// In en, this message translates to:
  /// **'This info will need for delivery app login'**
  String get this_info_will_need_for_delivery_app_login;

  /// No description provided for @required_info.
  ///
  /// In en, this message translates to:
  /// **'Required Info'**
  String get required_info;

  /// No description provided for @identity_number_field_is_required.
  ///
  /// In en, this message translates to:
  /// **'Identity number field is required'**
  String get identity_number_field_is_required;

  /// No description provided for @currently_you_are_in_guest_mode_please_login_to_view_all_the_features.
  ///
  /// In en, this message translates to:
  /// **'Currently you are in guest mode, please login to view all the features'**
  String get currently_you_are_in_guest_mode_please_login_to_view_all_the_features;

  /// No description provided for @location_info.
  ///
  /// In en, this message translates to:
  /// **'Location Info'**
  String get location_info;

  /// No description provided for @end_date.
  ///
  /// In en, this message translates to:
  /// **'END DATE'**
  String get end_date;

  /// No description provided for @this_is_a_halal_food.
  ///
  /// In en, this message translates to:
  /// **'This is a halal food'**
  String get this_is_a_halal_food;

  /// No description provided for @phone_number_can_not_be_edited.
  ///
  /// In en, this message translates to:
  /// **'Phone number can’t be edited'**
  String get phone_number_can_not_be_edited;

  /// No description provided for @copied.
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get copied;

  /// No description provided for @or_share.
  ///
  /// In en, this message translates to:
  /// **'OR SHARE'**
  String get or_share;

  /// No description provided for @choose_your_language.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Language'**
  String get choose_your_language;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  /// No description provided for @choose_your_language_to_proceed.
  ///
  /// In en, this message translates to:
  /// **'Choose your language to proceed'**
  String get choose_your_language_to_proceed;

  /// No description provided for @remove_all_from_cart.
  ///
  /// In en, this message translates to:
  /// **'Remove all from cart'**
  String get remove_all_from_cart;

  /// No description provided for @you_are_not_in_zone.
  ///
  /// In en, this message translates to:
  /// **'You are not in zone'**
  String get you_are_not_in_zone;

  /// No description provided for @type_a_massage.
  ///
  /// In en, this message translates to:
  /// **'Type a massage'**
  String get type_a_massage;

  /// No description provided for @restaurant_preference.
  ///
  /// In en, this message translates to:
  /// **'Restaurant Preference'**
  String get restaurant_preference;

  /// No description provided for @search_cuisines.
  ///
  /// In en, this message translates to:
  /// **'Search cuisines'**
  String get search_cuisines;

  /// No description provided for @this_info_will_need_for_restaurant_app_and_panel_login.
  ///
  /// In en, this message translates to:
  /// **'This info will need for restaurant app and panel login'**
  String get this_info_will_need_for_restaurant_app_and_panel_login;

  /// No description provided for @select_multiple_files.
  ///
  /// In en, this message translates to:
  /// **'Select multiple files'**
  String get select_multiple_files;

  /// No description provided for @select_a_file.
  ///
  /// In en, this message translates to:
  /// **'Select a file'**
  String get select_a_file;

  /// No description provided for @currently_the_restaurant_is_unavailable_the_restaurant_will_be_available_at.
  ///
  /// In en, this message translates to:
  /// **'Currently the restaurant is unavailable,\nthe restaurant will be available at '**
  String get currently_the_restaurant_is_unavailable_the_restaurant_will_be_available_at;

  /// No description provided for @phone_number_field_is_required.
  ///
  /// In en, this message translates to:
  /// **'Phone number field is required'**
  String get phone_number_field_is_required;

  /// No description provided for @add_from_another_restaurants.
  ///
  /// In en, this message translates to:
  /// **'Add from another restaurants'**
  String get add_from_another_restaurants;

  /// No description provided for @jpg_png_or_pdf_file_size_no_more_than_ten_mb.
  ///
  /// In en, this message translates to:
  /// **'JPG, PNG or PDF, file size no more than 2MB'**
  String get jpg_png_or_pdf_file_size_no_more_than_ten_mb;

  /// No description provided for @you_are_one_step_away_choose_your_business_plan.
  ///
  /// In en, this message translates to:
  /// **'You are one step away! choose your business plan'**
  String get you_are_one_step_away_choose_your_business_plan;

  /// No description provided for @registration_success.
  ///
  /// In en, this message translates to:
  /// **'Registration Success!'**
  String get registration_success;

  /// No description provided for @transaction_failed.
  ///
  /// In en, this message translates to:
  /// **'Transaction Failed!'**
  String get transaction_failed;

  /// No description provided for @visit_here.
  ///
  /// In en, this message translates to:
  /// **'Visit Here'**
  String get visit_here;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// No description provided for @continue_to_home_page.
  ///
  /// In en, this message translates to:
  /// **'Continue to Home Page'**
  String get continue_to_home_page;

  /// No description provided for @subscription_success_message.
  ///
  /// In en, this message translates to:
  /// **'Thank you for your subscription purchase! Your payment was successfully processed. Please note that your subscription will be activated once it has been approved by our Admin Team. To explore the site'**
  String get subscription_success_message;

  /// No description provided for @commission_base_success_message.
  ///
  /// In en, this message translates to:
  /// **'You\'ve opted for our commission-based plan. Admin will review the details and activate your account shortly. To explore the site'**
  String get commission_base_success_message;

  /// No description provided for @sorry_your_transaction_can_not_be_completed_please_choose_another_payment_method_or_try_again.
  ///
  /// In en, this message translates to:
  /// **'Sorry, Your Transaction can\'t be completed. Please choose another payment method or try again.'**
  String get sorry_your_transaction_can_not_be_completed_please_choose_another_payment_method_or_try_again;

  /// No description provided for @try_again.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get try_again;

  /// No description provided for @upload_profile_picture.
  ///
  /// In en, this message translates to:
  /// **'Upload Profile Picture'**
  String get upload_profile_picture;

  /// No description provided for @estimate_delivery_time.
  ///
  /// In en, this message translates to:
  /// **'Estimate Delivery Time'**
  String get estimate_delivery_time;

  /// No description provided for @delete_your_account.
  ///
  /// In en, this message translates to:
  /// **'Delete Your Account ?'**
  String get delete_your_account;

  /// No description provided for @you_will_not_be_able_to_recover_your_data_again.
  ///
  /// In en, this message translates to:
  /// **'You will not be able to recover your data again'**
  String get you_will_not_be_able_to_recover_your_data_again;

  /// No description provided for @sorry_you_cannot_delete_your_account.
  ///
  /// In en, this message translates to:
  /// **'Sorry you can’t delete your account !'**
  String get sorry_you_cannot_delete_your_account;

  /// No description provided for @please_complete_your_ongoing_and_accepted_orders.
  ///
  /// In en, this message translates to:
  /// **'Please complete your ongoing and accepted orders'**
  String get please_complete_your_ongoing_and_accepted_orders;

  /// No description provided for @order_request.
  ///
  /// In en, this message translates to:
  /// **'Order Request'**
  String get order_request;

  /// No description provided for @images_send.
  ///
  /// In en, this message translates to:
  /// **'images send'**
  String get images_send;

  /// No description provided for @start_conversation.
  ///
  /// In en, this message translates to:
  /// **'Start conversation'**
  String get start_conversation;

  /// No description provided for @open_now.
  ///
  /// In en, this message translates to:
  /// **'Open Now'**
  String get open_now;

  /// No description provided for @away.
  ///
  /// In en, this message translates to:
  /// **'Away'**
  String get away;

  /// No description provided for @invite_friends_and_earn_money_on_Every_Referral.
  ///
  /// In en, this message translates to:
  /// **'Invite friends & Earn Money on Every Referral'**
  String get invite_friends_and_earn_money_on_Every_Referral;

  /// No description provided for @no_cuisine_available.
  ///
  /// In en, this message translates to:
  /// **'No cuisine available'**
  String get no_cuisine_available;

  /// No description provided for @search_restaurant.
  ///
  /// In en, this message translates to:
  /// **'Search Restaurant'**
  String get search_restaurant;

  /// No description provided for @confirm_password_field_is_required.
  ///
  /// In en, this message translates to:
  /// **'Confirm password field is required'**
  String get confirm_password_field_is_required;

  /// No description provided for @language_updated_successfully.
  ///
  /// In en, this message translates to:
  /// **'Language updated successfully'**
  String get language_updated_successfully;

  /// No description provided for @share_any_specific_delivery_details_here.
  ///
  /// In en, this message translates to:
  /// **'Share any specific delivery details here also if you are ordering cake please write your message'**
  String get share_any_specific_delivery_details_here;

  /// No description provided for @welcome_to.
  ///
  /// In en, this message translates to:
  /// **'Welcome to'**
  String get welcome_to;

  /// No description provided for @thanks_for_joining_us_your_registration_is_under_review_hang_tight_we_ll_notify_you_once_approved.
  ///
  /// In en, this message translates to:
  /// **'Thanks for joining us! Your registration is under review. Hang tight, we\'ll notify you once approved!'**
  String get thanks_for_joining_us_your_registration_is_under_review_hang_tight_we_ll_notify_you_once_approved;

  /// No description provided for @okay.
  ///
  /// In en, this message translates to:
  /// **'Okay'**
  String get okay;

  /// No description provided for @wants_to_unlock_more_features.
  ///
  /// In en, this message translates to:
  /// **'Wants to Unlock More Features?'**
  String get wants_to_unlock_more_features;

  /// No description provided for @click_here_to_login.
  ///
  /// In en, this message translates to:
  /// **'Click here to login'**
  String get click_here_to_login;

  /// No description provided for @login_to_manage_your_orders_and_enjoy_additional_benefits.
  ///
  /// In en, this message translates to:
  /// **'Login to manage your orders and Enjoy Additional Benefits'**
  String get login_to_manage_your_orders_and_enjoy_additional_benefits;

  /// No description provided for @session_time_out.
  ///
  /// In en, this message translates to:
  /// **'Session Time Out'**
  String get session_time_out;

  /// No description provided for @though_it_is_demo_text.
  ///
  /// In en, this message translates to:
  /// **'Though it is a demo app, our system automatically reset after one hour and that\'s why you logged out.'**
  String get though_it_is_demo_text;

  /// No description provided for @not_in_zone.
  ///
  /// In en, this message translates to:
  /// **'Not in zone'**
  String get not_in_zone;

  /// No description provided for @write_street_number.
  ///
  /// In en, this message translates to:
  /// **'Write street number'**
  String get write_street_number;

  /// No description provided for @write_house_number.
  ///
  /// In en, this message translates to:
  /// **'Write house number'**
  String get write_house_number;

  /// No description provided for @write_floor_number.
  ///
  /// In en, this message translates to:
  /// **'Alternative Mobile Number'**
  String get write_floor_number;

  /// No description provided for @owner_info.
  ///
  /// In en, this message translates to:
  /// **'Owner Info'**
  String get owner_info;

  /// No description provided for @low_to_high.
  ///
  /// In en, this message translates to:
  /// **'Low to High'**
  String get low_to_high;

  /// No description provided for @high_to_low.
  ///
  /// In en, this message translates to:
  /// **'High to Low'**
  String get high_to_low;

  /// No description provided for @select_price_sort.
  ///
  /// In en, this message translates to:
  /// **'Select Price Sort'**
  String get select_price_sort;

  /// No description provided for @select_letter_sort.
  ///
  /// In en, this message translates to:
  /// **'Select Letter Sort'**
  String get select_letter_sort;

  /// No description provided for @you_have_not_add_to_cart_yet.
  ///
  /// In en, this message translates to:
  /// **'You haven’t add to cart yet!'**
  String get you_have_not_add_to_cart_yet;

  /// No description provided for @no_coupon_available.
  ///
  /// In en, this message translates to:
  /// **'No coupon available'**
  String get no_coupon_available;

  /// No description provided for @no_transaction_yet.
  ///
  /// In en, this message translates to:
  /// **'No transaction yet!'**
  String get no_transaction_yet;

  /// No description provided for @no_notification.
  ///
  /// In en, this message translates to:
  /// **'No notification'**
  String get no_notification;

  /// No description provided for @no_order_yet.
  ///
  /// In en, this message translates to:
  /// **'No order yet!'**
  String get no_order_yet;

  /// No description provided for @there_is_no_restaurant.
  ///
  /// In en, this message translates to:
  /// **'There is no restaurant'**
  String get there_is_no_restaurant;

  /// No description provided for @there_is_no_food.
  ///
  /// In en, this message translates to:
  /// **'There is no food'**
  String get there_is_no_food;

  /// No description provided for @you_have_not_add_any_restaurant_to_wishlist.
  ///
  /// In en, this message translates to:
  /// **'You haven’t add any restaurant to wishlist'**
  String get you_have_not_add_any_restaurant_to_wishlist;

  /// No description provided for @you_have_not_add_any_food_to_wishlist.
  ///
  /// In en, this message translates to:
  /// **'You haven’t add any food to wishlist'**
  String get you_have_not_add_any_food_to_wishlist;

  /// No description provided for @no_restaurant_found.
  ///
  /// In en, this message translates to:
  /// **'No restaurant found'**
  String get no_restaurant_found;

  /// No description provided for @no_food_found.
  ///
  /// In en, this message translates to:
  /// **'No food found'**
  String get no_food_found;

  /// No description provided for @you_do_not_have_enough_point_to_exchange.
  ///
  /// In en, this message translates to:
  /// **'You do not have enough point to exchange'**
  String get you_do_not_have_enough_point_to_exchange;

  /// No description provided for @enter_point.
  ///
  /// In en, this message translates to:
  /// **'Enter point'**
  String get enter_point;

  /// No description provided for @point.
  ///
  /// In en, this message translates to:
  /// **'Point'**
  String get point;

  /// No description provided for @place_the_pin_accurately_to_your_location_inside_the_zone.
  ///
  /// In en, this message translates to:
  /// **'Place the pin accurately to your location inside the zone'**
  String get place_the_pin_accurately_to_your_location_inside_the_zone;

  /// No description provided for @remove_from_cart.
  ///
  /// In en, this message translates to:
  /// **'Remove from cart'**
  String get remove_from_cart;

  /// No description provided for @please_place_the_marker_inside_the_zone.
  ///
  /// In en, this message translates to:
  /// **'Please place the marker inside the zone'**
  String get please_place_the_marker_inside_the_zone;

  /// No description provided for @uploading.
  ///
  /// In en, this message translates to:
  /// **'Uploading'**
  String get uploading;

  /// No description provided for @images.
  ///
  /// In en, this message translates to:
  /// **'images'**
  String get images;

  /// No description provided for @by_singing_up_i_agree_with_all_the.
  ///
  /// In en, this message translates to:
  /// **'By singing up I agree with all the'**
  String get by_singing_up_i_agree_with_all_the;

  /// No description provided for @restaurant_is_close_now.
  ///
  /// In en, this message translates to:
  /// **'Restaurant is close now'**
  String get restaurant_is_close_now;

  /// No description provided for @please_provide_vat_tax_amount.
  ///
  /// In en, this message translates to:
  /// **'Please provide vat/tax amount'**
  String get please_provide_vat_tax_amount;

  /// No description provided for @chat_with_admin.
  ///
  /// In en, this message translates to:
  /// **'Chat with Support'**
  String get chat_with_admin;

  /// No description provided for @get_ready_for_a_special_welcome_gift_enjoy_a_special_discount_on_your_first_order_within.
  ///
  /// In en, this message translates to:
  /// **'Get ready for a special welcome gift, enjoy a special discount on your first order within'**
  String get get_ready_for_a_special_welcome_gift_enjoy_a_special_discount_on_your_first_order_within;

  /// No description provided for @start_exploring_the_best_services_around_you.
  ///
  /// In en, this message translates to:
  /// **'Start exploring the best services around you.'**
  String get start_exploring_the_best_services_around_you;

  /// No description provided for @cash_back.
  ///
  /// In en, this message translates to:
  /// **'CASH & BACK'**
  String get cash_back;

  /// No description provided for @min_spent.
  ///
  /// In en, this message translates to:
  /// **'Min Spent'**
  String get min_spent;

  /// No description provided for @no_offer_available.
  ///
  /// In en, this message translates to:
  /// **'No offer available'**
  String get no_offer_available;

  /// No description provided for @you_will_get.
  ///
  /// In en, this message translates to:
  /// **'You will get'**
  String get you_will_get;

  /// No description provided for @cash_back_after_completing_order.
  ///
  /// In en, this message translates to:
  /// **'cash back after completing order'**
  String get cash_back_after_completing_order;

  /// No description provided for @need_extra_packaging.
  ///
  /// In en, this message translates to:
  /// **'Need extra packaging'**
  String get need_extra_packaging;

  /// No description provided for @extra_packaging.
  ///
  /// In en, this message translates to:
  /// **'Extra Packaging'**
  String get extra_packaging;

  /// No description provided for @your_referral_discount_added_on_your_first_order.
  ///
  /// In en, this message translates to:
  /// **'Your referral discount added on your first order'**
  String get your_referral_discount_added_on_your_first_order;

  /// No description provided for @referral_discount.
  ///
  /// In en, this message translates to:
  /// **'Referral Discount'**
  String get referral_discount;

  /// No description provided for @reviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// No description provided for @order_created.
  ///
  /// In en, this message translates to:
  /// **'Order Created'**
  String get order_created;

  /// No description provided for @you_will_get_your_order_daily_at.
  ///
  /// In en, this message translates to:
  /// **'You will get your order daily at'**
  String get you_will_get_your_order_daily_at;

  /// No description provided for @maximum_variation_quantity_limit.
  ///
  /// In en, this message translates to:
  /// **'Maximum variation quantity limit'**
  String get maximum_variation_quantity_limit;

  /// No description provided for @maximum_cart_quantity_limit.
  ///
  /// In en, this message translates to:
  /// **'Maximum cart quantity limit'**
  String get maximum_cart_quantity_limit;

  /// No description provided for @maximum_food_quantity_limit.
  ///
  /// In en, this message translates to:
  /// **'Maximum food quantity limit'**
  String get maximum_food_quantity_limit;

  /// No description provided for @maximum_addon_limit.
  ///
  /// In en, this message translates to:
  /// **'Maximum addon limit'**
  String get maximum_addon_limit;

  /// No description provided for @addon_out_of_stock.
  ///
  /// In en, this message translates to:
  /// **'Addon out of stock'**
  String get addon_out_of_stock;

  /// No description provided for @variation_is_out_of_stock.
  ///
  /// In en, this message translates to:
  /// **'variation is out of stock'**
  String get variation_is_out_of_stock;

  /// No description provided for @cash_back_transactions.
  ///
  /// In en, this message translates to:
  /// **'Cash Back Transactions'**
  String get cash_back_transactions;

  /// No description provided for @product_is_out_of_stock.
  ///
  /// In en, this message translates to:
  /// **'Product is out of stock'**
  String get product_is_out_of_stock;

  /// No description provided for @show_more.
  ///
  /// In en, this message translates to:
  /// **'Show More'**
  String get show_more;

  /// No description provided for @show_less.
  ///
  /// In en, this message translates to:
  /// **'Show Less'**
  String get show_less;

  /// No description provided for @only.
  ///
  /// In en, this message translates to:
  /// **'Only'**
  String get only;

  /// No description provided for @item_available.
  ///
  /// In en, this message translates to:
  /// **'item available'**
  String get item_available;

  /// No description provided for @recommend_for_you.
  ///
  /// In en, this message translates to:
  /// **'Recommend For You'**
  String get recommend_for_you;

  /// No description provided for @see_our_most_popular_restaurant_and_foods.
  ///
  /// In en, this message translates to:
  /// **'See our most popular restaurants and foods'**
  String get see_our_most_popular_restaurant_and_foods;

  /// No description provided for @highlights_for_you.
  ///
  /// In en, this message translates to:
  /// **'Sponsored Restaurants'**
  String get highlights_for_you;

  /// No description provided for @convertible_points.
  ///
  /// In en, this message translates to:
  /// **'Convertible Points'**
  String get convertible_points;

  /// No description provided for @download_app_from_this_link.
  ///
  /// In en, this message translates to:
  /// **'Download app from this link'**
  String get download_app_from_this_link;

  /// No description provided for @referral_code.
  ///
  /// In en, this message translates to:
  /// **'Referral Code'**
  String get referral_code;

  /// No description provided for @open_at.
  ///
  /// In en, this message translates to:
  /// **'Open At'**
  String get open_at;

  /// No description provided for @no_suggestions_found.
  ///
  /// In en, this message translates to:
  /// **'No Suggestions Found'**
  String get no_suggestions_found;

  /// No description provided for @you_want_to_disable_notification.
  ///
  /// In en, this message translates to:
  /// **'You want to disable notification'**
  String get you_want_to_disable_notification;

  /// No description provided for @you_want_to_enable_notification.
  ///
  /// In en, this message translates to:
  /// **'You want to enable notification'**
  String get you_want_to_enable_notification;

  /// No description provided for @confirm_delivery_details.
  ///
  /// In en, this message translates to:
  /// **'Confirm Delivery Details'**
  String get confirm_delivery_details;

  /// No description provided for @charge.
  ///
  /// In en, this message translates to:
  /// **'Charge'**
  String get charge;

  /// No description provided for @this_charge_include_extra_vehicle_charge.
  ///
  /// In en, this message translates to:
  /// **'This charge included with extra vehicle charge'**
  String get this_charge_include_extra_vehicle_charge;

  /// No description provided for @please_select_address_first.
  ///
  /// In en, this message translates to:
  /// **'Please select address first'**
  String get please_select_address_first;

  /// No description provided for @product_is_not_available.
  ///
  /// In en, this message translates to:
  /// **'Product is not available'**
  String get product_is_not_available;

  /// No description provided for @and_bad_weather_charge.
  ///
  /// In en, this message translates to:
  /// **'and bad weather charge'**
  String get and_bad_weather_charge;

  /// No description provided for @any_query_feel_free_to_contact_us.
  ///
  /// In en, this message translates to:
  /// **'Any query? Feel free to contact us'**
  String get any_query_feel_free_to_contact_us;

  /// No description provided for @pick_files.
  ///
  /// In en, this message translates to:
  /// **'Pick Files'**
  String get pick_files;

  /// No description provided for @pick_video.
  ///
  /// In en, this message translates to:
  /// **'Pick Video'**
  String get pick_video;

  /// No description provided for @please_enter_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Please enter phone number'**
  String get please_enter_phone_number;

  /// No description provided for @please_enter_password.
  ///
  /// In en, this message translates to:
  /// **'Please enter password'**
  String get please_enter_password;

  /// No description provided for @we_are_cooking_up_something_special.
  ///
  /// In en, this message translates to:
  /// **'We\'re Cooking Up Something Special!'**
  String get we_are_cooking_up_something_special;

  /// No description provided for @maintenance_mode.
  ///
  /// In en, this message translates to:
  /// **'Our system is currently undergoing maintenance to bring you an even tastier experience. Hang tight while we make the dishes.'**
  String get maintenance_mode;

  /// No description provided for @view_orders.
  ///
  /// In en, this message translates to:
  /// **'View Orders'**
  String get view_orders;

  /// No description provided for @our_demo_system_is_resetting_please_wait.
  ///
  /// In en, this message translates to:
  /// **'Our demo system is resetting. Please wait'**
  String get our_demo_system_is_resetting_please_wait;

  /// No description provided for @second.
  ///
  /// In en, this message translates to:
  /// **'second'**
  String get second;

  /// No description provided for @please_enter_first_name.
  ///
  /// In en, this message translates to:
  /// **'Please enter first name'**
  String get please_enter_first_name;

  /// No description provided for @please_enter_last_name.
  ///
  /// In en, this message translates to:
  /// **'Please enter last name'**
  String get please_enter_last_name;

  /// No description provided for @please_enter_email.
  ///
  /// In en, this message translates to:
  /// **'Please enter email'**
  String get please_enter_email;

  /// No description provided for @please_enter_confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Please enter confirm password'**
  String get please_enter_confirm_password;

  /// No description provided for @are_you_seeking_for_an_employee.
  ///
  /// In en, this message translates to:
  /// **'Are you seeking for an employee?'**
  String get are_you_seeking_for_an_employee;

  /// No description provided for @switch_to_employer.
  ///
  /// In en, this message translates to:
  /// **'Switch To Employer'**
  String get switch_to_employer;

  /// No description provided for @i_agree_with_all_the.
  ///
  /// In en, this message translates to:
  /// **'I agree with all the'**
  String get i_agree_with_all_the;

  /// No description provided for @current_password.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get current_password;

  /// No description provided for @update_password.
  ///
  /// In en, this message translates to:
  /// **'Update Password'**
  String get update_password;

  /// No description provided for @confirm_new_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirm_new_password;

  /// No description provided for @enter_first_name.
  ///
  /// In en, this message translates to:
  /// **'Enter First Name'**
  String get enter_first_name;

  /// No description provided for @enter_last_name.
  ///
  /// In en, this message translates to:
  /// **'Enter Last Name'**
  String get enter_last_name;

  /// No description provided for @profile_settings.
  ///
  /// In en, this message translates to:
  /// **'Profile settings'**
  String get profile_settings;

  /// No description provided for @change_profile_settings.
  ///
  /// In en, this message translates to:
  /// **'Change profile settings'**
  String get change_profile_settings;

  /// No description provided for @to_learn_more.
  ///
  /// In en, this message translates to:
  /// **'To learn more'**
  String get to_learn_more;

  /// No description provided for @enter_new_password_to_change_your_password.
  ///
  /// In en, this message translates to:
  /// **'Enter a new password below to change your password'**
  String get enter_new_password_to_change_your_password;

  /// No description provided for @logout_of_your_account.
  ///
  /// In en, this message translates to:
  /// **'Log out of your account?'**
  String get logout_of_your_account;

  /// No description provided for @you_will_not_be_able_to_undo.
  ///
  /// In en, this message translates to:
  /// **'You won\'t be able to undo this action'**
  String get you_will_not_be_able_to_undo;

  /// No description provided for @about_rojgari.
  ///
  /// In en, this message translates to:
  /// **'About Rojgari'**
  String get about_rojgari;

  /// No description provided for @click_below_to_logout.
  ///
  /// In en, this message translates to:
  /// **'Click below to log out'**
  String get click_below_to_logout;

  /// No description provided for @customize_your_experiecne_on_rojgari.
  ///
  /// In en, this message translates to:
  /// **'Customize your experience on Rojgari'**
  String get customize_your_experiecne_on_rojgari;

  /// No description provided for @click_below_for_more_information_on_employment_services.
  ///
  /// In en, this message translates to:
  /// **'Click below for more information on employment services'**
  String get click_below_for_more_information_on_employment_services;

  /// No description provided for @please_enter_new_password.
  ///
  /// In en, this message translates to:
  /// **'Please enter new password'**
  String get please_enter_new_password;

  /// No description provided for @attachment.
  ///
  /// In en, this message translates to:
  /// **'Attachment'**
  String get attachment;

  /// No description provided for @if_you_disable_this_option_you_will_not_receive_system_notifications.
  ///
  /// In en, this message translates to:
  /// **'If you disable this option, you will not receive system notifications.'**
  String get if_you_disable_this_option_you_will_not_receive_system_notifications;

  /// No description provided for @when_you_enable_this_option_you_will_be_notified_with_the_system_notifications.
  ///
  /// In en, this message translates to:
  /// **'When you enable this option, you will be notified with the system notifications.'**
  String get when_you_enable_this_option_you_will_be_notified_with_the_system_notifications;

  /// No description provided for @permission_denied_cannot_download_the_file.
  ///
  /// In en, this message translates to:
  /// **'Permission Denied! Cannot download the file'**
  String get permission_denied_cannot_download_the_file;

  /// No description provided for @or_continue_with.
  ///
  /// In en, this message translates to:
  /// **'or continue with'**
  String get or_continue_with;

  /// No description provided for @continue_with_apple.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get continue_with_apple;

  /// No description provided for @continue_with_google.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continue_with_google;

  /// No description provided for @continue_with_facebook.
  ///
  /// In en, this message translates to:
  /// **'Continue with Facebook'**
  String get continue_with_facebook;

  /// No description provided for @sign_in_with.
  ///
  /// In en, this message translates to:
  /// **'Sign in with'**
  String get sign_in_with;

  /// No description provided for @otp.
  ///
  /// In en, this message translates to:
  /// **'OTP'**
  String get otp;

  /// No description provided for @is_it_you.
  ///
  /// In en, this message translates to:
  /// **'Is It You?'**
  String get is_it_you;

  /// No description provided for @it_looks_like_the_email.
  ///
  /// In en, this message translates to:
  /// **'It looks like the email'**
  String get it_looks_like_the_email;

  /// No description provided for @you_entered_has_already_been_used_and_has_an_existing_account.
  ///
  /// In en, this message translates to:
  /// **'you entered has already been used and has an existing account.'**
  String get you_entered_has_already_been_used_and_has_an_existing_account;

  /// No description provided for @yes_its_me.
  ///
  /// In en, this message translates to:
  /// **'Yes, It\'s Me'**
  String get yes_its_me;

  /// No description provided for @just_one_step_away.
  ///
  /// In en, this message translates to:
  /// **'Just one step away! This will help make your profile more personalized.'**
  String get just_one_step_away;

  /// No description provided for @please_enter_your_name.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get please_enter_your_name;

  /// No description provided for @user_name.
  ///
  /// In en, this message translates to:
  /// **'User name'**
  String get user_name;

  /// No description provided for @successfully_verified.
  ///
  /// In en, this message translates to:
  /// **'Successfully verified'**
  String get successfully_verified;

  /// No description provided for @email_or_phone.
  ///
  /// In en, this message translates to:
  /// **'Email or Phone'**
  String get email_or_phone;

  /// No description provided for @enter_email_or_password.
  ///
  /// In en, this message translates to:
  /// **'Enter email or Phone Number'**
  String get enter_email_or_password;

  /// No description provided for @it_looks_like_the_phone.
  ///
  /// In en, this message translates to:
  /// **'It looks like the phone'**
  String get it_looks_like_the_phone;

  /// No description provided for @enter_valid_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Enter valid phone number'**
  String get enter_valid_phone_number;

  /// No description provided for @enter_email_address_or_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Enter email address or phone number'**
  String get enter_email_address_or_phone_number;

  /// No description provided for @nutrition_details.
  ///
  /// In en, this message translates to:
  /// **'Nutrition Details'**
  String get nutrition_details;

  /// No description provided for @allergic_ingredients.
  ///
  /// In en, this message translates to:
  /// **'Allergic Ingredients'**
  String get allergic_ingredients;

  /// No description provided for @otp_sign_in.
  ///
  /// In en, this message translates to:
  /// **'OTP Sign in'**
  String get otp_sign_in;

  /// No description provided for @we_have_a_verification_code.
  ///
  /// In en, this message translates to:
  /// **'We’ve sent a verification code to'**
  String get we_have_a_verification_code;

  /// No description provided for @choose_subscription_package.
  ///
  /// In en, this message translates to:
  /// **'Choose Subscription Package'**
  String get choose_subscription_package;

  /// No description provided for @email_verification.
  ///
  /// In en, this message translates to:
  /// **'Email Verification'**
  String get email_verification;

  /// No description provided for @password_reset_successfully.
  ///
  /// In en, this message translates to:
  /// **'Password reset successfully'**
  String get password_reset_successfully;

  /// No description provided for @or_login_with.
  ///
  /// In en, this message translates to:
  /// **'Or Login with'**
  String get or_login_with;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ne'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'ne': return AppLocalizationsNe();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
