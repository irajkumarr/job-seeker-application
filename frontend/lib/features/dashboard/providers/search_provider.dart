import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/core/utils/constants/api_constants.dart';
import 'package:frontend/data/models/job_model.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class SearchProvider with ChangeNotifier {
  final GetStorage _storage = GetStorage();
  final String _historyKey = 'searchHistory';

  String _searchText = '';
  bool _isLoading = false;
  bool _isTrigger = false;
  List<JobModel>? searchResults;
  List<String> _searchHistory = [];

  String get searchText => _searchText;
  bool get isLoading => _isLoading;
  bool get isTrigger => _isTrigger;
  List<String> get searchHistory =>
      List.unmodifiable(_searchHistory); // Immutable list

  SearchProvider() {
    loadSearchHistory(); // Load persisted search history on initialization
  }

  set setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set setTrigger(bool value) {
    _isTrigger = value;
    notifyListeners();
  }

  //  String _searchText = '';
  bool _isTextEmpty = true;

  // String get searchText => _searchText;
  bool get isTextEmpty => _isTextEmpty;

  void updateSearchText(String text) {
    _searchText = text;
    _isTextEmpty = text.isEmpty;

    notifyListeners();
  }

  // void clearSearch() {
  //   _searchText = '';
  //   notifyListeners();
  // }

  void clearSearch() {
    _searchText = '';
    searchResults = null;
    setTrigger = false;
    _isTextEmpty = true;
    notifyListeners();
  }

  // void updateSearchText(String text) {
  //   _searchText = text;
  //   notifyListeners();
  // }

  Future<void> searchJobs(String text) async {
    setLoading = true;
    Uri url = Uri.parse("$kAppBaseUrl/api/jobs/search/$text");
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        searchResults = jobModelFromJson(response.body);
        addSearchToHistory(text); // Save the search text to history
      } else {
        // Handle error
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    setLoading = false;
    setTrigger = true; // Set trigger to true after search results come in
  }

  void addSearchToHistory(String query) {
    if (!_searchHistory.contains(query)) {
      _searchHistory.insert(0, query); // Add to the start of the list
      if (_searchHistory.length > 10) {
        _searchHistory.removeLast(); // Limit history to 10 items
      }
      saveSearchHistory(); // Persist the updated history
      notifyListeners();
    }
  }

  void clearSearchHistory() {
    _searchHistory.clear();
    saveSearchHistory(); // Persist the cleared history
    notifyListeners();
  }

  void loadSearchHistory() {
    _searchHistory =
        _storage.read<List<dynamic>>(_historyKey)?.cast<String>() ?? [];
    notifyListeners();
  }

  void saveSearchHistory() {
    _storage.write(_historyKey, _searchHistory);
  }
}