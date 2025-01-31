// To parse this JSON data, do
//
//     final documentModel = documentModelFromJson(jsonString);

import 'dart:convert';

DocumentModel documentModelFromJson(String str) => DocumentModel.fromJson(json.decode(str));

String documentModelToJson(DocumentModel data) => json.encode(data.toJson());

class DocumentModel {
    final String? title;
    final String? category;
    final String? file;

    DocumentModel({
        this.title,
        this.category,
        this.file,
    });

    factory DocumentModel.fromJson(Map<String, dynamic> json) => DocumentModel(
        title: json["title"],
        category: json["category"],
        file: json["file"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "category": category,
        "file": file,
    };
}
