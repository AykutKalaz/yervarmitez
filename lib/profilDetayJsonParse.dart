import 'dart:convert';

ProfilDetay profilFromJson(String str) =>
    ProfilDetay.fromJson(json.decode(str));

String welcomeToJson(ProfilDetay data) => json.encode(data.toJson());

class ProfilDetay {
  ProfilDetay({
    this.status,
    this.message,
    this.userInfo,
  });

  String status;
  String message;
  List<UserInfo> userInfo;

  factory ProfilDetay.fromJson(Map<String, dynamic> json) => ProfilDetay(
        status: json["status"],
        message: json["message"],
        userInfo: List<UserInfo>.from(
            json["userInfo"].map((x) => UserInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "userInfo": List<dynamic>.from(userInfo.map((x) => x.toJson())),
      };
}

class UserInfo {
  UserInfo({
    this.musteriId,
    this.musteriAd,
    this.musteriSoyad,
    this.musteriSifre,
    this.musteriEmail,
    this.musteriTelefon,
    this.musteriKayitTarihi,
  });

  String musteriId;
  String musteriAd;
  String musteriSoyad;
  String musteriSifre;
  String musteriEmail;
  String musteriTelefon;
  DateTime musteriKayitTarihi;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        musteriId: json["MusteriID"],
        musteriAd: json["MusteriAd"],
        musteriSoyad: json["MusteriSoyad"],
        musteriSifre: json["MusteriSifre"],
        musteriEmail: json["MusteriEmail"],
        musteriTelefon: json["MusteriTelefon"],
        musteriKayitTarihi: DateTime.parse(json["MusteriKayitTarihi"]),
      );

  Map<String, dynamic> toJson() => {
        "MusteriID": musteriId,
        "MusteriAd": musteriAd,
        "MusteriSoyad": musteriSoyad,
        "MusteriSifre": musteriSifre,
        "MusteriEmail": musteriEmail,
        "MusteriTelefon": musteriTelefon,
        "MusteriKayitTarihi": musteriKayitTarihi.toIso8601String(),
      };
}
