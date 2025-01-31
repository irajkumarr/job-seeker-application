// To parse this JSON data, do
//
//     final educationModel = educationModelFromJson(jsonString);

import 'dart:convert';

EducationModel educationModelFromJson(String str) => EducationModel.fromJson(json.decode(str));

String educationModelToJson(EducationModel data) => json.encode(data.toJson());

class EducationModel {
    final String? level;
    final String? institution;
    final String? major;
    final DateTime? startDate;
    final DateTime? endDate;
    final String? grade;

    EducationModel({
        this.level,
        this.institution,
        this.major,
        this.startDate,
        this.endDate,
        this.grade,
    });

    factory EducationModel.fromJson(Map<String, dynamic> json) => EducationModel(
        level: json["level"],
        institution: json["institution"],
        major: json["major"],
        startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
        endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        grade: json["grade"],
    );

    Map<String, dynamic> toJson() => {
        "level": level,
        "institution": institution,
        "major": major,
        "startDate": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "endDate": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "grade": grade,
    };
}
