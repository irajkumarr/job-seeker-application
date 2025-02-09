import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/core/routes/app_routes.dart';
import 'package:frontend/core/utils/constants/api_constants.dart';
import 'package:frontend/data/models/job_model.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

// class FilterProvider with ChangeNotifier {
//   String? selectedLocation;
//   String? selectedCategory;
//   String? selectedEducation;
//   String? selectedSalary;
//   String? selectedExperience;
//   String? selectedIndustryTitle;

//   void setLocation(String? location) {
//     selectedLocation = location;
//     notifyListeners();
//   }

//   void setCategory(String? category) {
//     selectedCategory = category;
//     notifyListeners();
//   }

//   void setEducation(String? education) {
//     selectedEducation = education;
//     notifyListeners();
//   }

//   void setSalary(String? salary) {
//     selectedSalary = salary;
//     notifyListeners();
//   }

//   void setExperience(String? experience) {
//     selectedExperience = experience;
//     notifyListeners();
//   }

//   void setIndustryTitle(String? industryTitle) {
//     selectedIndustryTitle = industryTitle;
//     notifyListeners();
//   }

//   Map<String, String> get filters {
//     return {
//       if (selectedLocation != null) "location": selectedLocation!,
//       if (selectedCategory != null) "category": selectedCategory!,
//       if (selectedEducation != null) "education": selectedEducation!,
//       if (selectedSalary != null) "salary": selectedSalary!,
//       if (selectedExperience != null) "experience": selectedExperience!,
//       if (selectedIndustryTitle != null)
//         "industryTitle": selectedIndustryTitle!,
//     };
//   }

//   bool _isLoading = false;

//   bool get isLoading => _isLoading;
//   final GetStorage _storage = GetStorage();
//   void setLoading(bool value) {
//     _isLoading = value;
//     notifyListeners();
//   }

//   List<JobModel> _filterJobs = [];

//   List<JobModel> get filterJobs => _filterJobs;

//   Future<void> getFilteredJobs({
//     String? location,
//     String? education,
//     String? salary,
//     String? experience,
//     String? category,
//     String? companyCategory,
//     bool? employmentForWomen,
//     bool? urgentJobs,
//     bool? jobsWithoutExperience,
//   }) async {
//     setLoading(true);
//     try {
//       final String? token = _storage.read('token');

//       // Construct query parameters dynamically
//       final Map<String, String> queryParams = {};
//       if (location != null) queryParams['location'] = location;
//       if (education != null) queryParams['education'] = education;
//       if (salary != null) queryParams['salary'] = salary;
//       if (experience != null) queryParams['experience'] = experience;
//       if (category != null) queryParams['category'] = category;
//       if (companyCategory != null) queryParams['categories'] = companyCategory;

//       // ✅ Include boolean filters as query params (if true)
//       if (employmentForWomen == true)
//         queryParams['employmentForWomen'] = 'true';
//       if (urgentJobs == true) queryParams['urgentJobs'] = 'true';
//       if (jobsWithoutExperience == true)
//         queryParams['jobsWithoutExperience'] = 'true';

//       final uri = Uri.parse('$kAppBaseUrl/api/jobs/filter/')
//           .replace(queryParameters: queryParams);

//       final response = await http.get(
//         uri,
//         headers: {
//           'Content-Type': 'application/json',
//         },
//       );

//       if (response.statusCode == 200) {
//         final List<dynamic> filterJobsData = jsonDecode(response.body);
//         _filterJobs = filterJobsData
//             .map((jobData) => JobModel.fromJson(jobData))
//             .toList();
//         notifyListeners();
//       }
//     } catch (error) {
//       rethrow;
//     } finally {
//       setLoading(false);
//     }
//   }

//   void resetFilters() {
//   selectedLocation = null;
//   selectedCategory = null;
//   selectedEducation = null;
//   selectedSalary = null;
//   selectedExperience = null;
//   selectedIndustryTitle = null;
//   _filterJobs = []; // Clear filtered jobs list
//   notifyListeners();
// }

// }

class FilterProvider with ChangeNotifier {
  String? selectedLocation;
  String? selectedCategory;
  String? selectedEducation;
  String? selectedSalary;
  String? selectedExperience;
  String? selectedIndustryTitle;
  String? selectedEmploymentForWomen;
  String? selectedUrgent;
  String? selectedJobsWithoutExperience;

  bool _isLoading = false;
  List<JobModel> _filterJobs = [];

  List<JobModel> get filterJobs => _filterJobs;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setLocation(String? location) {
    selectedLocation = location;
    notifyListeners();
  }

  void setCategory(String? category) {
    selectedCategory = category;
    notifyListeners();
  }

  void setEducation(String? education) {
    selectedEducation = education;
    notifyListeners();
  }

  void setSalary(String? salary) {
    selectedSalary = salary;
    notifyListeners();
  }

  void setExperience(String? experience) {
    selectedExperience = experience;
    notifyListeners();
  }

  void setIndustryTitle(String? industryTitle) {
    selectedIndustryTitle = industryTitle;
    notifyListeners();
  }

  void setEmploymentForWomen(String? employmentForWomen) {
    selectedEmploymentForWomen = employmentForWomen;
    notifyListeners();
  }

  void setUrgent(String? urgent) {
    selectedUrgent = urgent;
    notifyListeners();
  }

  void setJobsWithoutExperience(String? withoutExperience) {
    selectedJobsWithoutExperience = withoutExperience;
    notifyListeners();
  }

