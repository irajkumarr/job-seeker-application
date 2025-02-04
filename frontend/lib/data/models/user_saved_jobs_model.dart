// To parse this JSON data, do
//
//     final userSavedJobsModel = userSavedJobsModelFromJson(jsonString);

import 'dart:convert';

List<UserSavedJobsModel> userSavedJobsModelFromJson(String str) => List<UserSavedJobsModel>.from(json.decode(str).map((x) => UserSavedJobsModel.fromJson(x)));

String userSavedJobsModelToJson(List<UserSavedJobsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserSavedJobsModel {
    final Location? location;
    final String? id;
    final Company? company;
    final String? title;

    UserSavedJobsModel({
        this.location,
        this.id,
        this.company,
        this.title,
    });

    factory UserSavedJobsModel.fromJson(Map<String, dynamic> json) => UserSavedJobsModel(
        location: json["location"] == null ? null : Location.fromJson(json["location"]),
        id: json["_id"],
        company: json["company"] == null ? null : Company.fromJson(json["company"]),
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "location": location?.toJson(),
        "_id": id,
        "company": company?.toJson(),
        "title": title,
    };
}

class Company {
    final Logo? logo;
    final String? id;
    final String? name;

    Company({
        this.logo,
        this.id,
        this.name,
    });

    factory Company.fromJson(Map<String, dynamic> json) => Company(
        logo: json["logo"] == null ? null : Logo.fromJson(json["logo"]),
        id: json["_id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "logo": logo?.toJson(),
        "_id": id,
        "name": name,
    };
}

class Logo {
    final String? url;

    Logo({
        this.url,
    });

    factory Logo.fromJson(Map<String, dynamic> json) => Logo(
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
    };
}

class Location {
    final String? province;
    final String? district;
    final String? municipality;
    final String? fullAddress;

    Location({
        this.province,
        this.district,
        this.municipality,
        this.fullAddress,
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
