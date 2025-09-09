// To parse this JSON data, do
//
//     final responseA = responseAFromJson(jsonString);

import 'dart:convert';

ResponseA responseAFromJson(String str) => ResponseA.fromJson(json.decode(str));

String responseAToJson(ResponseA data) => json.encode(data.toJson());

class ResponseA {
  String message;
  int status;

  ResponseA({required this.message, required this.status});

  factory ResponseA.fromJson(Map<String, dynamic> json) =>
      ResponseA(message: json["message"], status: json["status"]);

  Map<String, dynamic> toJson() => {"message": message, "status": status};
}
