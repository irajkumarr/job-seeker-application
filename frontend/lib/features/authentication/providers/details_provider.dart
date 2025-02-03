import 'package:flutter/material.dart';

class DetailsProvider with ChangeNotifier {
  //age
  int ageCounter = 16;

  void incrementAgeCounter() {
    if (ageCounter < 100) {
      ageCounter++;
    }
    notifyListeners();
  }

  void decrementAgeCounter() {
    if (ageCounter > 16) {
      ageCounter--;
    }
    notifyListeners();
  }

//experiecne
  int experienceCounter = 0;

  void incrementExperienceCounter() {
    if (experienceCounter < 20) {
      experienceCounter++;
    }
    notifyListeners();
  }

  void decrementExperienceCounter() {
    if (experienceCounter > 0) {
      experienceCounter--;
    }
    notifyListeners();
  }

//gender
  final List<String> gender = [
    "Female",
    "Male",
    "Other",
  ];

  String? selectedGender;
  void setSelectedGender(String? gender) {
    selectedGender = gender;
    notifyListeners();
  }

  //education
  final List<String> educationQualification = [
    "Cannot Read and Write",
    "Can Read and Write",
    "8 Class Pass",
    "S.L.C/ S.E.E Pass",
    "+2/ Intermediate Pass",
    "Diploma",
    "Bachelor's Degree",
    "Master's Degree",
    "Ph.D. Degree",
  ];

  String? selectedEducationQualification;
  void setSelectedEducationQualification(String? educationQualification) {
    selectedEducationQualification = educationQualification;
    notifyListeners();
  }

  //salary
  final List<String> salary = [
    "Below Rs. 15,000",
    "Rs. 15,001 - Rs. 25,000",
    "Rs. 25,001 - Rs. 35,000",
    "Rs. 35,001 - Rs. 45,000",
    "Rs. 45,001 - Rs. 55,000",
    "Above Rs. 55,000",
  ];

  String? selectedSalary;
  void setSelectedSalary(String? salary) {
    selectedSalary = salary;
    notifyListeners();
  }

  //working status
  final List<String> workingStatus = [
    "Actively Seeking Employment",
    "Available For Employment",
    "Currently Working",
  ];

  String? selectedWorkingStatus;
  void setSelectedWorkingStatus(String? workingStatus) {
    selectedWorkingStatus = workingStatus;
    notifyListeners();
  }

  //preferred shift
  final List<String> preferredShift = [
    "Regular",
    "Morning",
    "Day",
    "Evening",
    "Flexible",
    "Anytime",
    "Night",
  ];

  String? selectedPreferredShift;
  void setSelectedPreferredShift(String? preferredShift) {
    selectedPreferredShift = preferredShift;
    notifyListeners();
  }

  //job level
  final List<String> jobLevel = [
    "Top Level",
    "Senior Level",
    "Mid Level",
    "Entry Level",
  ];

  String? selectedJobLevel;
  void setSelectedJobLevel(String? jobLevel) {
    selectedJobLevel = jobLevel;
    notifyListeners();
  }

  //availiability
  final List<String> availableFor = [
    "Full Time",
    "Part Time",
    "Contractual",
    "Freelancing",
    "Intenship",
    "Volunteer",
    "Temporary",
    "Traineeship",
  ];

  String? selectedAvailableFor;
  void setSelectedAvailableFor(String? availableFor) {
    selectedAvailableFor = availableFor;
    notifyListeners();
  }

  // //foreign employment
  final List<String> isForeignEmployment = [
    "Yes",
    "No",
  ];

  String? selectedIsForeignEmployment;
  bool? get foreignEmploymentAsBool {
    if (selectedIsForeignEmployment == null) return null;
    return selectedIsForeignEmployment == "Yes";
  }

  void setSelectedIsForeignEmployment(String? value) {
    selectedIsForeignEmployment = value;
    notifyListeners();
  }

  //resetting method
  void reset() {
    ageCounter = 16;
    experienceCounter = 0;
    selectedGender = null;
    selectedWorkingStatus = null;
    selectedAvailableFor = null;
    selectedJobLevel = null;
    selectedPreferredShift = null;
    selectedSalary = null;
    notifyListeners();
  }
}
