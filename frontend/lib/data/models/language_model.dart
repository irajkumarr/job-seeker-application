// To parse this JSON data, do
//
//     final languageModel = languageModelFromJson(jsonString);

import 'dart:convert';

LanguageModel languageModelFromJson(String str) => LanguageModel.fromJson(json.decode(str));

String languageModelToJson(LanguageModel data) => json.encode(data.toJson());

class LanguageModel {
    final String? name;
    final double? score;

    LanguageModel({
        this.name,
        this.score,
    });

    factory LanguageModel.fromJson(Map<String, dynamic> json) => LanguageModel(
        name: json["name"],
        score: json["score"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "score": score,
    };
}
