// To parse this JSON data, do
//
//     final loginRequest = loginRequestFromJson(jsonString);

import 'dart:convert';

LoginRequest loginRequestFromJson(String str) => LoginRequest.fromJson(json.decode(str));

String loginRequestToJson(LoginRequest data) => json.encode(data.toJson());

class LoginRequest {
    final String mobileNumber;
    final String password;

    LoginRequest({
        required this.mobileNumber,
        required this.password,
    });

    factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
        mobileNumber: json["mobileNumber"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "mobileNumber": mobileNumber,
        "password": password,
    };
}
