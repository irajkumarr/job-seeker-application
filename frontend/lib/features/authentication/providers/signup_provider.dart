import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/alert_box/snackbar.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/api_constants.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/popups/toast.dart';
import 'package:frontend/data/models/error_model.dart';
import 'package:frontend/data/models/login_model.dart';
import 'package:frontend/navigation_menu.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class SignupProvider with ChangeNotifier {
  // variables
  final box = GetStorage();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  LoginModel? user;

  set setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool termsAndConditions = true;

  void toggleTermsAndConditions() {
    termsAndConditions = !termsAndConditions;
    notifyListeners();
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

        // showToast(" Registered Sucessfully!");
        KSnackbar.Snackbar(
            context, "Registered Sucessfully!", false, Colors.green);
        context.goNamed(RoutesConstant.signupPreferred);
      } else {
        setLoading = false;
        var error = errorModelFromJson(response.body);

        // showToast(error.message);
        KSnackbar.Snackbar(context, error.message, false, KColors.error);
      }
    } catch (e) {
      setLoading = false;
      showToast(e.toString());
    }
  }
}
