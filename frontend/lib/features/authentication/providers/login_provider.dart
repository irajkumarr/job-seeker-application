import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/alert_box/snackbar.dart';
import 'package:frontend/core/utils/constants/api_constants.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/popups/toast.dart';
import 'package:frontend/data/models/error_model.dart';
import 'package:frontend/data/models/login_model.dart';
import 'package:frontend/features/personalization/providers/profile_provider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class LoginProvider with ChangeNotifier {
  //variables

  final box = GetStorage();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  LoginModel? user; // Add user variable

  set setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // bool rememberMe = false;
  bool _rememberMe = false; // Default is false

  bool get rememberMe => _rememberMe;

  // void toggleRememberMe() {
  //   rememberMe = !rememberMe;
  //   notifyListeners();
  // }
  LoginProvider() {
    // Load the state when the provider is initialized
    _rememberMe = box.read("remember_me") ?? false;
    getUserInfo();
  }

  void toggleRememberMe() {
    _rememberMe = !_rememberMe;
    box.write("remember_me", _rememberMe); // Save state to GetStorage
    notifyListeners();
  }

  /// **Save Credentials if Remember Me is Checked**
  void saveCredentials(String mobile, String password) {
    if (rememberMe) {
      box.write("saved_mobile", mobile);
      box.write("saved_password", password);
      box.write("remember_me", true);
    } else {
      box.remove("saved_mobile");
      box.remove("saved_password");
      box.write("remember_me", false);
    }
  }

  /// **Retrieve Credentials**
  Map<String, String?> getSavedCredentials() {
    bool isRemembered = box.read("remember_me") ?? false;
    if (isRemembered) {
      return {
        "mobile": box.read("saved_mobile"),
        "password": box.read("saved_password"),
      };
    }
    return {"mobile": null, "password": null};
  }

  /// **Login API Call**
  Future<void> login(
      BuildContext context, String data, String mobile, String password) async {
    setLoading = true;
    Uri url = Uri.parse("$kAppBaseUrl/login");
    Map<String, String> headers = {"Content-Type": "application/json"};

    try {
      var response = await http.post(url, headers: headers, body: data);

      if (response.statusCode == 200) {
        LoginModel data = loginModelFromJson(response.body);
        String userId = data.id;
        String userData = jsonEncode(data);

        box.write(userId, userData);
        box.write("token", data.userToken);
        box.write("userId", data.id);

        saveCredentials(
            mobile, password); // Save credentials if Remember Me is checked
        Provider.of<ProfileProvider>(context, listen: false)
            .fetchProfile(forceRefresh: true);
        setLoading = false;
        context.pop();
        // context.read<NavigationProvider>().onTap(3);
        KSnackbar.CustomSnackbar(context, "Login Successfully!", Colors.green);
      } else {
        setLoading = false;
        var error = errorModelFromJson(response.body);
        KSnackbar.CustomSnackbar(context, error.message, KColors.error);
      }
    } catch (e) {
      setLoading = false;
      showToast(e.toString());
    }
  }

  Future<void> logout(BuildContext context) async {
    while (Navigator.canPop(context)) {
      context.pop();
    }

    setLoading = true;
    try {
      bool isRemembered = box.read("remember_me") ?? false;
      String? savedMobile = box.read("saved_mobile");
      String? savedPassword = box.read("saved_password");

      await box.erase(); // Clear all stored data
      user = null;
      Provider.of<ProfileProvider>(context, listen: false).profile == null;

      if (isRemembered) {
        // Restore saved credentials
        box.write("saved_mobile", savedMobile);
        box.write("saved_password", savedPassword);
        box.write("remember_me", true);
      }

      KSnackbar.CustomSnackbar(context, "Log out Successfully!", Colors.green);
    } catch (error) {
      showToast("Error during logout: $error");
    } finally {
      setLoading = false;
      notifyListeners();
    }
  }

  //getting user data
  LoginModel? getUserInfo() {
    String? userId = box.read("userId");
    String? data;

    if (userId != null) {
      data = box.read(userId);
    }

    if (data != null) {
      return loginModelFromJson(data);
    }

    return null;
  }

  //clearing data from loginresponse
  Future<void> clearUserData() async {
    user = null;
    notifyListeners();
  }

  Future<void> clearRememberMeData() async {
    await box.remove("saved_mobile");
    await box.remove("saved_password");
    await box.write("remember_me", false);
  }
}
