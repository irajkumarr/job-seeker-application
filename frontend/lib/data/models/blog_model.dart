// // To parse this JSON data, do
// //
// //     final blogModel = blogModelFromJson(jsonString);

// import 'package:meta/meta.dart';
// import 'dart:convert';

// BlogModel blogModelFromJson(String str) => BlogModel.fromJson(json.decode(str));

// String blogModelToJson(BlogModel data) => json.encode(data.toJson());

// class BlogModel {
//     final int count;
//     final String next;
//     final dynamic previous;
//     final List<Result> results;

//     BlogModel({
//         required this.count,
//         required this.next,
//         required this.previous,
//         required this.results,
//     });

//     factory BlogModel.fromJson(Map<String, dynamic> json) => BlogModel(
//         count: json["count"],
//         next: json["next"],
//         previous: json["previous"],
//         results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "count": count,
//         "next": next,
//         "previous": previous,
//         "results": List<dynamic>.from(results.map((x) => x.toJson())),
//     };
// }

// class Result {
//     final int id;
//     final String excerpt;
//     final String image;
//     final DateTime createdAt;
//     final DateTime modifiedAt;
//     final String slug;
//     final String title;
//     final DateTime scheduledFor;
//     final dynamic deadline;
//     final String status;
//     final int viewCount;
//     final DateTime postedAt;
//     final Category category;
//     final List<Category> tags;

//     Result({
//         required this.id,
//         required this.excerpt,
//         required this.image,
//         required this.createdAt,
//         required this.modifiedAt,
//         required this.slug,
//         required this.title,
//         required this.scheduledFor,
//         required this.deadline,
//         required this.status,
//         required this.viewCount,
//         required this.postedAt,
//         required this.category,
//         required this.tags,
//     });

//     factory Result.fromJson(Map<String, dynamic> json) => Result(
//         id: json["id"],
//         excerpt: json["excerpt"],
//         image: json["image"],
//         createdAt: DateTime.parse(json["created_at"]),
//         modifiedAt: DateTime.parse(json["modified_at"]),
//         slug: json["slug"],
//         title: json["title"],
//         scheduledFor: DateTime.parse(json["scheduled_for"]),
//         deadline: json["deadline"],
//         status: json["status"],
//         viewCount: json["view_count"],
//         postedAt: DateTime.parse(json["posted_at"]),
//         category: Category.fromJson(json["category"]),
//         tags: List<Category>.from(json["tags"].map((x) => Category.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "excerpt": excerpt,
//         "image": image,
//         "created_at": createdAt.toIso8601String(),
//         "modified_at": modifiedAt.toIso8601String(),
//         "slug": slug,
//         "title": title,
//         "scheduled_for": scheduledFor.toIso8601String(),
//         "deadline": deadline,
//         "status": status,
//         "view_count": viewCount,
//         "posted_at": postedAt.toIso8601String(),
//         "category": category.toJson(),
//         "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
//     };
// }

// class Category {
//     final int id;
//     final String name;
//     final String slug;

//     Category({
//         required this.id,
//         required this.name,
//         required this.slug,
//     });

//     factory Category.fromJson(Map<String, dynamic> json) => Category(
//         id: json["id"],
//         name: json["name"],
//         slug: json["slug"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "slug": slug,
//     };
// }


// To parse this JSON data, do
//
//     final blogModel = blogModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

BlogModel blogModelFromJson(String str) => BlogModel.fromJson(json.decode(str));

String blogModelToJson(BlogModel data) => json.encode(data.toJson());

class BlogModel {
    final List<Result> results;

    BlogModel({
        required this.results,
    });

    factory BlogModel.fromJson(Map<String, dynamic> json) => BlogModel(
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Result {
    final int id;
    final String excerpt;
    final String image;
    final DateTime createdAt;
    final DateTime modifiedAt;
    final String slug;
    final String title;
    final DateTime scheduledFor;
    final dynamic deadline;
    final String status;
    final int viewCount;
    final DateTime postedAt;
    final Category category;
    final List<Category> tags;

    Result({
        required this.id,
        required this.excerpt,
        required this.image,
        required this.createdAt,
        required this.modifiedAt,
        required this.slug,
        required this.title,
        required this.scheduledFor,
        required this.deadline,
        required this.status,
        required this.viewCount,
        required this.postedAt,
        required this.category,
        required this.tags,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        excerpt: json["excerpt"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        modifiedAt: DateTime.parse(json["modified_at"]),
        slug: json["slug"],
        title: json["title"],
        scheduledFor: DateTime.parse(json["scheduled_for"]),
        deadline: json["deadline"],
        status: json["status"],
        viewCount: json["view_count"],
        postedAt: DateTime.parse(json["posted_at"]),
        category: Category.fromJson(json["category"]),
        tags: List<Category>.from(json["tags"].map((x) => Category.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "excerpt": excerpt,
        "image": image,
        "created_at": createdAt.toIso8601String(),
        "modified_at": modifiedAt.toIso8601String(),
        "slug": slug,
        "title": title,
        "scheduled_for": scheduledFor.toIso8601String(),
        "deadline": deadline,
        "status": status,
        "view_count": viewCount,
        "posted_at": postedAt.toIso8601String(),
        "category": category.toJson(),
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
    };
}

class Category {
    final int id;
    final String name;
    final String slug;

    Category({
        required this.id,
        required this.name,
        required this.slug,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
    };
}
