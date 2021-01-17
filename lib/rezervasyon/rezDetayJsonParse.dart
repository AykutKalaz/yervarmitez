import 'dart:convert';

RezDetay RezFromJson(String str) => RezDetay.fromJson(json.decode(str));

String RezToJson(RezDetay data) => json.encode(data.toJson());

class RezDetay {
  RezDetay({
    this.status,
    this.message,
    this.rezervasyonData,
  });

  String status;
  String message;
  RezervasyonData rezervasyonData;

  factory RezDetay.fromJson(Map<String, dynamic> json) => RezDetay(
        status: json["status"],
        message: json["message"],
        rezervasyonData: RezervasyonData.fromJson(json["RezervasyonData"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "RezervasyonData": rezervasyonData.toJson(),
      };
}

class RezervasyonData {
  RezervasyonData({
    this.firmaAd,
    this.firmaAdres,
    this.firmaTelefon,
    this.masaNo,
    this.krokiResim,
    this.krokiBaslik,
    this.rezervasyonBaslangicTarih,
    this.rezervasyonBitisTarih,
    this.rezervasyonToplamFiyat,
    this.durumId,
  });

  String firmaAd;
  String firmaAdres;
  String firmaTelefon;
  String masaNo;
  String krokiResim;
  String krokiBaslik;
  String rezervasyonBaslangicTarih;
  String rezervasyonBitisTarih;
  String rezervasyonToplamFiyat;
  String durumId;

  factory RezervasyonData.fromJson(Map<String, dynamic> json) =>
      RezervasyonData(
        firmaAd: json["FirmaAd"],
        firmaAdres: json["FirmaAdres"],
        firmaTelefon: json["FirmaTelefon"],
        masaNo: json["MasaNo"],
        krokiResim: json["KrokiResim"],
        krokiBaslik: json["KrokiBaslik"],
        rezervasyonBaslangicTarih: json["RezervasyonBaslangicTarih"],
        rezervasyonBitisTarih: json["RezervasyonBitisTarih"],
        rezervasyonToplamFiyat: json["RezervasyonToplamFiyat"],
        durumId: json["DurumID"],
      );

  Map<String, dynamic> toJson() => {
        "FirmaAd": firmaAd,
        "FirmaAdres": firmaAdres,
        "FirmaTelefon": firmaTelefon,
        "MasaNo": masaNo,
        "KrokiResim": krokiResim,
        "KrokiBaslik": krokiBaslik,
        "RezervasyonBaslangicTarih": rezervasyonBaslangicTarih,
        "RezervasyonBitisTarih": rezervasyonBitisTarih,
        "RezervasyonToplamFiyat": rezervasyonToplamFiyat,
        "DurumID": durumId,
      };
}
