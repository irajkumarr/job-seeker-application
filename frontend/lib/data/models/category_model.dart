// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

List<CategoryModel> categoryModelFromJson(String str) => List<CategoryModel>.from(json.decode(str).map((x) => CategoryModel.fromJson(x)));

String categoryModelToJson(List<CategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModel {
    final Metadata metadata;
    final String id;
    final String name;
    final bool status;
    final String image;

    CategoryModel({
        required this.metadata,
        required this.id,
        required this.name,
        required this.status,
        required this.image,
    });

    factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        metadata: Metadata.fromJson(json["metadata"]),
        id: json["_id"],
        name: json["name"],
        status: json["status"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "metadata": metadata.toJson(),
        "_id": id,
        "name": name,
        "status": status,
        "image": image,
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
