import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/alert_box/snackbar.dart';
import 'package:frontend/core/utils/constants/api_constants.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/data/models/job_model.dart';
import 'package:frontend/data/models/user_saved_jobs_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class MatchedJobsProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  final GetStorage _storage = GetStorage();
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  MatchedJobsProvider() {
    getUserMatchedJobs();
  }

  List<JobModel> _matchedJobs = [];

  List<JobModel> get matchedJobs => _matchedJobs;

  /// **Fetch user matched jobs from API**
  Future<void> getUserMatchedJobs() async {
    setLoading(true);
    try {
      final String? token = _storage.read('token');

      final response = await http.get(
        Uri.parse('$kAppBaseUrl/api/users/profile/matched-jobs'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> matchedJobsData = jsonDecode(response.body);
        _matchedJobs = matchedJobsData
            .map((jobData) => JobModel.fromJson(jobData))
            .toList();

        notifyListeners();
      }
    } catch (error) {
      rethrow;
    } finally {
      setLoading(false);
    }
  }
}