  final l10n = AppLocalizations.of(navigatorKey.currentState!.context)!;
  Map<String, String> get filters {
    final Map<String, String> activeFilters = {};

    if (selectedLocation != null) activeFilters["Location"] = selectedLocation!;
    if (selectedCategory != null) activeFilters["Category"] = selectedCategory!;
    if (selectedEducation != null)
      activeFilters["Education"] = selectedEducation!;
    if (selectedSalary != null) activeFilters["Salary"] = selectedSalary!;
    if (selectedExperience != null)
      activeFilters["Experience"] = selectedExperience!;
    if (selectedIndustryTitle != null)
      activeFilters["Industry"] = selectedIndustryTitle!;

    // Handle boolean filters
    // if (selectedEmploymentForWomen != null)
    //   activeFilters["For Women"] = "Employment for Women";
    // if (selectedUrgent != null) activeFilters["Urgent Jobs"] = "Urgent Jobs";
    // if (selectedJobsWithoutExperience != null)
    //   activeFilters["No Experience"] = "Jobs without experience";
    if (selectedEmploymentForWomen != null)
      activeFilters["For Women"] = "${l10n.employment_for_women}";
    if (selectedUrgent != null)
      activeFilters["Urgent Jobs"] = "${l10n.urgent_jobs}";
    if (selectedJobsWithoutExperience != null)
      activeFilters["No Experience"] = "${l10n.jobs_without_experience}";

    return activeFilters;
  }

  /// ✅ Reset all filters when navigating back
  void resetFilters() {
    selectedLocation = null;
    selectedCategory = null;
    selectedEducation = null;
    selectedSalary = null;
    selectedExperience = null;
    selectedIndustryTitle = null;
    selectedEmploymentForWomen = null;
    selectedUrgent = null;
    selectedJobsWithoutExperience = null;
    _filterJobs = [];
    _currentFilters.clear();
    notifyListeners();
  }

  // Future<void> getFilteredJobs({
  //   String? location,
  //   String? education,
  //   String? salary,
  //   String? experience,
  //   String? category,
  //   String? companyCategory,
  //   bool? employmentForWomen,
  //   bool? urgentJobs,
  //   bool? jobsWithoutExperience,
  // }) async {
  //   setLoading(true);
  //   try {
  //     final String? token = _storage.read('token');
  //     final Map<String, String> queryParams = {};
  //     if (location != null) queryParams['location'] = location;
  //     if (education != null) queryParams['education'] = education;
  //     if (salary != null) queryParams['salary'] = salary;
  //     if (experience != null) queryParams['experience'] = experience;
  //     if (category != null) queryParams['category'] = category;
  //     if (companyCategory != null) queryParams['categories'] = companyCategory;

  //     if (employmentForWomen == true)
  //       queryParams['employmentForWomen'] = 'true';
  //     if (urgentJobs == true) queryParams['urgentJobs'] = 'true';
  //     if (jobsWithoutExperience == true)
  //       queryParams['jobsWithoutExperience'] = 'true';

  //     final uri = Uri.parse('$kAppBaseUrl/api/jobs/filter/')
  //         .replace(queryParameters: queryParams);

  //     final response =
  //         await http.get(uri, headers: {'Content-Type': 'application/json'});

  //     if (response.statusCode == 200) {
  //       final List<dynamic> filterJobsData = jsonDecode(response.body);
  //       _filterJobs = filterJobsData
  //           .map((jobData) => JobModel.fromJson(jobData))
  //           .toList();
  //       notifyListeners();
  //     }
  //   } catch (error) {
  //     rethrow;
  //   } finally {
  //     setLoading(false);
  //   }
  // }

  final Map<String, String> _currentFilters = {}; // Store applied filters

  Future<void> getFilteredJobs({
    String? location,
    String? education,
    String? salary, // Now handles ranges like "30000-40000"
    String? experience,
    String? category,
    String? companyCategory,
    bool? employmentForWomen,
    bool? urgentJobs,
    bool? jobsWithoutExperience,
  }) async {
    setLoading(true);
    try {
      // Update filters dynamically
      if (location != null) {
        _currentFilters['location'] = location;
      }
      if (education != null) {
        _currentFilters['education'] = education;
      }
      if (salary != null) {
        _currentFilters['salary'] = salary; // Keep salary as a single parameter
      }
      if (experience != null) {
        _currentFilters['experience'] = experience;
      }
      if (category != null) {
        _currentFilters['category'] = category;
      }
      if (companyCategory != null) {
        _currentFilters['categories'] = companyCategory;
      }

      // Handle boolean filters
      employmentForWomen == true
          ? _currentFilters['employmentForWomen'] = 'true'
          : _currentFilters.remove('employmentForWomen');

      urgentJobs == true
          ? _currentFilters['urgentJobs'] = 'true'
          : _currentFilters.remove('urgentJobs');

      jobsWithoutExperience == true
          ? _currentFilters['jobsWithoutExperience'] = 'true'
          : _currentFilters.remove('jobsWithoutExperience');

      // Construct the URL with updated filters
      final uri = Uri.parse('$kAppBaseUrl/api/jobs/filter/')
          .replace(queryParameters: _currentFilters);

      final response =
          await http.get(uri, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        final List<dynamic> filterJobsData = jsonDecode(response.body);
        _filterJobs = filterJobsData
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

// Method to clear all filters
  void clearFilters() {
    _currentFilters.clear();
    _filterJobs = [];
    notifyListeners();
  }
}
