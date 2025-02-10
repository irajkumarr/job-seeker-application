import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/alert_box/snackbar.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/api_constants.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/data/models/login_model.dart';
import 'package:frontend/data/models/profile_detail_model.dart';
import 'package:get_storage/get_storage.dart';

import 'package:frontend/data/models/user_profile_request.dart' as userProfile;
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class ProfileProvider extends ChangeNotifier {
  final box = GetStorage();
  bool _isLoading = true;

  bool get isLoading => _isLoading;
  LoginModel? user;

  ProfileProvider() {
    _init();
    fetchProfile(forceRefresh: true);
  }

  Future<void> _init() async {
    _isLoading = true;
    notifyListeners();

    String? userId = box.read("userId");
    if (userId == null) {
      user = null;
    } else {
      String? userData = box.read(userId);
      if (userData != null) {
        user = loginModelFromJson(userData);
      }
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearUserData() {
    user = null;
    notifyListeners();
  }

  ProfileDetailModel? _profile;
  String _errorMessage = '';

  ProfileDetailModel? get profile => _profile;
  String get errorMessage => _errorMessage;

  Future<void> fetchProfile({bool forceRefresh = false}) async {
    if (_profile != null && !forceRefresh) return;

    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final storage = GetStorage();
      // String? token =
      //     Provider.of<LoginProvider>(navigatorKey.currentState!.context)
      //         .box
      //         .read("token");
      // print(token);
      String? token = storage.read('token');

      if (token == null) {
        throw Exception("User token not found");
      }

      final response = await http.get(
        Uri.parse('$kAppBaseUrl/api/users/profiles'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _profile = ProfileDetailModel.fromJson(data);
      } else {
        _errorMessage =
            json.decode(response.body)['message'] ?? "Failed to load profile";
      }
    } catch (error) {
      _errorMessage = error.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  String? _profileImage;
  String? get profileImage => _profileImage;
  Future<void> updateProfileImage(BuildContext context, File imageFile) async {
    _isLoading = true;
    notifyListeners();
    try {
      String? token = box.read("token");

      if (token == null) {
        throw Exception("User not logged in.");
      }

      var request = http.MultipartRequest(
        "PUT",
        Uri.parse("$kAppBaseUrl/api/users/profileImage/"),
      );

      request.headers["Authorization"] = "Bearer $token";
      request.files.add(
        await http.MultipartFile.fromPath("profileImage", imageFile.path),
      );

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonResponse = jsonDecode(responseBody);

        if (jsonResponse["success"]) {
          _profileImage = jsonResponse["data"]["profileImage"];
          box.write("profileImage", _profileImage);
          notifyListeners();
        } else {
          KSnackbar.CustomSnackbar(
              context,
              jsonResponse["message"] ?? "Failed to update image",
              KColors.error);
          throw Exception(jsonResponse["message"] ?? "Failed to update image");
        }
      } else {
        KSnackbar.CustomSnackbar(
            context, "Error: ${response.statusCode}", KColors.error);
        throw Exception("Error: ${response.statusCode}${response.stream}");
      }
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //preferred categories
  Future<void> updatePreferredCategories(
    BuildContext context,
    List<String> preferredCategories,
    VoidCallback onSuccess,
  ) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final storage = GetStorage();
      String? token = storage.read('token');

      if (token == null) {
        throw Exception("User token not found");
      }

      final response = await http.put(
        Uri.parse('$kAppBaseUrl/api/users/profile'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'preferredCategories': preferredCategories,
        }),
      );

      if (response.statusCode == 200) {
        // final data = json.decode(response.body);
        KSnackbar.CustomSnackbar(
            context, "Successfully updated!", KColors.primary);

        onSuccess();
      } else {
        _errorMessage = json.decode(response.body)['message'] ??
            "Failed to update categories";

        KSnackbar.CustomSnackbar(context, _errorMessage, KColors.error);
      }
    } catch (error) {
      _errorMessage = error.toString();
      KSnackbar.CustomSnackbar(context, _errorMessage, KColors.error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //preferred skills
  Future<void> updateSkills(
    BuildContext context,
    List<String> skills,
    VoidCallback onSuccess,
  ) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final storage = GetStorage();
      String? token = storage.read('token');

      if (token == null) {
        throw Exception("User token not found");
      }

      final response = await http.put(
        Uri.parse('$kAppBaseUrl/api/users/profile'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'skills': skills,
        }),
      );

      if (response.statusCode == 200) {
        // final data = json.decode(response.body);
        KSnackbar.CustomSnackbar(
            context, "Successfully updated!", KColors.primary);

        onSuccess();
      } else {
        _errorMessage =
            json.decode(response.body)['message'] ?? "Failed to update skills";

        KSnackbar.CustomSnackbar(context, _errorMessage, KColors.error);
      }
    } catch (error) {
      _errorMessage = error.toString();
      KSnackbar.CustomSnackbar(context, _errorMessage, KColors.error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //job preferecnes
  Future<void> updateJobPreference(
    BuildContext context,
    userProfile.JobPreference data,
    VoidCallback onSuccess,
  ) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final storage = GetStorage();
      String? token = storage.read('token');

      if (token == null) {
        throw Exception("User token not found");
      }

      final response =
          await http.put(Uri.parse('$kAppBaseUrl/api/users/profile'),
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $token',
              },
              body: json.encode(data.toJson()));

      if (response.statusCode == 200) {
        // final data = json.decode(response.body);
        KSnackbar.CustomSnackbar(
            context, "Successfully updated!", KColors.primary);

        onSuccess();
      } else {
        _errorMessage =
            json.decode(response.body)['message'] ?? "Failed to update";

        KSnackbar.CustomSnackbar(context, _errorMessage, KColors.error);
      }
    } catch (error) {
      _errorMessage = error.toString();
      KSnackbar.CustomSnackbar(context, _errorMessage, KColors.error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateName(
    BuildContext context,
    String data,
    VoidCallback onSuccess,
  ) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final storage = GetStorage();
      String? token = storage.read('token');

      if (token == null) {
        throw Exception("User token not found");
      }

      final response = await http.put(
        Uri.parse('$kAppBaseUrl/api/users/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({"name": data}), // ✅ Ensure body is encoded properly
      );

      if (response.statusCode == 200) {
        onSuccess();
      } else {
        _errorMessage =
            json.decode(response.body)['message'] ?? "Failed to update";
        KSnackbar.CustomSnackbar(context, _errorMessage, KColors.error);
      }
    } catch (error) {
      _errorMessage = error.toString();
      KSnackbar.CustomSnackbar(context, _errorMessage, KColors.error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updatePersonalInformation(
    BuildContext context,
    userProfile.PersonalDetails data,
    VoidCallback onSuccess,
  ) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final storage = GetStorage();
      String? token = storage.read('token');

      if (token == null) {
        throw Exception("User token not found");
      }

      print("Sending Personal Details: ${json.encode(data.toJson())}");

      final response = await http.put(
        Uri.parse('$kAppBaseUrl/api/users/profile'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(data.toJson()),
      );

      if (response.statusCode == 200) {
        KSnackbar.CustomSnackbar(
            context, "Successfully updated!", KColors.primary);
        onSuccess();
      } else {
        _errorMessage =
            json.decode(response.body)['message'] ?? "Failed to update";
        KSnackbar.CustomSnackbar(context, _errorMessage, KColors.error);
      }
    } catch (error) {
      _errorMessage = error.toString();
      KSnackbar.CustomSnackbar(context, _errorMessage, KColors.error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //update password
  Future<void> changePassword(
      BuildContext context, String oldPassword, String newPassword) async {
    _isLoading = true;
    notifyListeners();
    final url = Uri.parse('$kAppBaseUrl/api/users/change-password');
    final box = GetStorage();
    final String? token = box.read("token");
    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        }),
      );
      if (response.statusCode == 200) {
        _isLoading = false;
        notifyListeners();
        // Handle success
        final data = json.decode(response.body);
        KSnackbar.CustomSnackbar(context, data['message'], KColors.primary);
        context.pop();
        context.pushNamed(RoutesConstant.login);
      } else {
        // Handle error
        _isLoading = false;
        notifyListeners();
        final errorResponse = json.decode(response.body);
        KSnackbar.CustomSnackbar(
            context, errorResponse['message'], KColors.error);
        context.pop();
      }
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      print('Error: $error');
      KSnackbar.CustomSnackbar(context,
          "An error occurred while changing the password", KColors.error);
      context.pop();
    }
  }

  //for expandable profile sections
  Map<String, bool> _expandedSections = {};

  bool isExpanded(String sectionId) => _expandedSections[sectionId] ?? false;

  void toggleSection(String sectionId) {
    _expandedSections[sectionId] = !isExpanded(sectionId);
    notifyListeners();
  }

  void collapseAll() {
    _expandedSections.clear();
    notifyListeners();
  }
}
