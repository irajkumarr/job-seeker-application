import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/data/models/blog_model.dart';
import 'package:frontend/data/models/error_model.dart';

import 'package:http/http.dart' as http;

class BlogProvider with ChangeNotifier {
  BlogModel? _blogs;
  bool _isLoading = false;
  ErrorModel? _error;

  BlogModel? get blogs => _blogs;
  bool get isLoading => _isLoading;
  ErrorModel? get error => _error;

  BlogProvider() {
    fetchBlogs();
  }

  Future<void> fetchBlogs() async {
    _isLoading = true;
    _error = null;

    notifyListeners();

    try {
      final response = await http.get(
          Uri.parse("https://api.rojgari.com/api/v1/blogs/?limit=7"),
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
          });

      if (response.statusCode == 200) {
        // print(response.body);
        _blogs = blogModelFromJson(response.body);
        print(_blogs!.toJson());
        _error = null; // No error
      } else {
        _error = ErrorModel(status: false, message: "Failed to load blogs.");
        _blogs = null;
      }
    } catch (e) {
      _error = ErrorModel(status: false, message: e.toString());
      _blogs = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
