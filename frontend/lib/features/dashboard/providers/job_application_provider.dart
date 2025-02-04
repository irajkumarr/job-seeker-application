import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/alert_box/snackbar.dart';
import 'package:frontend/core/utils/constants/api_constants.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class JobApplicationProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  final GetStorage _storage = GetStorage();
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> applyJob({
    required BuildContext context,
    required String jobId,
    required VoidCallback onSuccess,
  }) async {
    final String? token = _storage.read('token');
    setLoading(true);

    final url = Uri.parse('$kAppBaseUrl/api/applications/');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'jobId': jobId,
        }),
      );

      if (response.statusCode == 201) {
        KSnackbar.CustomSnackbar(context, "Job Applied", KColors.primary);
        onSuccess();
      } else {
        final errorData = jsonDecode(response.body);

        KSnackbar.CustomSnackbar(context,
            errorData['message'] ?? 'Something went wrong', KColors.error);
      }
    } catch (error) {
      rethrow;
    } finally {
      setLoading(false);
    }
  }
}
