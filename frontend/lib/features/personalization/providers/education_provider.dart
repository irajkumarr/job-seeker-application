import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/alert_box/snackbar.dart';
import 'package:frontend/core/utils/constants/api_constants.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class EducationProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> addEducation(
      BuildContext context, String data, VoidCallback onSuccess) async {
    setLoading(true);
    try {
      final box = GetStorage();
      String? token = box.read('token');
      final response = await http.post(
        Uri.parse('$kAppBaseUrl/api/users/education'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: data,
      );

      if (response.statusCode == 201) {
        KSnackbar.CustomSnackbar(
            context, "Education added successfully", KColors.success);
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

  Future<void> updateEducation(BuildContext context, String educationId,
      String updatedata, VoidCallback onSuccess) async {
    setLoading(true);
    try {
      final box = GetStorage();
      String? token = box.read('token');
      final response = await http.put(
        Uri.parse('$kAppBaseUrl/api/users/education/$educationId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: updatedata,
      );
      if (response.statusCode == 200) {
        KSnackbar.CustomSnackbar(
            context, "Education updated successfully", KColors.success);
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

  Future<void> deleteEducation(
    BuildContext context,
    String educationId,
    VoidCallback onSuccess,
  ) async {
    setLoading(true);
    try {
      final box = GetStorage();
      String? token = box.read('token');
      final response = await http.delete(
        Uri.parse('$kAppBaseUrl/api/users/education/$educationId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        KSnackbar.CustomSnackbar(context,
            "Successfully deleted!", KColors.primary);
        onSuccess();
        context.pop();
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
}
