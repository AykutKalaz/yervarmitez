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
  String durum;

  factory SaatDatum.fromJson(Map<String, dynamic> json) => SaatDatum(
        saat: json["Saat"],
        durum: json["Durum"],
      );

  Map<String, dynamic> toJson() => {
        "Saat": saat,
        "Durum": durum,
      };
}
