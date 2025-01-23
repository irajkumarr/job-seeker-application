// To parse this JSON data, do
//
//     final jobModel = jobModelFromJson(jsonString);

import 'dart:convert';

List<JobModel> jobModelFromJson(String str) =>
    List<JobModel>.from(json.decode(str).map((x) => JobModel.fromJson(x)));

String jobModelToJson(List<JobModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JobModel {
  final Location location;
  final BasicInformation basicInformation;
  final String id;
  final Company company;
  final String title;
  final String type;
  final int salary;
  final DateTime expiryDate;
  final List<String> skills;
  final List<String> personalQualities;
  final List<String> benefits;
  final String jobDescription;
  final bool allowFreshers;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  JobModel({
    required this.location,
    required this.basicInformation,
    required this.id,
    required this.company,
    required this.title,
    required this.type,
    required this.salary,
    required this.expiryDate,
    required this.skills,
    required this.personalQualities,
    required this.benefits,
    required this.jobDescription,
    required this.allowFreshers,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) => JobModel(
        location: Location.fromJson(json["location"]),
        basicInformation: BasicInformation.fromJson(json["basicInformation"]),
        id: json["_id"],
        company: Company.fromJson(json["company"]),
        title: json["title"],
        type: json["type"],
        salary: json["salary"],
        expiryDate: DateTime.parse(json["expiryDate"]),
        skills: List<String>.from(json["skills"].map((x) => x)),
        personalQualities:
            List<String>.from(json["personalQualities"].map((x) => x)),
        benefits: List<String>.from(json["benefits"].map((x) => x)),
        jobDescription: json["jobDescription"],
        allowFreshers: json["allowFreshers"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "basicInformation": basicInformation.toJson(),
        "_id": id,
        "company": company.toJson(),
        "title": title,
        "type": type,
        "salary": salary,
        "expiryDate": expiryDate.toIso8601String(),
        "skills": List<dynamic>.from(skills.map((x) => x)),
        "personalQualities":
            List<dynamic>.from(personalQualities.map((x) => x)),
        "benefits": List<dynamic>.from(benefits.map((x) => x)),
        "jobDescription": jobDescription,
        "allowFreshers": allowFreshers,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class BasicInformation {
  final Age age;
  final int noOfVacancy;
  final String jobLevel;
  final String jobType;
  final String education;
  final int experience;
  final String gender;
  final String shift;

  BasicInformation({
    required this.age,
    required this.noOfVacancy,
    required this.jobLevel,
    required this.jobType,
    required this.education,
    required this.experience,
    required this.gender,
    required this.shift,
  });

  factory BasicInformation.fromJson(Map<String, dynamic> json) =>
      BasicInformation(
        age: Age.fromJson(json["age"]),
        noOfVacancy: json["noOfVacancy"],
        jobLevel: json["jobLevel"],
        jobType: json["jobType"],
        education: json["education"],
        experience: json["experience"],
        gender: json["gender"],
        shift: json["shift"],
      );

  Map<String, dynamic> toJson() => {
        "age": age.toJson(),
        "noOfVacancy": noOfVacancy,
        "jobLevel": jobLevel,
        "jobType": jobType,
        "education": education,
        "experience": experience,
        "gender": gender,
        "shift": shift,
      };
}

class Age {
  final int min;
  final int max;

  Age({
    required this.min,
    required this.max,
  });

  factory Age.fromJson(Map<String, dynamic> json) => Age(
        min: json["min"],
        max: json["max"],
      );

  Map<String, dynamic> toJson() => {
        "min": min,
        "max": max,
      };
}

class Company {
  final Location location;
  final Logo logo;
  final SocialMedia socialMedia;
  final VerificationDetails verificationDetails;
  final String id;
  final String user;
  final String name;
  final String description;
  final Industry industry;
  final DateTime establishmentDate;
  final String employeeSize;
  final String companyType;
  final String registrationNumber;
  final String website;
  final String email;
  final String contactNumber;
  final List<String> specialties;
  final bool isVerified;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Company({
    required this.location,
    required this.logo,
    required this.socialMedia,
    required this.verificationDetails,
    required this.id,
    required this.user,
    required this.name,
    required this.description,
    required this.industry,
    required this.establishmentDate,
    required this.employeeSize,
    required this.companyType,
    required this.registrationNumber,
    required this.website,
    required this.email,
    required this.contactNumber,
    required this.specialties,
    required this.isVerified,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        location: Location.fromJson(json["location"]),
        logo: Logo.fromJson(json["logo"]),
        socialMedia: SocialMedia.fromJson(json["socialMedia"]),
        verificationDetails:
            VerificationDetails.fromJson(json["verificationDetails"]),
        id: json["_id"],
        user: json["user"],
        name: json["name"],
        description: json["description"],
        industry: Industry.fromJson(json["industry"]),
        establishmentDate: DateTime.parse(json["establishmentDate"]),
        employeeSize: json["employeeSize"],
        companyType: json["companyType"],
        registrationNumber: json["registrationNumber"],
        website: json["website"],
        email: json["email"],
        contactNumber: json["contactNumber"],
        specialties: List<String>.from(json["specialties"].map((x) => x)),
        isVerified: json["isVerified"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "logo": logo.toJson(),
        "socialMedia": socialMedia.toJson(),
        "verificationDetails": verificationDetails.toJson(),
        "_id": id,
        "user": user,
        "name": name,
        "description": description,
        "industry": industry.toJson(),
        "establishmentDate": establishmentDate.toIso8601String(),
        "employeeSize": employeeSize,
        "companyType": companyType,
        "registrationNumber": registrationNumber,
        "website": website,
        "email": email,
        "contactNumber": contactNumber,
        "specialties": List<dynamic>.from(specialties.map((x) => x)),
        "isVerified": isVerified,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Industry {
  final Metadata metadata;
  final String id;
  final String name;
  final bool status;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Industry({
    required this.metadata,
    required this.id,
    required this.name,
    required this.status,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Industry.fromJson(Map<String, dynamic> json) => Industry(
        metadata: Metadata.fromJson(json["metadata"]),
        id: json["_id"],
        name: json["name"],
        status: json["status"],
        image: json["image"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "metadata": metadata.toJson(),
        "_id": id,
        "name": name,
        "status": status,
        "image": image,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Metadata {
  final int jobCount;
  final int companyCount;

  Metadata({
    required this.jobCount,
    required this.companyCount,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        jobCount: json["jobCount"],
        companyCount: json["companyCount"],
      );

  Map<String, dynamic> toJson() => {
        "jobCount": jobCount,
        "companyCount": companyCount,
      };
}

class Location {
  final String province;
  final String district;
  final String municipality;
  final String fullAddress;

  Location({
    required this.province,
    required this.district,
    required this.municipality,
    required this.fullAddress,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
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

class Logo {
  final String url;

  Logo({
    required this.url,
  });

  factory Logo.fromJson(Map<String, dynamic> json) => Logo(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}

class SocialMedia {
  final String linkedin;
  final String twitter;
  final String facebook;
  final String instagram;

  SocialMedia({
    required this.linkedin,
    required this.twitter,
    required this.facebook,
    required this.instagram,
  });

  factory SocialMedia.fromJson(Map<String, dynamic> json) => SocialMedia(
        linkedin: json["linkedin"],
        twitter: json["twitter"],
        facebook: json["facebook"],
        instagram: json["instagram"],
      );

  Map<String, dynamic> toJson() => {
        "linkedin": linkedin,
        "twitter": twitter,
        "facebook": facebook,
        "instagram": instagram,
      };
}

class VerificationDetails {
  final List<dynamic> documents;

  VerificationDetails({
    required this.documents,
  });

  factory VerificationDetails.fromJson(Map<String, dynamic> json) =>
      VerificationDetails(
        documents: List<dynamic>.from(json["documents"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "documents": List<dynamic>.from(documents.map((x) => x)),
      };
}
