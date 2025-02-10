import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/alert_box/snackbar.dart';
import 'package:frontend/core/utils/constants/api_constants.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/data/models/user_saved_jobs_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class SavedJobsProvider with ChangeNotifier {
  bool _isLoading = false;
  List<UserSavedJobsModel> _savedJobs = []; // Store the saved jobs data
  List<String> savedJobIds = []; // Store saved job IDs in local storage
  final GetStorage _storage = GetStorage();

  bool get isLoading => _isLoading;
  List<UserSavedJobsModel> get savedJobs => _savedJobs;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  SavedJobsProvider() {
    _loadSavedJobIdsFromLocalStorage();
    // getUserSavedJobs();
  }

  /// **Load saved job IDs from local storage**
  void _loadSavedJobIdsFromLocalStorage() {
    List<dynamic>? storedJobIds = _storage.read<List<dynamic>>('savedJobIds');
    if (storedJobIds != null) {
      savedJobIds = List<String>.from(storedJobIds);
    }
    notifyListeners();
  }

  /// **Save job IDs to local storage**
  void _saveJobIdsToLocalStorage() {
    _storage.write('savedJobIds', savedJobIds);
  }

  /// **Fetch user saved jobs from API**
  Future<void> getUserSavedJobs() async {
    setLoading(true);
    try {
      final String? token = _storage.read('token');

      final response = await http.get(
        Uri.parse('$kAppBaseUrl/api/users/saved-jobs'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> savedJobsData = jsonDecode(response.body);
        _savedJobs = savedJobsData
            .map((jobData) => UserSavedJobsModel.fromJson(jobData))
            .toList();

        // Extract job IDs from the response and store them locally
        savedJobIds = _savedJobs.map((job) => job.id!).toList();
        _saveJobIdsToLocalStorage(); // Save to local storage
        notifyListeners();
      }
    } catch (error) {
      rethrow;
    } finally {
      setLoading(false);
    }
  }


  /// **Handle saving/removing a job**
  Future<void> handleSavedJob(BuildContext context, String jobId) async {
    setLoading(true);
    try {
      final String? token = _storage.read('token');

      final response = await http.post(
        Uri.parse('$kAppBaseUrl/api/users/saved-jobs'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'jobId': jobId}),
      );

      if (response.statusCode == 200) {
        var message = jsonDecode(response.body)['message'];

        // Toggle job in saved list
        if (savedJobIds.contains(jobId)) {
          savedJobIds.remove(jobId); // Remove job if already saved
        } else {
          savedJobIds.add(jobId); // Add job if not saved
        }

        _saveJobIdsToLocalStorage(); // Save updated list to local storage
        notifyListeners(); // Update UI

        if (context.mounted) {
          KSnackbar.CustomSnackbar(context, message, KColors.primary);
        }

        getUserSavedJobs(); // Refresh saved jobs list from API
      } else {
        var error = jsonDecode(response.body)['message'];
        if (context.mounted) {
          KSnackbar.CustomSnackbar(context, error.toString(), KColors.error);
        }
      }
    } catch (error) {
      if (context.mounted) {
        KSnackbar.CustomSnackbar(context, error.toString(), KColors.error);
      }
      rethrow;
    } finally {
      setLoading(false);
    }
  }
}
