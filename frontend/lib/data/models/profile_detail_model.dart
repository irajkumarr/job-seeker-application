// // To parse this JSON data, do
// //
// //     final profileDetailModel = profileDetailModelFromJson(jsonString);

// import 'dart:convert';

// ProfileDetailModel profileDetailModelFromJson(String str) =>
//     ProfileDetailModel.fromJson(json.decode(str));

// String profileDetailModelToJson(ProfileDetailModel data) =>
//     json.encode(data.toJson());

// class ProfileDetailModel {
//   final String? id;
//   final String? name;
//   final String? mobileNumber;
//   final String? userType;
//   final bool? isActive;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final int? v;
//   final List<Profile>? profile;
//   final List<Experience>? experiences;
//   final List<Document>? documents;
//   final List<Training>? trainings;
//   final List<Socialaccount>? socialaccounts;
//   final List<Reference>? references;
//   final List<Language>? languages;
//   final List<Education>? educations;
//   final List<Emergencycontact>? emergencycontacts;

//   ProfileDetailModel({
//     this.id,
//     this.name,
//     this.mobileNumber,
//     this.userType,
//     this.isActive,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//     this.profile,
//     this.experiences,
//     this.documents,
//     this.trainings,
//     this.socialaccounts,
//     this.references,
//     this.languages,
//     this.educations,
//     this.emergencycontacts,
//   });

//   factory ProfileDetailModel.fromJson(Map<String, dynamic> json) =>
//       ProfileDetailModel(
//         id: json["_id"],
//         name: json["name"],
//         mobileNumber: json["mobileNumber"],
//         userType: json["userType"],
//         isActive: json["isActive"],
//         createdAt: json["createdAt"] == null
//             ? null
//             : DateTime.parse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null
//             ? null
//             : DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//         profile: json["profile"] == null
//             ? []
//             : List<Profile>.from(
//                 json["profile"]!.map((x) => Profile.fromJson(x))),
//         experiences: json["experiences"] == null
//             ? []
//             : List<Experience>.from(
//                 json["experiences"]!.map((x) => Experience.fromJson(x))),
//         documents: json["documents"] == null
//             ? []
//             : List<Document>.from(
//                 json["documents"]!.map((x) => Document.fromJson(x))),
//         trainings: json["trainings"] == null
//             ? []
//             : List<Training>.from(
//                 json["trainings"]!.map((x) => Training.fromJson(x))),
//         socialaccounts: json["socialaccounts"] == null
//             ? []
//             : List<Socialaccount>.from(
//                 json["socialaccounts"]!.map((x) => Socialaccount.fromJson(x))),
//         references: json["references"] == null
//             ? []
//             : List<Reference>.from(
//                 json["references"]!.map((x) => Reference.fromJson(x))),
//         languages: json["languages"] == null
//             ? []
//             : List<Language>.from(
//                 json["languages"]!.map((x) => Language.fromJson(x))),
//         educations: json["educations"] == null
//             ? []
//             : List<Education>.from(
//                 json["educations"]!.map((x) => Education.fromJson(x))),
//         emergencycontacts: json["emergencycontacts"] == null
//             ? []
//             : List<Emergencycontact>.from(json["emergencycontacts"]!
//                 .map((x) => Emergencycontact.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "name": name,
//         "mobileNumber": mobileNumber,
//         "userType": userType,
//         "isActive": isActive,
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//         "__v": v,
//         "profile": profile == null
//             ? []
//             : List<dynamic>.from(profile!.map((x) => x.toJson())),
//         "experiences": experiences == null
//             ? []
//             : List<dynamic>.from(experiences!.map((x) => x.toJson())),
//         "documents": documents == null
//             ? []
//             : List<dynamic>.from(documents!.map((x) => x.toJson())),
//         "trainings": trainings == null
//             ? []
//             : List<dynamic>.from(trainings!.map((x) => x.toJson())),
//         "socialaccounts": socialaccounts == null
//             ? []
//             : List<dynamic>.from(socialaccounts!.map((x) => x.toJson())),
//         "references": references == null
//             ? []
//             : List<dynamic>.from(references!.map((x) => x.toJson())),
//         "languages": languages == null
//             ? []
//             : List<dynamic>.from(languages!.map((x) => x.toJson())),
//         "educations": educations == null
//             ? []
//             : List<dynamic>.from(educations!.map((x) => x.toJson())),
//         "emergencycontacts": emergencycontacts == null
//             ? []
//             : List<dynamic>.from(emergencycontacts!.map((x) => x.toJson())),
//       };
// }

