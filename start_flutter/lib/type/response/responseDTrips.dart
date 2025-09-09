// To parse this JSON data, do
//
//     final responseDTrips = responseDTripsFromJson(jsonString);

import 'dart:convert';

ResponseDTrips responseDTripsFromJson(String str) =>
    ResponseDTrips.fromJson(json.decode(str));

String responseDTripsToJson(ResponseDTrips data) => json.encode(data.toJson());

class ResponseDTrips {
  int idx;
  String name;
  String country;
  String coverimage;
  String detail;
  int price;
  int duration;
  String destinationZone;

  ResponseDTrips({
    required this.idx,
    required this.name,
    required this.country,
    required this.coverimage,
    required this.detail,
    required this.price,
    required this.duration,
    required this.destinationZone,
  });

  factory ResponseDTrips.fromJson(Map<String, dynamic> json) => ResponseDTrips(
    idx: json["idx"],
    name: json["name"],
    country: json["country"],
    coverimage: json["coverimage"],
    detail: json["detail"],
    price: json["price"],
    duration: json["duration"],
    destinationZone: json["destination_zone"],
  );

  Map<String, dynamic> toJson() => {
    "idx": idx,
    "name": name,
    "country": country,
    "coverimage": coverimage,
    "detail": detail,
    "price": price,
    "duration": duration,
    "destination_zone": destinationZone,
  };
}
