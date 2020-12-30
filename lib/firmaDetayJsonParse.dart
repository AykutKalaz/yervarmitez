// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

FirmaHakkinda welcomeFromJson(String str) =>
    FirmaHakkinda.fromJson(json.decode(str));

String welcomeToJson(FirmaHakkinda data) => json.encode(data.toJson());

class FirmaHakkinda {
  FirmaHakkinda({
    this.status,
    this.message,
    this.firmaDetay,
  });

  String status;
  String message;
  FirmaDetay firmaDetay;

  factory FirmaHakkinda.fromJson(Map<String, dynamic> json) => FirmaHakkinda(
        status: json["status"],
        message: json["message"],
        firmaDetay: FirmaDetay.fromJson(json["FirmaDetay"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "FirmaDetay": firmaDetay.toJson(),
      };
}

class FirmaDetay {
  FirmaDetay({
    this.firmaId,
    this.firmaAd,
    this.firmaSifre,
    this.firmaEmail,
    this.firmaTelefon,
    this.firmaAdres,
    this.firmaLogo,
    this.firmaKayitTarihi,
    this.firmaToken,
    this.ilceNo,
    this.ilNo,
    this.kategoriId,
    this.krokiler,
  });

  String firmaId;
  String firmaAd;
  String firmaSifre;
  String firmaEmail;
  String firmaTelefon;
  String firmaAdres;
  String firmaLogo;
  DateTime firmaKayitTarihi;
  String firmaToken;
  String ilceNo;
  String ilNo;
  String kategoriId;
  List<Krokiler> krokiler;

  factory FirmaDetay.fromJson(Map<String, dynamic> json) => FirmaDetay(
        firmaId: json["FirmaID"],
        firmaAd: json["FirmaAd"],
        firmaSifre: json["FirmaSifre"],
        firmaEmail: json["FirmaEmail"],
        firmaTelefon: json["FirmaTelefon"],
        firmaAdres: json["FirmaAdres"],
        firmaLogo: json["FirmaLogo"],
        firmaKayitTarihi: DateTime.parse(json["FirmaKayitTarihi"]),
        firmaToken: json["FirmaToken"],
        ilceNo: json["ilce_no"],
        ilNo: json["il_no"],
        kategoriId: json["KategoriID"],
        krokiler: List<Krokiler>.from(
            json["krokiler"].map((x) => Krokiler.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "FirmaID": firmaId,
        "FirmaAd": firmaAd,
        "FirmaSifre": firmaSifre,
        "FirmaEmail": firmaEmail,
        "FirmaTelefon": firmaTelefon,
        "FirmaAdres": firmaAdres,
        "FirmaLogo": firmaLogo,
        "FirmaKayitTarihi": firmaKayitTarihi.toIso8601String(),
        "FirmaToken": firmaToken,
        "ilce_no": ilceNo,
        "il_no": ilNo,
        "KategoriID": kategoriId,
        "krokiler": List<dynamic>.from(krokiler.map((x) => x.toJson())),
      };
}

class Krokiler {
  Krokiler({
    this.krokiId,
    this.firmaId,
    this.krokiResim,
    this.krokiBaslik,
    this.krokiBirimSaat,
    this.krokiBirimFiyat,
    this.masalar,
  });

  String krokiId;
  String firmaId;
  String krokiResim;
  String krokiBaslik;
  String krokiBirimSaat;
  String krokiBirimFiyat;
  List<Masalar> masalar;

  factory Krokiler.fromJson(Map<String, dynamic> json) => Krokiler(
        krokiId: json["KrokiID"],
        firmaId: json["FirmaID"],
        krokiResim: json["KrokiResim"],
        krokiBaslik: json["KrokiBaslik"],
        krokiBirimSaat: json["KrokiBirimSaat"],
        krokiBirimFiyat: json["KrokiBirimFiyat"],
        masalar:
            List<Masalar>.from(json["masalar"].map((x) => Masalar.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "KrokiID": krokiId,
        "FirmaID": firmaId,
        "KrokiResim": krokiResim,
        "KrokiBaslik": krokiBaslik,
        "KrokiBirimSaat": krokiBirimSaat,
        "KrokiBirimFiyat": krokiBirimFiyat,
        "masalar": List<dynamic>.from(masalar.map((x) => x.toJson())),
      };
}

class Masalar {
  Masalar({
    this.masaId,
    this.krokiId,
    this.masaNo,
  });

  String masaId;
  String krokiId;
  String masaNo;

  factory Masalar.fromJson(Map<String, dynamic> json) => Masalar(
        masaId: json["MasaID"],
        krokiId: json["KrokiID"],
        masaNo: json["MasaNo"],
      );

  Map<String, dynamic> toJson() => {
        "MasaID": masaId,
        "KrokiID": krokiId,
        "MasaNo": masaNo,
      };
}
