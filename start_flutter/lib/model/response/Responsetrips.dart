// To parse this JSON data, do
//
//     final responsetrips = responsetripsFromJson(jsonString);

import 'dart:convert';

List<Responsetrips> responsetripsFromJson(String str) =>
    List<Responsetrips>.from(
      json.decode(str).map((x) => Responsetrips.fromJson(x)),
    );

String responsetripsToJson(List<Responsetrips> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Responsetrips {
  int idx;
  String name;
  String country;
  String coverimage;
  String detail;
  int price;
  int duration;
  String destinationZone;

  Responsetrips({
    required this.idx,
    required this.name,
    required this.country,
    required this.coverimage,
    required this.detail,
    required this.price,
    required this.duration,
    required this.destinationZone,
  });

  factory Responsetrips.fromJson(Map<String, dynamic> json) => Responsetrips(
    idx: json["idx"],
    name: json["name"],
    country: json["country"],
    coverimage: json["coverimage"],
    detail: json["detail"],
    price: json["price"],
    duration: json["duration"],
    destinationZone: json["destination_zone"] ?? "",
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
