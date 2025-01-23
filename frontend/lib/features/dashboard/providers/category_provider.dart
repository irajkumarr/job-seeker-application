import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/core/utils/constants/api_constants.dart';
import 'package:frontend/data/models/category_model.dart';
import 'package:frontend/data/models/error_model.dart';

import 'package:http/http.dart' as http;

class CategoryProvider with ChangeNotifier {
  List<CategoryModel>? _categories;
  bool _isLoading = false;
  ErrorModel? _error;

  List<CategoryModel>? get categories => _categories;
  bool get isLoading => _isLoading;
  ErrorModel? get error => _error;

  CategoryProvider() {
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    _isLoading = true;
    _error = null;

    notifyListeners();

    try {
      final response =
          await http.get(Uri.parse("$kAppBaseUrl/api/industries/all"));

      if (response.statusCode == 200) {
        _categories = categoryModelFromJson(response.body);
        _error = null; // No error
      } else {
        _error =
            ErrorModel(status: false, message: "Failed to load categories.");
        _categories = [];
      }
    } catch (e) {
      _error = ErrorModel(status: false, message: e.toString());
      _categories = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  CategoryModel? _category;

  CategoryModel? get category => _category;

  Future<void> fetchCategoryById(String categoryId) async {
    _isLoading = true;
    _error = null;
    _category = null;
    notifyListeners();

    try {
      final response =
          await http.get(Uri.parse("$kAppBaseUrl/api/categories/$categoryId"));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body); // Decode the JSON response
        _category = CategoryModel.fromJson(jsonData); // Convert JSON to model
        _error = null;
        _isLoading = false;
        notifyListeners();
      } else {
        _error = ErrorModel(status: false, message: "Failed to load category.");
        _category = null;
      }
    } catch (e) {
      _error = ErrorModel(status: false, message: e.toString());
      _category = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
