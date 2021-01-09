// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

MasaHakkinda masaFromJson(String str) =>
    MasaHakkinda.fromJson(json.decode(str));

String welcomeToJson(MasaHakkinda data) => json.encode(data.toJson());

class MasaHakkinda {
  MasaHakkinda({
    this.status,
    this.message,
    this.saatData,
  });

  String status;
  String message;
  List<SaatDatum> saatData;

  factory MasaHakkinda.fromJson(Map<String, dynamic> json) => MasaHakkinda(
        status: json["status"],
        message: json["message"],
        saatData: List<SaatDatum>.from(
            json["SaatData"].map((x) => SaatDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "SaatData": List<dynamic>.from(saatData.map((x) => x.toJson())),
      };
}

class SaatDatum {
  SaatDatum({
    this.saat,
    this.durum,
  });

  String saat;
  Durum durum;

  factory SaatDatum.fromJson(Map<String, dynamic> json) => SaatDatum(
        saat: json["Saat"],
        durum: durumValues.map[json["Durum"]],
      );

  Map<String, dynamic> toJson() => {
        "Saat": saat,
        "Durum": durumValues.reverse[durum],
      };
}

enum Durum { BO, DOLU }

final durumValues = EnumValues({"Boş": Durum.BO, "Dolu": Durum.DOLU});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