// class Document {
//   final String? userId;
//   final String? title;
//   final String? category;
//   final String? file;
//   final DateTime? uploadDate;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final int? v;

//   Document({
//     this.userId,
//     this.title,
//     this.category,
//     this.file,
//     this.uploadDate,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//   });

//   factory Document.fromJson(Map<String, dynamic> json) => Document(
//         userId: json["userId"],
//         title: json["title"],
//         category: json["category"],
//         file: json["file"],
//         uploadDate: json["uploadDate"] == null
//             ? null
//             : DateTime.parse(json["uploadDate"]),
//         createdAt: json["createdAt"] == null
//             ? null
//             : DateTime.parse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null
//             ? null
//             : DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//       );

//   Map<String, dynamic> toJson() => {
//         "userId": userId,
//         "title": title,
//         "category": category,
//         "file": file,
//         "uploadDate": uploadDate?.toIso8601String(),
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//         "__v": v,
//       };
// }

// class Education {
//   final String? userId;
//   final String? level;
//   final String? institution;
//   final String? major;
//   final DateTime? startDate;
//   final DateTime? endDate;
//   final String? grade;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final int? v;

//   Education({
//     this.userId,
//     this.level,
//     this.institution,
//     this.major,
//     this.startDate,
//     this.endDate,
//     this.grade,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//   });

//   factory Education.fromJson(Map<String, dynamic> json) => Education(
//         userId: json["userId"],
//         level: json["level"],
//         institution: json["institution"],
//         major: json["major"],
//         startDate: json["startDate"] == null
//             ? null
//             : DateTime.parse(json["startDate"]),
//         endDate:
//             json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
//         grade: json["grade"],
//         createdAt: json["createdAt"] == null
//             ? null
//             : DateTime.parse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null
//             ? null
//             : DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//       );

//   Map<String, dynamic> toJson() => {
//         "userId": userId,
//         "level": level,
//         "institution": institution,
//         "major": major,
//         "startDate": startDate?.toIso8601String(),
//         "endDate": endDate?.toIso8601String(),
//         "grade": grade,
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//         "__v": v,
//       };
// }

// class Emergencycontact {
//   final String? userId;
//   final String? fullName;
//   final String? address;
//   final String? relation;
//   final String? phoneNumber;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final int? v;

//   Emergencycontact({
//     this.userId,
//     this.fullName,
//     this.address,
//     this.relation,
//     this.phoneNumber,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//   });

//   factory Emergencycontact.fromJson(Map<String, dynamic> json) =>
//       Emergencycontact(
//         userId: json["userId"],
//         fullName: json["fullName"],
//         address: json["address"],
//         relation: json["relation"],
//         phoneNumber: json["phoneNumber"],
//         createdAt: json["createdAt"] == null
//             ? null
//             : DateTime.parse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null
//             ? null
//             : DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//       );

//   Map<String, dynamic> toJson() => {
//         "userId": userId,
//         "fullName": fullName,
//         "address": address,
//         "relation": relation,
//         "phoneNumber": phoneNumber,
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//         "__v": v,
//       };
// }

