// To parse this JSON data, do
//
//     final jobApplicationModel = jobApplicationModelFromJson(jsonString);

import 'dart:convert';

import 'package:frontend/data/models/job_model.dart';

List<JobApplicationModel> jobApplicationModelFromJson(String str) =>
    List<JobApplicationModel>.from(
        json.decode(str).map((x) => JobApplicationModel.fromJson(x)));

String jobApplicationModelToJson(List<JobApplicationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JobApplicationModel {
  final String? id;
  final JobModel? job;
  final String? applicant;
  final String? status;
  final String? applicationStatus;
  final DateTime? appliedAt;
  final DateTime? updatedAt;
  final List<dynamic>? notes;
  final DateTime? createdAt;
  final int? v;

  JobApplicationModel({
    this.id,
    this.job,
    this.applicant,
    this.status,
    this.applicationStatus,
    this.appliedAt,
    this.updatedAt,
    this.notes,
    this.createdAt,
    this.v,
  });

  factory JobApplicationModel.fromJson(Map<String, dynamic> json) =>
      JobApplicationModel(
        id: json["_id"],
        job: json["job"] == null ? null : JobModel.fromJson(json["job"]),
        applicant: json["applicant"],
        status: json["status"],
        applicationStatus: json["applicationStatus"],
        appliedAt: json["appliedAt"] == null
            ? null
            : DateTime.parse(json["appliedAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        notes: json["notes"] == null
            ? []
            : List<dynamic>.from(json["notes"]!.map((x) => x)),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "job": job?.toJson(),
        "applicant": applicant,
        "status": status,
        "applicationStatus": applicationStatus,
        "appliedAt": appliedAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "notes": notes == null ? [] : List<dynamic>.from(notes!.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
      };
}
