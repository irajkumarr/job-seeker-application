import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/alert_box/snackbar.dart';
import 'package:frontend/core/utils/constants/api_constants.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/data/models/error_model.dart';
import 'package:frontend/data/models/job_application_model.dart';
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

  List<JobApplicationModel>? _jobApplications;

  List<JobApplicationModel>? get jobApplications => _jobApplications;

  ErrorModel? _error;

  ErrorModel? get error => _error;

  Future<void> fetchJobApplications() async {
    setLoading(true);
    _error = null;

    notifyListeners();

    final String? token = _storage.read('token');
    try {
      final response = await http.get(
        Uri.parse("$kAppBaseUrl/api/applications"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        _jobApplications = jobApplicationModelFromJson(response.body);
        _error = null; // No error
      } else {
        _error = ErrorModel(
            status: false, message: "Failed to load job application.");
        _jobApplications = [];
      }
    } catch (e) {
      _error = ErrorModel(status: false, message: e.toString());
      _jobApplications = [];
    } finally {
      setLoading(false);
    }
  }
}
