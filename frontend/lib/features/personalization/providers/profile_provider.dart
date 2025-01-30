import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/core/utils/constants/api_constants.dart';
import 'package:frontend/data/models/login_model.dart';
import 'package:frontend/data/models/profile_detail_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ProfileProvider extends ChangeNotifier {
  final box = GetStorage();
  bool _isLoading = true;

  bool get isLoading => _isLoading;
  LoginModel? user;

  ProfileProvider() {
    _init();
    fetchProfile();
  }

  Future<void> _init() async {
    _isLoading = true;
    notifyListeners();

    String? userId = box.read("userId");
    if (userId == null) {
      user = null;
    } else {
      String? userData = box.read(userId);
      if (userData != null) {
        user = loginModelFromJson(userData);
      }
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearUserData() {
    user = null;
    notifyListeners();
  }

  ProfileDetailModel? _profile;
  String _errorMessage = '';

  ProfileDetailModel? get profile => _profile;
  String get errorMessage => _errorMessage;

  Future<void> fetchProfile({bool forceRefresh = false}) async {
    if (_profile != null && !forceRefresh) return;

    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final storage = GetStorage();
      String? token = storage.read('token');

      if (token == null) {
        throw Exception("User token not found");
      }

      final response = await http.get(
        Uri.parse('$kAppBaseUrl/api/users/profiles'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _profile = ProfileDetailModel.fromJson(data);
      } else {
        _errorMessage =
            json.decode(response.body)['message'] ?? "Failed to load profile";
      }
    } catch (error) {
      _errorMessage = error.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  // Future<void> fetchProfile() async {
  //   _isLoading = true;
  //   _errorMessage = '';
  //   notifyListeners();

  //   try {
  //     final storage = GetStorage();
  //     String? token = storage.read('token'); // Get token from storage

  //     if (token == null) {
  //       throw Exception("User token not found");
  //     }

  //     final response = await http.get(
  //       Uri.parse('$kAppBaseUrl/api/users/profiles'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token', // Send token in headers
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       _profile = ProfileDetailModel.fromJson(data);
  //     } else {
  //       _errorMessage =
  //           json.decode(response.body)['message'] ?? "Failed to load profile";
  //     }
  //   } catch (error) {
  //     _errorMessage = error.toString();
  //   }

  //   _isLoading = false;
  //   notifyListeners();
  // }

  //for expandable profile sections
  Map<String, bool> _expandedSections = {};

  bool isExpanded(String sectionId) => _expandedSections[sectionId] ?? false;

  void toggleSection(String sectionId) {
    _expandedSections[sectionId] = !isExpanded(sectionId);
    notifyListeners();
  }

  void collapseAll() {
    _expandedSections.clear();
    notifyListeners();
  }
}