// class Experience {
//   final String? userId;
//   final String? organizationName;
//   final String? industry;
//   final String? jobCategory;
//   final String? location;
//   final String? designation;
//   final String? jobLevel;
//   final DateTime? startDate;
//   final bool? currentlyWorking;
//   final dynamic endDate;
//   final String? rolesAndResponsibilities;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final int? v;

//   Experience({
//     this.userId,
//     this.organizationName,
//     this.industry,
//     this.jobCategory,
//     this.location,
//     this.designation,
//     this.jobLevel,
//     this.startDate,
//     this.currentlyWorking,
//     this.endDate,
//     this.rolesAndResponsibilities,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//   });

//   factory Experience.fromJson(Map<String, dynamic> json) => Experience(
//         userId: json["userId"],
//         organizationName: json["organizationName"],
//         industry: json["industry"],
//         jobCategory: json["jobCategory"],
//         location: json["location"],
//         designation: json["designation"],
//         jobLevel: json["jobLevel"],
//         startDate: json["startDate"] == null
//             ? null
//             : DateTime.parse(json["startDate"]),
//         currentlyWorking: json["currentlyWorking"],
//         endDate: json["endDate"],
//         rolesAndResponsibilities: json["rolesAndResponsibilities"],
//         createdAt: json["createdAt"] == null
//             ? null
//             : DateTime.parse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null
//             ? null
//             : DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//       );

//   Map<String, dynamic> toJson() => {
//         "userId": userId,
//         "organizationName": organizationName,
//         "industry": industry,
//         "jobCategory": jobCategory,
//         "location": location,
//         "designation": designation,
//         "jobLevel": jobLevel,
//         "startDate": startDate?.toIso8601String(),
//         "currentlyWorking": currentlyWorking,
//         "endDate": endDate,
//         "rolesAndResponsibilities": rolesAndResponsibilities,
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//         "__v": v,
//       };
// }

// class Language {
//   final String? userId;
//   final String? name;
//   final double? score;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final int? v;

//   Language({
//     this.userId,
//     this.name,
//     this.score,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//   });

//   factory Language.fromJson(Map<String, dynamic> json) => Language(
//         userId: json["userId"],
//         name: json["name"],
//         score: json["score"]?.toDouble(),
//         createdAt: json["createdAt"] == null
//             ? null
//             : DateTime.parse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null
//             ? null
//             : DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//       );

//   Map<String, dynamic> toJson() => {
//         "userId": userId,
//         "name": name,
//         "score": score,
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//         "__v": v,
//       };
// }

// class Profile {
//   final String? id;
//   final String? userId;
//   final List<String>? preferredCategories;
//   final List<String>? skills;
//   final PreferredJobLocation? preferredJobLocation;
//   final PersonalDetails? personalDetails;
//   final JobPreference? jobPreference;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final int? v;

//   Profile({
//     this.id,
//     this.userId,
//     this.preferredCategories,
//     this.skills,
//     this.preferredJobLocation,
//     this.personalDetails,
//     this.jobPreference,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//   });

//   factory Profile.fromJson(Map<String, dynamic> json) => Profile(
//         id: json["_id"],
//         userId: json["userId"],
//         preferredCategories: json["preferredCategories"] == null
//             ? []
//             : List<String>.from(json["preferredCategories"]!.map((x) => x)),
//         skills: json["skills"] == null
//             ? []
//             : List<String>.from(json["skills"]!.map((x) => x)),
//         preferredJobLocation: json["preferredJobLocation"] == null
//             ? null
//             : PreferredJobLocation.fromJson(json["preferredJobLocation"]),
//         personalDetails: json["personalDetails"] == null
//             ? null
//             : PersonalDetails.fromJson(json["personalDetails"]),
//         jobPreference: json["jobPreference"] == null
//             ? null
//             : JobPreference.fromJson(json["jobPreference"]),
//         createdAt: json["createdAt"] == null
//             ? null
//             : DateTime.parse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null
//             ? null
//             : DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "userId": userId,
//         "preferredCategories": preferredCategories == null
//             ? []
//             : List<dynamic>.from(preferredCategories!.map((x) => x)),
//         "skills":
//             skills == null ? [] : List<dynamic>.from(skills!.map((x) => x)),
//         "preferredJobLocation": preferredJobLocation?.toJson(),
//         "personalDetails": personalDetails?.toJson(),
//         "jobPreference": jobPreference?.toJson(),
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//         "__v": v,
//       };
// }

