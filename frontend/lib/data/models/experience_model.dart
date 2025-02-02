// // To parse this JSON data, do
// //
// //     final experienceModel = experienceModelFromJson(jsonString);

// import 'dart:convert';

// ExperienceModel experienceModelFromJson(String str) => ExperienceModel.fromJson(json.decode(str));

// String experienceModelToJson(ExperienceModel data) => json.encode(data.toJson());

// class ExperienceModel {
//     final String? organizationName;
//     final String? industry;
//     final String? jobCategory;
//     final String? location;
//     final String? designation;
//     final String? jobLevel;
//     final DateTime? startDate;
//     final bool? currentlyWorking;
//     final dynamic endDate;
//     final String? rolesAndResponsibilities;

//     ExperienceModel({
//         this.organizationName,
//         this.industry,
//         this.jobCategory,
//         this.location,
//         this.designation,
//         this.jobLevel,
//         this.startDate,
//         this.currentlyWorking,
//         this.endDate,
//         this.rolesAndResponsibilities,
//     });

//     factory ExperienceModel.fromJson(Map<String, dynamic> json) => ExperienceModel(
//         organizationName: json["organizationName"],
//         industry: json["industry"],
//         jobCategory: json["jobCategory"],
//         location: json["location"],
//         designation: json["designation"],
//         jobLevel: json["jobLevel"],
//         startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
//         currentlyWorking: json["currentlyWorking"],
//         endDate: json["endDate"],
//         rolesAndResponsibilities: json["rolesAndResponsibilities"],
//     );

//     Map<String, dynamic> toJson() => {
//         "organizationName": organizationName,
//         "industry": industry,
//         "jobCategory": jobCategory,
//         "location": location,
//         "designation": designation,
//         "jobLevel": jobLevel,
//         "startDate": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
//         "currentlyWorking": currentlyWorking,
//         "endDate": endDate,
//         "rolesAndResponsibilities": rolesAndResponsibilities,
//     };
// }



// To parse this JSON data, do
//
//     final experienceModel = experienceModelFromJson(jsonString);

import 'dart:convert';

ExperienceModel experienceModelFromJson(String str) => ExperienceModel.fromJson(json.decode(str));

String experienceModelToJson(ExperienceModel data) => json.encode(data.toJson());

class ExperienceModel {
    final String? organizationName;
    final String? industry;
    final String? jobCategory;
    final String? location;
    final String? designation;
    final String? jobLevel;
    final Date? startDate;
    final bool? currentlyWorking;
    final Date? endDate;
    final String? rolesAndResponsibilities;

    ExperienceModel({
        this.organizationName,
        this.industry,
        this.jobCategory,
        this.location,
        this.designation,
        this.jobLevel,
        this.startDate,
        this.currentlyWorking,
        this.endDate,
        this.rolesAndResponsibilities,
    });

    factory ExperienceModel.fromJson(Map<String, dynamic> json) => ExperienceModel(
        organizationName: json["organizationName"],
        industry: json["industry"],
        jobCategory: json["jobCategory"],
        location: json["location"],
        designation: json["designation"],
        jobLevel: json["jobLevel"],
        startDate: json["startDate"] == null ? null : Date.fromJson(json["startDate"]),
        currentlyWorking: json["currentlyWorking"],
        endDate: json["endDate"] == null ? null : Date.fromJson(json["endDate"]),
        rolesAndResponsibilities: json["rolesAndResponsibilities"],
    );

    Map<String, dynamic> toJson() => {
        "organizationName": organizationName,
        "industry": industry,
        "jobCategory": jobCategory,
        "location": location,
        "designation": designation,
        "jobLevel": jobLevel,
        "startDate": startDate?.toJson(),
        "currentlyWorking": currentlyWorking,
        "endDate": endDate?.toJson(),
        "rolesAndResponsibilities": rolesAndResponsibilities,
    };
}

class Date {
    final String? year;
    final String? month;

    Date({
        this.year,
        this.month,
    });

    factory Date.fromJson(Map<String, dynamic> json) => Date(
        year: json["year"],
        month: json["month"],
    );

    Map<String, dynamic> toJson() => {
        "year": year,
        "month": month,
    };
}
