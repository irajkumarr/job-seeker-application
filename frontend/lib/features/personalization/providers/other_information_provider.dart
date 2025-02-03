import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/alert_box/snackbar.dart';
import 'package:frontend/core/utils/constants/api_constants.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/data/models/other_information_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class OtherInformationProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> updateOtherInformation(BuildContext context,
      OtherInformationModel otherInfo, VoidCallback onSuccess) async {
    setLoading(true);
    try {
      final box = GetStorage();
      String? token = box.read('token');
      if (token == null) throw Exception("User not authenticated!");

      final response = await http.put(
        Uri.parse("$kAppBaseUrl/api/users/otherInformation"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(otherInfo.toJson()),
      );

      final data = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // _otherInformation = OtherInformationModel.fromJson(data);
        KSnackbar.CustomSnackbar(
            context, "Successfully uploaded!", KColors.primary);
        onSuccess();
      } else {
        KSnackbar.CustomSnackbar(context, data['message'], KColors.error);
      }
    } catch (e) {
      KSnackbar.CustomSnackbar(
          context, "Error updating information: $e", KColors.error);
    } finally {
      setLoading(false);
    }
  }
}