// class JobPreference {
//   final dynamic jobLevel;
//   final dynamic availabilityStatus;
//   final dynamic preferredShift;
//   final String? expectedSalary;
//   final dynamic careerObjectives;

//   JobPreference({
//     this.jobLevel,
//     this.availabilityStatus,
//     this.preferredShift,
//     this.expectedSalary,
//     this.careerObjectives,
//   });

//   factory JobPreference.fromJson(Map<String, dynamic> json) => JobPreference(
//         jobLevel: json["jobLevel"],
//         availabilityStatus: json["availabilityStatus"],
//         preferredShift: json["preferredShift"],
//         expectedSalary: json["expectedSalary"],
//         careerObjectives: json["careerObjectives"],
//       );

//   Map<String, dynamic> toJson() => {
//         "jobLevel": jobLevel,
//         "availabilityStatus": availabilityStatus,
//         "preferredShift": preferredShift,
//         "expectedSalary": expectedSalary,
//         "careerObjectives": careerObjectives,
//       };
// }

// class PersonalDetails {
//   final int? age;
//   final int? experience;
//   final String? gender;
//   final dynamic maritalStatus;
//   final dynamic nationality;
//   final dynamic religion;
//   final dynamic email;
//   final dynamic disability;
//   final String? workingStatus;
//   final ForeignEmployment? foreignEmployment;

//   PersonalDetails({
//     this.age,
//     this.experience,
//     this.gender,
//     this.maritalStatus,
//     this.nationality,
//     this.religion,
//     this.email,
//     this.disability,
//     this.workingStatus,
//     this.foreignEmployment,
//   });

//   factory PersonalDetails.fromJson(Map<String, dynamic> json) =>
//       PersonalDetails(
//         age: json["age"],
//         experience: json["experience"],
//         gender: json["gender"],
//         maritalStatus: json["maritalStatus"],
//         nationality: json["nationality"],
//         religion: json["religion"],
//         email: json["email"],
//         disability: json["disability"],
//         workingStatus: json["workingStatus"],
//         foreignEmployment: json["foreignEmployment"] == null
//             ? null
//             : ForeignEmployment.fromJson(json["foreignEmployment"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "age": age,
//         "experience": experience,
//         "gender": gender,
//         "maritalStatus": maritalStatus,
//         "nationality": nationality,
//         "religion": religion,
//         "email": email,
//         "disability": disability,
//         "workingStatus": workingStatus,
//         "foreignEmployment": foreignEmployment?.toJson(),
//       };
// }

// class ForeignEmployment {
//   final bool? hasWorkedAboroad;
//   final dynamic details;

//   ForeignEmployment({
//     this.hasWorkedAboroad,
//     this.details,
//   });

//   factory ForeignEmployment.fromJson(Map<String, dynamic> json) =>
//       ForeignEmployment(
//         hasWorkedAboroad: json["hasWorkedAboroad"],
//         details: json["details"],
//       );

//   Map<String, dynamic> toJson() => {
//         "hasWorkedAboroad": hasWorkedAboroad,
//         "details": details,
//       };
// }

// class PreferredJobLocation {
//   final String? province;
//   final String? district;
//   final String? municipality;
//   final String? fullAddress;

//   PreferredJobLocation({
//     this.province,
//     this.district,
//     this.municipality,
//     this.fullAddress,
//   });

