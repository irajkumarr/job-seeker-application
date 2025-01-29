import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/core/utils/constants/api_constants.dart';
import 'package:frontend/core/utils/popups/toast.dart';
import 'package:frontend/data/models/login_model.dart';
import 'package:frontend/features/authentication/providers/login_provider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class ProfileProvider extends ChangeNotifier {
  final box = GetStorage();
  bool isLoading = true;
  LoginModel? user;

  ProfileProvider() {
    _init();
  }

  Future<void> _init() async {
    isLoading = true;
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

    isLoading = false;
    notifyListeners();
  }

  void clearUserData() {
    user = null;
    notifyListeners();
  }
}
