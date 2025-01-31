// // To parse this JSON data, do
// //
// //     final contactInformationModel = contactInformationModelFromJson(jsonString);

// import 'dart:convert';

// ContactInformationModel contactInformationModelFromJson(String str) => ContactInformationModel.fromJson(json.decode(str));

// String contactInformationModelToJson(ContactInformationModel data) => json.encode(data.toJson());

// class ContactInformationModel {
//     final String? fullName;
//     final String? address;
//     final String? relation;
//     final String? phoneNumber;

//     ContactInformationModel({
//         this.fullName,
//         this.address,
//         this.relation,
//         this.phoneNumber,
//     });

//     factory ContactInformationModel.fromJson(Map<String, dynamic> json) => ContactInformationModel(
//         fullName: json["fullName"],
//         address: json["address"],
//         relation: json["relation"],
//         phoneNumber: json["phoneNumber"],
//     );

//     Map<String, dynamic> toJson() => {
//         "fullName": fullName,
//         "address": address,
//         "relation": relation,
//         "phoneNumber": phoneNumber,
//     };
// }

// To parse this JSON data, do
//
//     final contactInformationModel = contactInformationModelFromJson(jsonString);

import 'dart:convert';

ContactInformationModel contactInformationModelFromJson(String str) =>
    ContactInformationModel.fromJson(json.decode(str));

String contactInformationModelToJson(ContactInformationModel data) =>
    json.encode(data.toJson());

class ContactInformationModel {
  final String? userId;
  final String? fullName;
  final String? address;
  final String? relation;
  final PhoneNumber? phoneNumber;

  ContactInformationModel({
    this.userId,
    this.fullName,
    this.address,
    this.relation,
    this.phoneNumber,
  });

  factory ContactInformationModel.fromJson(Map<String, dynamic> json) =>
      ContactInformationModel(
        userId: json["userId"],
        fullName: json["fullName"],
        address: json["address"],
        relation: json["relation"],
        phoneNumber: json["phoneNumber"] == null
            ? null
            : PhoneNumber.fromJson(json["phoneNumber"]),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "fullName": fullName,
        "address": address,
        "relation": relation,
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
