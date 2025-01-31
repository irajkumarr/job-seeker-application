import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/alert_box/snackbar.dart';
import 'package:frontend/core/utils/constants/api_constants.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class ContactInformationProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> addContactInformation(
      BuildContext context, String data, VoidCallback onSuccess) async {
    setLoading(true);
    try {
      final box = GetStorage();
      String? token = box.read('token');
      final response = await http.post(
        Uri.parse('$kAppBaseUrl/api/users/contact'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: data,
      );

      if (response.statusCode == 201) {
        KSnackbar.CustomSnackbar(
            context, "Contact Information added successfully", KColors.success);
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

  Future<void> updateContactInformation(BuildContext context, String contactId,
      String updatedata, VoidCallback onSuccess) async {
    setLoading(true);
    try {
      final box = GetStorage();
      String? token = box.read('token');
      final response = await http.put(
        Uri.parse('$kAppBaseUrl/api/users/contact/$contactId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: updatedata,
      );
      print(token);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        KSnackbar.CustomSnackbar(context,
            "Contact Information updated successfully", KColors.success);
        onSuccess();
      } else {
        var error = jsonDecode(response.body)['message'];
        print(error.toString());

        KSnackbar.CustomSnackbar(context, error.toString(), KColors.error);
      }
    } catch (error) {
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future<void> deleteContactInformation(
    BuildContext context,
    String accountId,
  ) async {
    setLoading(true);
    try {
      final box = GetStorage();
      String? token = box.read('token');
      final response = await http.delete(
        Uri.parse('$kAppBaseUrl/api/users/contact/$accountId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        KSnackbar.CustomSnackbar(context,
            "Contact Information deleted successfully", KColors.success);

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
