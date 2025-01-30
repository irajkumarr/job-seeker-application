// To parse this JSON data, do
//
//     final userProfileRequest = userProfileRequestFromJson(jsonString);

import 'dart:convert';

UserProfileRequest userProfileRequestFromJson(String str) =>
    UserProfileRequest.fromJson(json.decode(str));

String userProfileRequestToJson(UserProfileRequest data) =>
    json.encode(data.toJson());

class UserProfileRequest {
  final List<String> preferredCategories;
  final List<String> skills;
  final PreferredJobLocation preferredJobLocation;
  final PersonalDetails personalDetails;
  final JobPreference? jobPreference;

  UserProfileRequest({
    required this.preferredCategories,
    required this.skills,
    required this.preferredJobLocation,
    required this.personalDetails,
    this.jobPreference,
  });

  factory UserProfileRequest.fromJson(Map<String, dynamic> json) =>
      UserProfileRequest(
        preferredCategories:
            List<String>.from(json["preferredCategories"].map((x) => x)),
        skills: List<String>.from(json["skills"].map((x) => x)),
        preferredJobLocation:
            PreferredJobLocation.fromJson(json["preferredJobLocation"]),
        personalDetails: PersonalDetails.fromJson(json["personalDetails"]),
        jobPreference: JobPreference.fromJson(json["jobPreference"]),
      );

  Map<String, dynamic> toJson() => {
        "preferredCategories":
            List<dynamic>.from(preferredCategories.map((x) => x)),
        "skills": List<dynamic>.from(skills.map((x) => x)),
        "preferredJobLocation": preferredJobLocation.toJson(),
        "personalDetails": personalDetails.toJson(),
        "jobPreference": jobPreference?.toJson(),
      };
}

class JobPreference {
  final String? jobLevel;
  final String? availabilityStatus;
  final String? preferredShift;
  final String? expectedSalary;
  final String? careerObjectives;

  JobPreference({
    this.jobLevel,
    this.availabilityStatus,
    this.preferredShift,
    this.expectedSalary,
    this.careerObjectives,
  });

  factory JobPreference.fromJson(Map<String, dynamic> json) => JobPreference(
        jobLevel: json["jobLevel"],
        availabilityStatus: json["availabilityStatus"],
        preferredShift: json["preferredShift"],
        expectedSalary: json["expectedSalary"],
        careerObjectives: json["careerObjectives"],
      );

  Map<String, dynamic> toJson() => {
        "jobLevel": jobLevel,
        "availabilityStatus": availabilityStatus,
        "preferredShift": preferredShift,
        "expectedSalary": expectedSalary,
        "careerObjectives": careerObjectives,
      };
}

class PersonalDetails {
  final int? age;
  final int? experience;
  final String? gender;
  final String? maritalStatus;
  final String? nationality;
  final String? religion;
  final String? email;
  final Disability? disability;
  final String? workingStatus;
  final ForeignEmployment? foreignEmployment;

  PersonalDetails({
    this.age,
    this.experience,
    this.gender,
    this.maritalStatus,
    this.nationality,
    this.religion,
    this.email,
    this.disability,
    this.workingStatus,
    this.foreignEmployment,
  });

  factory PersonalDetails.fromJson(Map<String, dynamic> json) =>
      PersonalDetails(
        age: json["age"],
        experience: json["experience"],
        gender: json["gender"],
        maritalStatus: json["maritalStatus"],
        nationality: json["nationality"],
        religion: json["religion"],
        email: json["email"],
        disability: json["disability"] == null
            ? null
            : Disability.fromJson(json["disability"]),
        workingStatus: json["workingStatus"],
        foreignEmployment: json["foreignEmployment"] == null
            ? null
            : ForeignEmployment.fromJson(json["foreignEmployment"]),
      );

  Map<String, dynamic> toJson() => {
        "age": age,
        "experience": experience,
        "gender": gender,
        "maritalStatus": maritalStatus,
        "nationality": nationality,
        "religion": religion,
        "email": email,
        "disability": disability?.toJson(),
        "workingStatus": workingStatus,
        "foreignEmployment": foreignEmployment?.toJson(),
      };
}

class Disability {
  final bool? hasDisability;
  final String? details;

  Disability({
    this.hasDisability,
    this.details,
  });

  factory Disability.fromJson(Map<String, dynamic> json) => Disability(
        hasDisability: json["hasDisability"],
        details: json["details"],
      );

  Map<String, dynamic> toJson() => {
        "hasDisability": hasDisability,
        "details": details,
      };
}

class ForeignEmployment {
  final bool? hasWorkedAboroad;
  final String? details;

  ForeignEmployment({
    this.hasWorkedAboroad,
    this.details,
  });

  factory ForeignEmployment.fromJson(Map<String, dynamic> json) =>
      ForeignEmployment(
        hasWorkedAboroad: json["hasWorkedAboroad"],
        details: json["details"],
      );

  Map<String, dynamic> toJson() => {
        "hasWorkedAboroad": hasWorkedAboroad,
        "details": details,
      };
}

class PreferredJobLocation {
  final String province;
  final String district;
  final String municipality;
  final String fullAddress;

  PreferredJobLocation({
    required this.province,
    required this.district,
    required this.municipality,
    required this.fullAddress,
  });

  factory PreferredJobLocation.fromJson(Map<String, dynamic> json) =>
      PreferredJobLocation(
        province: json["province"],
        district: json["district"],
        municipality: json["municipality"],
        fullAddress: json["fullAddress"],
      );

  Map<String, dynamic> toJson() => {
        "province": province,
        "district": district,
        "municipality": municipality,
        "fullAddress": fullAddress,
      };
}
