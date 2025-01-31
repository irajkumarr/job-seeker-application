import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/alert_box/snackbar.dart';
import 'package:frontend/core/utils/constants/api_constants.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/data/models/social_account_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class SocialAccountProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> addSocialAccount(
      BuildContext context, String data, VoidCallback onSuccess) async {
    setLoading(true);
    try {
      final box = GetStorage();
      String? token = box.read('token');
      final response = await http.post(
        Uri.parse('$kAppBaseUrl/api/users/socialAccount'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body:data,
      );

      if (response.statusCode == 201) {
        KSnackbar.CustomSnackbar(
            context, "Social Account added successfully", KColors.success);
        onSuccess();
      } else {
        var error = jsonDecode(response.body)['message'];

        KSnackbar.CustomSnackbar(context, error.toString(), KColors.error);
      }
    } catch (error) {
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  // Future<void> updateSocialAccount(String id, SocialAccount account) async {
  //   setLoading(true);
  //   try {
  //     final token = await AuthHelper.getToken();
  //     final response = await http.put(
  //       Uri.parse('${ApiEndpoints.baseUrl}/social-accounts/$id'),
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //         'Content-Type': 'application/json',
  //       },
  //       body: jsonEncode(account.toJson()),
  //     );

  //     if (response.statusCode != 200) {
  //       throw Exception(jsonDecode(response.body)['message']);
  //     }
  //   } catch (error) {
  //     rethrow;
  //   } finally {
  //     setLoading(false);
  //   }
  // }

  // Future<void> deleteSocialAccount(String id) async {
  //   setLoading(true);
  //   try {
  //     final token = await AuthHelper.getToken();
  //     final response = await http.delete(
  //       Uri.parse('${ApiEndpoints.baseUrl}/social-accounts/$id'),
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //       },
  //     );

  //     if (response.statusCode != 200) {
  //       throw Exception(jsonDecode(response.body)['message']);
  //     }
  //   } catch (error) {
  //     rethrow;
  //   } finally {
  //     setLoading(false);
  //   }
  // }
}
