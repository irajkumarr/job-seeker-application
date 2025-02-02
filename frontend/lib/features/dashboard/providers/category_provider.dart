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
  final Set<String> _selectedCategories = {};
  Set<String> get selectedCategories => _selectedCategories;

  bool isMinimizedCategory = false;

  void toggleMinimizedCategory() {
    isMinimizedCategory = !isMinimizedCategory;
    notifyListeners();
  }

  bool isMinimizedSkill = false;

  void toggleMinimizedSkill() {
    isMinimizedSkill = !isMinimizedSkill;
    notifyListeners();
  }

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

  void toggleCategory(String category) {
    if (_selectedCategories.contains(category)) {
      _selectedCategories.remove(category);
    } else if (_selectedCategories.length < 5) {
      _selectedCategories.add(category);
    }
    notifyListeners();
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
        final jsonData = json.decode(response.body);
        _category = CategoryModel.fromJson(jsonData);
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

  //for preferred skills

  final List<String> prefferedSkills = [
    "Computer skill",
    "Marketing Capability",
    "Customer Service Management Skills",
    "Sales Knowledge",
    "Computer Knowledge",
    "Public Speaking",
    "Reporting",
    "Security",
    "Knowledge of customer services",
    "Flexible",
  ];
  final Set<String> _selectedSkills = {};

  Set<String> get selectedSkills => _selectedSkills;

  void toggleSkill(String skill) {
    if (_selectedSkills.contains(skill)) {
      _selectedSkills.remove(skill);
    } else if (_selectedSkills.length < 5) {
      _selectedSkills.add(skill);
    }
    notifyListeners();
  }

  void reset() {
    selectedCategories.clear();
    selectedSkills.clear();
    isMinimizedCategory = false;

    isMinimizedSkill = false;
    notifyListeners();
  }
}
