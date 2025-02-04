import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/core/utils/constants/api_constants.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class JobApplicationStatusProvider with ChangeNotifier {
  bool _isLoading = false;
  bool _hasApplied = false;
  String? _applicationId;

  bool get isLoading => _isLoading;
  bool get hasApplied => _hasApplied;
  String? get applicationId => _applicationId;

  final GetStorage _storage = GetStorage();

  Future<void> checkJobApplicationStatus({
    required BuildContext context,
    required String jobId,
  }) async {
    final String? token = _storage.read('token');
    
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('$kAppBaseUrl/api/applications/jobs/$jobId/application-status'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        _hasApplied = responseData['hasApplied'];
        _applicationId = responseData['applicationId'];
      } else {
        _hasApplied = false;
        _applicationId = null;
      }
    } catch (error) {
      _hasApplied = false;
      _applicationId = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}