import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/core/utils/constants/api_constants.dart';
import 'package:frontend/data/models/error_model.dart';
import 'package:frontend/data/models/job_model.dart';

import 'package:http/http.dart' as http;

class JobProvider with ChangeNotifier {
  List<String>? _jobPlaces;
  bool _isLoading = false;
  ErrorModel? _error;

  List<String>? get jobPlaces => _jobPlaces;
  bool get isLoading => _isLoading;
  ErrorModel? get error => _error;

  JobProvider() {
    fetchJobPlaces();
    fetchJobs();
  }

  Future<void> fetchJobPlaces() async {
    _isLoading = true;
    _error = null;

    notifyListeners();

    try {
      final response =
          await http.get(Uri.parse("$kAppBaseUrl/api/jobs/districts/all"));
      if (response.statusCode == 200) {
        // Decode the JSON response
        final Map<String, dynamic> data = jsonDecode(response.body);

        if (data['status'] == true) {
          _jobPlaces = List<String>.from(data['districts']);
          _error = null; // No error
        }
      } else {
        _error =
            ErrorModel(status: false, message: "Failed to load job places.");
        _jobPlaces = [];
      }
    } catch (e) {
      _error = ErrorModel(status: false, message: e.toString());
      _jobPlaces = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<JobModel>? _jobs;

  List<JobModel>? get jobs => _jobs;

  Future<void> fetchJobs() async {
    _isLoading = true;
    _error = null;

    notifyListeners();

    try {
      final response =
          await http.get(Uri.parse("$kAppBaseUrl/api/jobs/filter/"));

      if (response.statusCode == 200) {
        _jobs = jobModelFromJson(response.body);
        _error = null; // No error
      } else {
        _error = ErrorModel(status: false, message: "Failed to load jobs.");
        _jobs = [];
      }
    } catch (e) {
      _error = ErrorModel(status: false, message: e.toString());
      _jobs = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  JobModel? _job;

  JobModel? get job => _job;

  Future<void> fetchJobById(String jobId) async {
    _isLoading = true;
    _error = null;

    notifyListeners();

    try {
      final response =
          await http.get(Uri.parse("$kAppBaseUrl/api/jobs/$jobId"));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        _job = JobModel.fromJson(jsonData);
        _job = JobModel.fromJson(jsonData);

        _error = null; // No error
      } else {
        _error =
            ErrorModel(status: false, message: "Failed to load job $jobId.");
        print(_error?.toJson());
        _job = null;
      }
    } catch (e) {
      _error = ErrorModel(status: false, message: e.toString());
      _job = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
