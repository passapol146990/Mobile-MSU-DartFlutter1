// To parse this JSON data, do
//
//     final responseDUser = responseDUserFromJson(jsonString);

import 'dart:convert';

ResponseDUser responseDUserFromJson(String str) =>
    ResponseDUser.fromJson(json.decode(str));

String responseDUserToJson(ResponseDUser data) => json.encode(data.toJson());

class ResponseDUser {
  int idx;
  String fullname;
  String phone;
  String email;
  String image;

  ResponseDUser({
    required this.idx,
    required this.fullname,
    required this.phone,
    required this.email,
    required this.image,
  });

  factory ResponseDUser.fromJson(Map<String, dynamic> json) => ResponseDUser(
    idx: json["idx"],
    fullname: json["fullname"],
    phone: json["phone"],
    email: json["email"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "idx": idx,
    "fullname": fullname,
    "phone": phone,
    "email": email,
    "image": image,
  };
}
