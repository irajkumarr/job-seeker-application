// To parse this JSON data, do
//
//     final referenceModel = referenceModelFromJson(jsonString);

import 'dart:convert';

ReferenceModel referenceModelFromJson(String str) =>
    ReferenceModel.fromJson(json.decode(str));

String referenceModelToJson(ReferenceModel data) => json.encode(data.toJson());

class ReferenceModel {
  final String? name;
  final String? designation;
  final String? organization;
  final String? email;
  final PhoneNumber? phoneNumber;

  ReferenceModel({
    this.name,
    this.designation,
    this.organization,
    this.email,
    this.phoneNumber,
  });

  factory ReferenceModel.fromJson(Map<String, dynamic> json) => ReferenceModel(
        name: json["name"],
        designation: json["designation"],
        organization: json["organization"],
        email: json["email"],
        phoneNumber: json["phoneNumber"] == null
            ? null
            : PhoneNumber.fromJson(json["phoneNumber"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "designation": designation,
        "organization": organization,
        "email": email,
        "phoneNumber": phoneNumber?.toJson(),
      };
}

class PhoneNumber {
  final String? numberType;
  final String? mobileNumber;

  PhoneNumber({
    this.numberType,
    this.mobileNumber,
  });

  factory PhoneNumber.fromJson(Map<String, dynamic> json) => PhoneNumber(
        numberType: json["numberType"],
        mobileNumber: json["mobileNumber"],
      );

  Map<String, dynamic> toJson() => {
        "numberType": numberType,
        "mobileNumber": mobileNumber,
      };
}
