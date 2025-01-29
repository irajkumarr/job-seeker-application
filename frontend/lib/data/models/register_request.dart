// To parse this JSON data, do
//
//     final registerRequest = registerRequestFromJson(jsonString);

import 'dart:convert';

RegisterRequest registerRequestFromJson(String str) => RegisterRequest.fromJson(json.decode(str));

String registerRequestToJson(RegisterRequest data) => json.encode(data.toJson());

class RegisterRequest {
    final String name;
    final String mobileNumber;
    final String password;

    RegisterRequest({
        required this.name,
        required this.mobileNumber,
        required this.password,
    });

    factory RegisterRequest.fromJson(Map<String, dynamic> json) => RegisterRequest(
        name: json["name"],
        mobileNumber: json["mobileNumber"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "mobileNumber": mobileNumber,
        "password": password,
    };
}
