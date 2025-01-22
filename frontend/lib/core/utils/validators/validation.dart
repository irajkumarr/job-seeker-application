// import 'package:frontend/core/routes/app_routes.dart';
// import 'package:frontend/l10n/l10n.dart';

// // final l10n = AppLocalizations.of(navigatorKey.currentState!.context)!;

// class KValidator {
//   //empty text validation
//   static String? validateEmptyText(String? fieldName, String? value) {
//     if (value == null || value.isEmpty) {
//       return "$fieldName ${l10n.is_required}";
//     }
//     return null;
//   }

//   /// validate email
//   static String? validateEmail(String? value) {
//     if (value == null || value.isEmpty) {
//       return '${l10n.email_field_is_required}';
//       // return null;
//     }

//     // Regular expression for email validation
//     final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

//     if (!emailRegExp.hasMatch(value)) {
//       return '${l10n.enter_valid_email_address}';
//     }

//     return null;
//   }

//   static String? validatePassword(String? value) {
//     if (value == null || value.isEmpty) {
//       return '${l10n.password_field_is_required}';
//     }

//     // Check for minimum password length
//     if (value.length < 6) {
//       return '${l10n.password_should_be_8_characters}';
//     }

//     // Check for uppercase letters
//     // if (!value.contains(RegExp(r'[A-Z]'))) {
//     //   return 'Password must contain at least one uppercase letter.';
//     // }

//     // // Check for numbers
//     // if (!value.contains(RegExp(r'[0-9]'))) {
//     //   return 'Password must contain at least one number.';
//     // }

//     // Check for special characters
//     // if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
//     //   return 'Password must contain at least one special character.';
//     // }

//     return null;
//   }

//   static String? validatePhoneNumber(String? value) {
//     if (value == null || value.isEmpty) {
//       return '${l10n.phone_number_field_is_required}';
//     }

//     // Regular expression for phone number validation (assuming a 10-digit Nepali phone number format)
//     final phoneRegExp = RegExp(r'^\d{10}$');

//     if (!phoneRegExp.hasMatch(value)) {
//       return '${l10n.enter_a_valid_phone_number}';
//     }

//     return null;
//   }

//   static String? validateEmailOrPhone(String? value) {
//     // Regular expression for validating email
//     String emailPattern =
//         r"^[a-zA-Z0-9.a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$";

//     // Regular expression for validating phone number (Nepal's pattern)
//     String phonePattern = r"^[0-9]{10}$"; // Assumes a 10-digit number

//     if (value == null || value.isEmpty) {
//       return "Email or Phone cannot be empty";
//     }

//     RegExp emailRegex = RegExp(emailPattern);
//     RegExp phoneRegex = RegExp(phonePattern);

//     if (emailRegex.hasMatch(value) || phoneRegex.hasMatch(value)) {
//       return null; // Valid input
//     } else {
//       return "Please enter a valid email or phone number";
//     }
//   }

// // Add more custom validators as needed for your specific requirements.
// }
