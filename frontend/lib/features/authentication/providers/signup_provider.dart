import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/alert_box/snackbar.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/api_constants.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/popups/toast.dart';
import 'package:frontend/data/models/error_model.dart';
import 'package:frontend/data/models/login_model.dart';
import 'package:frontend/data/models/user_profile_request.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';

import 'package:http/http.dart' as http;

class SignupProvider with ChangeNotifier {
  // variables
  final box = GetStorage();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  LoginModel? user;

  String _error = '';

  String get error => _error;

  set setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool termsAndConditions = true;

  void toggleTermsAndConditions() {
    termsAndConditions = !termsAndConditions;
    notifyListeners();
  }

  // Check if mobile number exists
  Future<bool> checkMobileNumber(String mobileNumber) async {
    try {
      setLoading = true;
      _error = '';
      notifyListeners();

      final response = await http.post(
        Uri.parse('$kAppBaseUrl/check-mobile'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'mobileNumber': mobileNumber}),
      );

      final data = json.decode(response.body);

      if (response.statusCode == 400) {
        _error = data['message'] ?? 'Mobile number already exists';
        notifyListeners();
        return false;
      }

      return true;
    } catch (e) {
      _error = 'Something went wrong. Please try again.';
      notifyListeners();
      return false;
    } finally {
      setLoading = false;
      notifyListeners();
    }
  }

//signup
  Future<void> signup(BuildContext context, String data) async {
    setLoading = true;
    Uri url = Uri.parse("$kAppBaseUrl/register");
    Map<String, String> headers = {"Content-Type": "application/json"};

    try {
      var response = await http.post(url, headers: headers, body: data);

      if (response.statusCode == 201) {
        LoginModel data = loginModelFromJson(response.body);
        String userId = data.id;
        String userData = jsonEncode(data);

        box.write(userId, userData);
        box.write("token", data.userToken);
        box.write("userId", data.id);

        setLoading = false;

        // KSnackbar.Snackbar(
        //     context, "Registered Sucessfully!", false, Colors.green);
        context.goNamed(RoutesConstant.signupPreferred);
      } else {
        setLoading = false;
        var error = errorModelFromJson(response.body);

        // showToast(error.message);
        KSnackbar.CustomSnackbar(context, error.message, KColors.error);
      }
    } catch (e) {
      setLoading = false;
      showToast(e.toString());
    }
  }

  String? _errorMessage;

  String? get errorMessage => _errorMessage;
  //create profile forms
  Future<bool> createProfile(UserProfileRequest profile) async {
    setLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final String? token = box.read("token");
      if (token == null) {
        _isLoading = false;
        _errorMessage = "User not authenticated";
        notifyListeners();
        return false;
      }

      final url = Uri.parse("$kAppBaseUrl/api/users/profile/");
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(profile.toJson()),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        setLoading = false;
        notifyListeners();
        return true;
      } else {
        setLoading = false;
        _errorMessage = data["message"] ?? "Something went wrong";
        notifyListeners();
        return false;
      }
    } catch (e) {
      setLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }
}
