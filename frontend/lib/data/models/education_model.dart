// // To parse this JSON data, do
// //
// //     final educationModel = educationModelFromJson(jsonString);

// import 'dart:convert';

// EducationModel educationModelFromJson(String str) => EducationModel.fromJson(json.decode(str));

// String educationModelToJson(EducationModel data) => json.encode(data.toJson());

// class EducationModel {
//     final String? level;
//     final String? institution;
//     final String? major;
//     final DateTime? startDate;
//     final DateTime? endDate;
//     final String? grade;

//     EducationModel({
//         this.level,
//         this.institution,
//         this.major,
//         this.startDate,
//         this.endDate,
//         this.grade,
//     });

//     factory EducationModel.fromJson(Map<String, dynamic> json) => EducationModel(
//         level: json["level"],
//         institution: json["institution"],
//         major: json["major"],
//         startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
//         endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
//         grade: json["grade"],
//     );

//     Map<String, dynamic> toJson() => {
//         "level": level,
//         "institution": institution,
//         "major": major,
//         "startDate": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
//         "endDate": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
//         "grade": grade,
//     };
// }

// To parse this JSON data, do
//
//     final educationModel = educationModelFromJson(jsonString);

import 'dart:convert';

EducationModel educationModelFromJson(String str) =>
    EducationModel.fromJson(json.decode(str));

String educationModelToJson(EducationModel data) => json.encode(data.toJson());

class EducationModel {
  final String? level;
  final String? educationProgram;
  final String? educationBoard;
  final String? institution;
  final GraduationYear? startDate;
  final GraduationYear? graduationYear;
  final Grade? grade;

  EducationModel({
    this.level,
    this.educationProgram,
    this.educationBoard,
    this.institution,
    this.startDate,
    this.graduationYear,
    this.grade,
  });

  factory EducationModel.fromJson(Map<String, dynamic> json) => EducationModel(
        level: json["level"],
        educationProgram: json["educationProgram"],
        educationBoard: json["educationBoard"],
        institution: json["institution"],
        startDate: json["startDate"] == null
            ? null
            : GraduationYear.fromJson(json["startDate"]),
        graduationYear: json["graduationYear"] == null
            ? null
            : GraduationYear.fromJson(json["graduationYear"]),
        grade: json["grade"] == null ? null : Grade.fromJson(json["grade"]),
      );

  Map<String, dynamic> toJson() => {
        "level": level,
        "educationProgram": educationProgram,
        "educationBoard": educationBoard,
        "institution": institution,
        "startDate": startDate?.toJson(),
        "graduationYear": graduationYear?.toJson(),
        "grade": grade?.toJson(),
      };
}

class Grade {
  final String? type;
  final String? marks;

  Grade({
    this.type,
    this.marks,
  });

  factory Grade.fromJson(Map<String, dynamic> json) => Grade(
        type: json["type"],
        marks: json["marks"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "marks": marks,
      };
}

class GraduationYear {
  final String? year;
  final String? month;

  GraduationYear({
    this.year,
    this.month,
  });

  factory GraduationYear.fromJson(Map<String, dynamic> json) => GraduationYear(
        year: json["year"],
        month: json["month"],
      );

  Map<String, dynamic> toJson() => {
        "year": year,
        "month": month,
      };
}
