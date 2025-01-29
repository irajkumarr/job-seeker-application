// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    final String id;
    final String name;
    final String mobileNumber;
    final String userType;
    final bool isActive;
    final String userToken;

    LoginModel({
        required this.id,
        required this.name,
        required this.mobileNumber,
        required this.userType,
        required this.isActive,
        required this.userToken,
    });

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        id: json["_id"],
        name: json["name"],
        mobileNumber: json["mobileNumber"],
        userType: json["userType"],
        isActive: json["isActive"],
        userToken: json["userToken"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "mobileNumber": mobileNumber,
        "userType": userType,
        "isActive": isActive,
        "userToken": userToken,
    };
}
