// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

FirmaHakkinda firmaFromJson(String str) =>
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
    this.firmaMesaiBas,
    this.firmaMesaiBit,
    this.firmaPuan,
    this.yorumlar,
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
  String firmaMesaiBas;
  String firmaMesaiBit;
  List<Krokiler> krokiler;
  List<Yorumlar> yorumlar;
  String firmaPuan;

  factory FirmaDetay.fromJson(Map<String, dynamic> json) => FirmaDetay(
        firmaId: json["FirmaID"],
        firmaPuan: json["FirmaPuan"].toString(),
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
        firmaMesaiBas: json["MesaiBaslangicSaati"],
        firmaMesaiBit: json["MesaiBitisSaati"],
        krokiler: List<Krokiler>.from(
            json["krokiler"].map((x) => Krokiler.fromJson(x))),
        yorumlar: List<Yorumlar>.from(
            json["yorumlar"].map((x) => Yorumlar.fromJson(x))),
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
        "MesaiBitisSaati": firmaMesaiBit,
        "MesaiBaslangicSaati": firmaMesaiBas,
        "FirmaPuan": firmaPuan,
        "yorumlar": List<dynamic>.from(yorumlar.map((e) => e.topJson())),
        "krokiler": List<dynamic>.from(krokiler.map((x) => x.toJson())),
      };
}

class Yorumlar {
  String musteriAd;
  String yorumIcerik;
  String yorumPuan;
  String yorumTarih;
  String musteriID;
  String yorumID;
  String firmaID;
  String rezervasyonID;
  Yorumlar({
    this.musteriAd,
    this.yorumIcerik,
    this.yorumPuan,
    this.yorumTarih,
    this.musteriID,
    this.yorumID,
    this.firmaID,
    this.rezervasyonID,
  });

  factory Yorumlar.fromJson(Map<String, dynamic> json) => Yorumlar(
        yorumTarih: json["YorumTarih"],
        yorumPuan: json["YorumPuan"],
        yorumIcerik: json["YorumIcerik"],
        musteriAd: json["MusteriAd"],
        rezervasyonID: json["RezervasyonID"],
        firmaID: json["FirmaID"],
        yorumID: json["YorumID"],
        musteriID: json["MusteriID"],
      );

  Map<String, dynamic> topJson() => {
        "YorumTarih": yorumTarih,
        "YorumPuan": yorumPuan,
        "YorumIcerik": yorumIcerik,
        "MusteriAd": musteriAd,
        "RezervasyonID": rezervasyonID,
        "FirmaID": firmaID,
        "YorumID": yorumID,
        "MusteriID": musteriID,
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
