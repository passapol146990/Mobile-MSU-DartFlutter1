// To parse this JSON data, do
//
//     final customerLoginPostRequests = customerLoginPostRequestsFromJson(jsonString);

import 'dart:convert';

CustomerLoginPostRequests customerLoginPostRequestsFromJson(String str) =>
    CustomerLoginPostRequests.fromJson(json.decode(str));

String customerLoginPostRequestsToJson(CustomerLoginPostRequests data) =>
    json.encode(data.toJson());

class CustomerLoginPostRequests {
  String phone;
  String password;

  CustomerLoginPostRequests({required this.phone, required this.password});

  factory CustomerLoginPostRequests.fromJson(Map<String, dynamic> json) =>
      CustomerLoginPostRequests(
        phone: json["phone"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {"phone": phone, "password": password};
}
