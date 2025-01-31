// To parse this JSON data, do
//
//     final trainingModel = trainingModelFromJson(jsonString);

import 'dart:convert';

TrainingModel trainingModelFromJson(String str) => TrainingModel.fromJson(json.decode(str));

String trainingModelToJson(TrainingModel data) => json.encode(data.toJson());

class TrainingModel {
    final String? name;
    final String? institute;
    final Duration? duration;
    final int? completionYear;

    TrainingModel({
        this.name,
        this.institute,
        this.duration,
        this.completionYear,
    });

    factory TrainingModel.fromJson(Map<String, dynamic> json) => TrainingModel(
        name: json["name"],
        institute: json["institute"],
        duration: json["duration"] == null ? null : Duration.fromJson(json["duration"]),
        completionYear: json["completionYear"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "institute": institute,
        "duration": duration?.toJson(),
        "completionYear": completionYear,
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
