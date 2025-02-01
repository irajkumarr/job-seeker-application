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
    final CompletionYear? completionYear;

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
        completionYear: json["completionYear"] == null ? null : CompletionYear.fromJson(json["completionYear"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "institute": institute,
        "duration": duration?.toJson(),
        "completionYear": completionYear?.toJson(),
    };
}

class Duration {
    final String? value;
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


class CompletionYear {
    final String? year;
    final String? month;

    CompletionYear({
        this.year,
        this.month,
    });

    factory CompletionYear.fromJson(Map<String, dynamic> json) => CompletionYear(
        year: json["year"],
        month: json["month"],
    );

    Map<String, dynamic> toJson() => {
        "year": year,
        "month": month,
    };
}