//   factory PreferredJobLocation.fromJson(Map<String, dynamic> json) =>
//       PreferredJobLocation(
//         province: json["province"],
//         district: json["district"],
//         municipality: json["municipality"],
//         fullAddress: json["fullAddress"],
//       );

//   Map<String, dynamic> toJson() => {
//         "province": province,
//         "district": district,
//         "municipality": municipality,
//         "fullAddress": fullAddress,
//       };
// }

// class Reference {
//   final String? userId;
//   final String? name;
//   final String? designation;
//   final String? organization;
//   final String? email;
//   final String? phoneNumber;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final int? v;

//   Reference({
//     this.userId,
//     this.name,
//     this.designation,
//     this.organization,
//     this.email,
//     this.phoneNumber,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//   });

//   factory Reference.fromJson(Map<String, dynamic> json) => Reference(
//         userId: json["userId"],
//         name: json["name"],
//         designation: json["designation"],
//         organization: json["organization"],
//         email: json["email"],
//         phoneNumber: json["phoneNumber"],
//         createdAt: json["createdAt"] == null
//             ? null
//             : DateTime.parse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null
//             ? null
//             : DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//       );

//   Map<String, dynamic> toJson() => {
//         "userId": userId,
//         "name": name,
//         "designation": designation,
//         "organization": organization,
//         "email": email,
//         "phoneNumber": phoneNumber,
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//         "__v": v,
//       };
// }

// class Socialaccount {
//   final String? userId;
//   final String? platform;
//   final String? url;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final int? v;

//   Socialaccount({
//     this.userId,
//     this.platform,
//     this.url,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//   });

//   factory Socialaccount.fromJson(Map<String, dynamic> json) => Socialaccount(
//         userId: json["userId"],
//         platform: json["platform"],
//         url: json["url"],
//         createdAt: json["createdAt"] == null
//             ? null
//             : DateTime.parse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null
//             ? null
//             : DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//       );

//   Map<String, dynamic> toJson() => {
//         "userId": userId,
//         "platform": platform,
//         "url": url,
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//         "__v": v,
//       };
// }

// class Training {
//   final String? userId;
//   final String? name;
//   final String? institute;
//   final Duration? duration;
//   final int? completionYear;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final int? v;

//   Training({
//     this.userId,
//     this.name,
//     this.institute,
//     this.duration,
//     this.completionYear,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//   });

//   factory Training.fromJson(Map<String, dynamic> json) => Training(
//         userId: json["userId"],
//         name: json["name"],
//         institute: json["institute"],
//         duration: json["duration"] == null
//             ? null
//             : Duration.fromJson(json["duration"]),
//         completionYear: json["completionYear"],
//         createdAt: json["createdAt"] == null
//             ? null
//             : DateTime.parse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null
//             ? null
//             : DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//       );

//   Map<String, dynamic> toJson() => {
//         "userId": userId,
//         "name": name,
//         "institute": institute,
//         "duration": duration?.toJson(),
//         "completionYear": completionYear,
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//         "__v": v,
//       };
// }

// class Duration {
//   final int? value;
//   final String? unit;

//   Duration({
//     this.value,
//     this.unit,
//   });

//   factory Duration.fromJson(Map<String, dynamic> json) => Duration(
//         value: json["value"],
//         unit: json["unit"],
//       );

//   Map<String, dynamic> toJson() => {
//         "value": value,
//         "unit": unit,
//       };
// }

// To parse this JSON data, do
//
//     final profileDetailModel = profileDetailModelFromJson(jsonString);

import 'dart:convert';

ProfileDetailModel profileDetailModelFromJson(String str) =>
    ProfileDetailModel.fromJson(json.decode(str));

String profileDetailModelToJson(ProfileDetailModel data) =>
    json.encode(data.toJson());

