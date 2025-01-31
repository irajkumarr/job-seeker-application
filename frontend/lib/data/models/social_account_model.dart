// To parse this JSON data, do
//
//     final socialAccountModel = socialAccountModelFromJson(jsonString);

import 'dart:convert';

SocialAccountModel socialAccountModelFromJson(String str) => SocialAccountModel.fromJson(json.decode(str));

String socialAccountModelToJson(SocialAccountModel data) => json.encode(data.toJson());

class SocialAccountModel {
    final String? platform;
    final String? url;

    SocialAccountModel({
        this.platform,
        this.url,
    });

    factory SocialAccountModel.fromJson(Map<String, dynamic> json) => SocialAccountModel(
        platform: json["platform"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "platform": platform,
        "url": url,
    };
}
