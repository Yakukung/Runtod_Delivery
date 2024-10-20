// To parse this JSON data, do
//
//     final usersRegisterPostRequest = usersRegisterPostRequestFromJson(jsonString);

import 'dart:convert';

List<RaiderRegisterPostRequest> usersRegisterPostRequestFromJson(String str) =>
    List<RaiderRegisterPostRequest>.from(
        json.decode(str).map((x) => RaiderRegisterPostRequest.fromJson(x)));

String usersRegisterPostRequestToJson(List<RaiderRegisterPostRequest> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RaiderRegisterPostRequest {
  String fullname;
  String username;
  String email;
  String phone;
  String password;
  String license_plate;

  RaiderRegisterPostRequest({
    required this.fullname,
    required this.username,
    required this.email,
    required this.phone,
    required this.password,
    required this.license_plate,
  });

  factory RaiderRegisterPostRequest.fromJson(Map<String, dynamic> json) =>
      RaiderRegisterPostRequest(
        fullname: json["fullname"],
        username: json["username"],
        email: json["email"],
        phone: json["phone"],
        password: json["password"],
        license_plate: json["license_plate"],
      );

  Map<String, dynamic> toJson() => {
        "fullname": fullname,
        "username": username,
        "email": email,
        "phone": phone,
        "password": password,
        "license_plate": license_plate,
      };
}