class ProfileDetailModel {
  final String? id;
  final String? name;
  final String? mobileNumber;
  final String? userType;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final List<Profile>? profile;
  final List<Experience>? experiences;
  final List<Document>? documents;
  final List<Training>? trainings;
  final List<Socialaccount>? socialaccounts;
  final List<Reference>? references;
  final List<Language>? languages;
  final List<Education>? educations;
  final List<Emergencycontact>? emergencycontacts;

  ProfileDetailModel({
    this.id,
    this.name,
    this.mobileNumber,
    this.userType,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.profile,
    this.experiences,
    this.documents,
    this.trainings,
    this.socialaccounts,
    this.references,
    this.languages,
    this.educations,
    this.emergencycontacts,
  });

  factory ProfileDetailModel.fromJson(Map<String, dynamic> json) =>
      ProfileDetailModel(
        id: json["_id"],
        name: json["name"],
        mobileNumber: json["mobileNumber"],
        userType: json["userType"],
        isActive: json["isActive"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        profile: json["profile"] == null
            ? []
            : List<Profile>.from(
                json["profile"]!.map((x) => Profile.fromJson(x))),
        experiences: json["experiences"] == null
            ? []
            : List<Experience>.from(
                json["experiences"]!.map((x) => Experience.fromJson(x))),
        documents: json["documents"] == null
            ? []
            : List<Document>.from(
                json["documents"]!.map((x) => Document.fromJson(x))),
        trainings: json["trainings"] == null
            ? []
            : List<Training>.from(
                json["trainings"]!.map((x) => Training.fromJson(x))),
        socialaccounts: json["socialaccounts"] == null
            ? []
            : List<Socialaccount>.from(
                json["socialaccounts"]!.map((x) => Socialaccount.fromJson(x))),
        references: json["references"] == null
            ? []
            : List<Reference>.from(
                json["references"]!.map((x) => Reference.fromJson(x))),
        languages: json["languages"] == null
            ? []
            : List<Language>.from(
                json["languages"]!.map((x) => Language.fromJson(x))),
        educations: json["educations"] == null
            ? []
            : List<Education>.from(
                json["educations"]!.map((x) => Education.fromJson(x))),
        emergencycontacts: json["emergencycontacts"] == null
            ? []
            : List<Emergencycontact>.from(json["emergencycontacts"]!
                .map((x) => Emergencycontact.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "mobileNumber": mobileNumber,
        "userType": userType,
        "isActive": isActive,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "profile": profile == null
            ? []
            : List<dynamic>.from(profile!.map((x) => x.toJson())),
        "experiences": experiences == null
            ? []
            : List<dynamic>.from(experiences!.map((x) => x.toJson())),
        "documents": documents == null
            ? []
            : List<dynamic>.from(documents!.map((x) => x.toJson())),
        "trainings": trainings == null
            ? []
            : List<dynamic>.from(trainings!.map((x) => x.toJson())),
        "socialaccounts": socialaccounts == null
            ? []
            : List<dynamic>.from(socialaccounts!.map((x) => x.toJson())),
        "references": references == null
            ? []
            : List<dynamic>.from(references!.map((x) => x.toJson())),
        "languages": languages == null
            ? []
            : List<dynamic>.from(languages!.map((x) => x.toJson())),
        "educations": educations == null
            ? []
            : List<dynamic>.from(educations!.map((x) => x.toJson())),
        "emergencycontacts": emergencycontacts == null
            ? []
            : List<dynamic>.from(emergencycontacts!.map((x) => x.toJson())),
      };
}

class Document {
  final String? id;
  final String? userId;
  final String? title;
  final String? category;
  final String? file;
  final DateTime? uploadDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Document({
    this.id,
    this.userId,
    this.title,
    this.category,
    this.file,
    this.uploadDate,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        id: json["_id"],
        userId: json["userId"],
        title: json["title"],
        category: json["category"],
        file: json["file"],
        uploadDate: json["uploadDate"] == null
            ? null
            : DateTime.parse(json["uploadDate"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "title": title,
        "category": category,
        "file": file,
        "uploadDate": uploadDate?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Education {
  final String? id;
  final String? userId;
  final String? level;
  final String? institution;
  final String? major;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? grade;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Education({
    this.id,
    this.userId,
    this.level,
    this.institution,
    this.major,
    this.startDate,
    this.endDate,
    this.grade,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Education.fromJson(Map<String, dynamic> json) => Education(
        id: json["_id"],
        userId: json["userId"],
        level: json["level"],
        institution: json["institution"],
        major: json["major"],
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        endDate:
            json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        grade: json["grade"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "level": level,
        "institution": institution,
        "major": major,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "grade": grade,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Emergencycontact {
  final String? id;
  final String? userId;
  final String? fullName;
  final String? address;
  final String? relation;
  final PhoneNumber? phoneNumber;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Emergencycontact({
    this.id,
    this.userId,
    this.fullName,
    this.address,
    this.relation,
    this.phoneNumber,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Emergencycontact.fromJson(Map<String, dynamic> json) =>
      Emergencycontact(
        id: json["_id"],
        userId: json["userId"],
        fullName: json["fullName"],
        address: json["address"],
        relation: json["relation"],
        phoneNumber: json["phoneNumber"] == null
            ? null
            : PhoneNumber.fromJson(json["phoneNumber"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "fullName": fullName,
        "address": address,
        "relation": relation,
        "phoneNumber": phoneNumber?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class PhoneNumber {
  final String? numberType;
  final String? mobileNumber;

  PhoneNumber({
    this.numberType,
    this.mobileNumber,
  });

  factory PhoneNumber.fromJson(Map<String, dynamic> json) => PhoneNumber(
        numberType: json["numberType"],
        mobileNumber: json["mobileNumber"],
      );

  Map<String, dynamic> toJson() => {
        "numberType": numberType,
        "mobileNumber": mobileNumber,
      };
}

class Experience {
  final String? id;
  final String? userId;
  final String? organizationName;
  final String? industry;
  final String? jobCategory;
  final String? location;
  final String? designation;
  final String? jobLevel;
  final DateTime? startDate;
  final bool? currentlyWorking;
  final dynamic endDate;
  final String? rolesAndResponsibilities;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Experience({
    this.id,
    this.userId,
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
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
        id: json["_id"],
        userId: json["userId"],
        organizationName: json["organizationName"],
        industry: json["industry"],
        jobCategory: json["jobCategory"],
        location: json["location"],
        designation: json["designation"],
        jobLevel: json["jobLevel"],
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        currentlyWorking: json["currentlyWorking"],
        endDate: json["endDate"],
        rolesAndResponsibilities: json["rolesAndResponsibilities"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "organizationName": organizationName,
        "industry": industry,
        "jobCategory": jobCategory,
        "location": location,
        "designation": designation,
        "jobLevel": jobLevel,
        "startDate": startDate?.toIso8601String(),
        "currentlyWorking": currentlyWorking,
        "endDate": endDate,
        "rolesAndResponsibilities": rolesAndResponsibilities,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Language {
  final String? id;
  final String? userId;
  final String? name;
  final double? score;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Language({
    this.id,
    this.userId,
    this.name,
    this.score,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        id: json["_id"],
        userId: json["userId"],
        name: json["name"],
        score: json["score"]?.toDouble(),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "name": name,
        "score": score,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Profile {
  final String? id;
  final String? userId;
  final List<String>? preferredCategories;
  final List<String>? skills;
  final PreferredJobLocation? preferredJobLocation;
  final PersonalDetails? personalDetails;
  final JobPreference? jobPreference;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Profile({
    this.id,
    this.userId,
    this.preferredCategories,
    this.skills,
    this.preferredJobLocation,
    this.personalDetails,
    this.jobPreference,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["_id"],
        userId: json["userId"],
        preferredCategories: json["preferredCategories"] == null
            ? []
            : List<String>.from(json["preferredCategories"]!.map((x) => x)),
        skills: json["skills"] == null
            ? []
            : List<String>.from(json["skills"]!.map((x) => x)),
        preferredJobLocation: json["preferredJobLocation"] == null
            ? null
            : PreferredJobLocation.fromJson(json["preferredJobLocation"]),
        personalDetails: json["personalDetails"] == null
            ? null
            : PersonalDetails.fromJson(json["personalDetails"]),
        jobPreference: json["jobPreference"] == null
            ? null
            : JobPreference.fromJson(json["jobPreference"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "preferredCategories": preferredCategories == null
            ? []
            : List<dynamic>.from(preferredCategories!.map((x) => x)),
        "skills":
            skills == null ? [] : List<dynamic>.from(skills!.map((x) => x)),
        "preferredJobLocation": preferredJobLocation?.toJson(),
        "personalDetails": personalDetails?.toJson(),
        "jobPreference": jobPreference?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class JobPreference {
  final dynamic jobLevel;
  final dynamic availabilityStatus;
  final dynamic preferredShift;
  final String? expectedSalary;
  final dynamic careerObjectives;

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
  final dynamic maritalStatus;
  final dynamic nationality;
  final dynamic religion;
  final dynamic email;
  final dynamic disability;
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
        disability: json["disability"],
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
        "disability": disability,
        "workingStatus": workingStatus,
        "foreignEmployment": foreignEmployment?.toJson(),
      };
}

class ForeignEmployment {
  final bool? hasWorkedAboroad;
  final dynamic details;

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
  final String? province;
  final String? district;
  final String? municipality;
  final String? fullAddress;

  PreferredJobLocation({
    this.province,
    this.district,
    this.municipality,
    this.fullAddress,
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

class Reference {
  final String? id;
  final String? userId;
  final String? name;
  final String? designation;
  final String? organization;
  final String? email;
  final PhoneNumber? phoneNumber;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Reference({
    this.id,
    this.userId,
    this.name,
    this.designation,
    this.organization,
    this.email,
    this.phoneNumber,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Reference.fromJson(Map<String, dynamic> json) => Reference(
        id: json["_id"],
        userId: json["userId"],
        name: json["name"],
        designation: json["designation"],
        organization: json["organization"],
        email: json["email"],
         phoneNumber: json["phoneNumber"] == null
            ? null
            : PhoneNumber.fromJson(json["phoneNumber"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "name": name,
        "designation": designation,
        "organization": organization,
        "email": email,
        "phoneNumber": phoneNumber?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Socialaccount {
  final String? id;
  final String? userId;
  final String? platform;
  final String? url;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Socialaccount({
    this.id,
    this.userId,
    this.platform,
    this.url,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Socialaccount.fromJson(Map<String, dynamic> json) => Socialaccount(
        id: json["_id"],
        userId: json["userId"],
        platform: json["platform"],
        url: json["url"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "platform": platform,
        "url": url,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Training {
  final String? id;
  final String? userId;
  final String? name;
  final String? institute;
  final Duration? duration;
  final int? completionYear;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Training({
    this.id,
    this.userId,
    this.name,
    this.institute,
    this.duration,
    this.completionYear,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Training.fromJson(Map<String, dynamic> json) => Training(
        id: json["_id"],
        userId: json["userId"],
        name: json["name"],
        institute: json["institute"],
        duration: json["duration"] == null
            ? null
            : Duration.fromJson(json["duration"]),
        completionYear: json["completionYear"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "name": name,
        "institute": institute,
        "duration": duration?.toJson(),
        "completionYear": completionYear,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Duration {
  final int? value;
  final String? unit;

  Duration({
    this.value,
    this.unit,
  });

  factory Duration.fromJson(Map<String, dynamic> json) => Duration(
        value: json["value"],
        unit: json["unit"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "unit": unit,
      };
}
