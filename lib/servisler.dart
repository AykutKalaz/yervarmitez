import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yervarmitez/firmaDetayJsonParse.dart';
import 'package:yervarmitez/masaDetayJsonParse.dart';
import 'package:yervarmitez/profilDetayJsonParse.dart';

import 'file:///E:/flutter/yervarmitez/lib/rezervasyon/rezDetayJsonParse.dart';
import 'file:///E:/flutter/yervarmitez/lib/rezervasyon/rezDetayOlustur.dart';

import 'components/kategoriOlusturucu.dart';
import 'ekranlar/kategoriler/kategori.dart';
import 'ilceler.dart';
import 'iller.dart';

Future<String> KayitBilgiGonder(String musteriMail, String musteriAdi,
    String musteriSoyadi, String musteriTelefon, String musteriSifre) async {
  http.Response response = await http
      .post('http://www.burkayarac.com.tr/yervarmi/api/kayit-ol.php', body: {
    "MusteriEmail": musteriMail,
    "MusteriAd": musteriAdi,
    "MusteriSoyad": musteriSoyadi,
    "MusteriSifre": musteriSifre,
    "MusteriTelefon": musteriTelefon
  });
  String mesaj = jsonDecode(response.body)["message"];
  return mesaj;
}

Future<String> GirisBilgiGonder(String musteriMail, String musteriSifre) async {
  http.Response response = await http
      .post('http://www.burkayarac.com.tr/yervarmi/api/giris-yap.php', body: {
    "MusteriEmail": musteriMail,
    "MusteriSifre": musteriSifre,
  });
  String musteriID = jsonDecode(response.body)["userInfo"];
  return musteriID;
}

Future<List<Widget>> KategoriBilgiGetir(String userID) async {
  List<Widget> kategori = [];
  List<Kategori> kategoriSinif = [];
  http.Response response = await http
      .post('http://www.burkayarac.com.tr/yervarmi/api/kategori-listele.php');
  var kategoriListe = [];
  kategoriListe = jsonDecode(response.body)["KategoriData"];
  for (int i = 0; i < kategoriListe.length; i++) {
    kategoriSinif.add(new Kategori(
        kategoriID: int.parse(kategoriListe[i]["KategoriID"].toString()),
        kategoriAdi: kategoriListe[i]["KategoriAdi"].toString(),
        kategoriResmi: kategoriListe[i]["KategoriResim"].toString()));
  }
  for (int i = 0; i < kategoriSinif.length; i++) {
    kategori.add(KategoriOlustur(
      userID: userID,
      kategoriID: kategoriSinif[i].kategoriID,
      kategoriResmi: kategoriSinif[i].kategoriResmi,
      kategoriAdi: kategoriSinif[i].kategoriAdi,
    ));
  }
  return kategori;
}

Future<List<Iller>> ilGetir() async {
  List<Iller> illerListe = [];
  http.Response response =
      await http.post('http://burkayarac.com.tr/yervarmi/api/il-listele.php');
  var ilListe = [];
  ilListe = jsonDecode(response.body)["IlData"];
  for (int i = 0; i < ilListe.length; i++) {
    illerListe.add(
      new Iller(
        ilID: int.parse(ilListe[i]["il_no"].toString()),
        ilAdi: ilListe[i]["isim"].toString(),
      ),
    );
  }
  return illerListe;
}

Future<List<Ilceler>> ilceGetir(int il_no) async {
  List<Ilceler> ilcelerListe = [];
  http.Response response = await http.post(
    'http://burkayarac.com.tr/yervarmi/api/ilce-listele.php/',
    body: {
      "il_no": il_no.toString(),
    },
  );
  var ilceListe = [];
  ilceListe = jsonDecode(response.body)["IlceData"];
  for (int i = 0; i < ilceListe.length; i++) {
    ilcelerListe.add(
      new Ilceler(
          ilceID: int.parse(ilceListe[i]["ilce_no"].toString()),
          ilceAdi: ilceListe[i]["isim"]),
    );
  }
  return ilcelerListe;
}

Future<List<Firma>> firmaGetir(int ilce_no, int KategoriID) async {
  List<Firma> firmalar = [];
  http.Response response = await http
      .post('http://burkayarac.com.tr/yervarmi/api/firma-listele.php/', body: {
    "ilce_no": ilce_no.toString(),
    "KategoriID": KategoriID.toString(),
  });
  var firmaListe = [];
  String mesaj = "";
  mesaj = jsonDecode(response.body)["message"];
  if (mesaj == "Firma bulunamadı.") {
    print("boş değer döndü.");
  } else {
    firmaListe = jsonDecode(response.body)["FirmaData"];
    for (int i = 0; i < firmaListe.length; i++) {
      firmalar.add(
        new Firma(
          firmaID: int.parse(firmaListe[i]["FirmaID"]),
          firmaAdi: firmaListe[i]["FirmaAd"],
          firmaAdres: firmaListe[i]["FirmaAdres"],
          firmaLogo: firmaListe[i]["FirmaLogo"],
          firmaPuan: firmaListe[i]["FirmaPuan"].toString(),
        ),
      );
    }
  }
  return firmalar;
}

Future<FirmaHakkinda> firmaDetayGetir(int firmaID) async {
  http.Response response = await http.post(
    "http://burkayarac.com.tr/yervarmi/api/firma-detay.php",
    body: {
      "firmaID": firmaID.toString(),
    },
  );
  final FirmaHakkinda firmaDetay = firmaFromJson(response.body);
  return firmaDetay;
}

Future<MasaHakkinda> masaBilgiGetir(
    int firmaID, String masaID, String tarih) async {
  http.Response response = await http.post(
    "http://burkayarac.com.tr/yervarmi/api/masa-saat-listele.php",
    body: {
      "firmaID": firmaID.toString(),
      "masaID": masaID,
      "Tarih": tarih,
    },
  );
  final MasaHakkinda masaDetay = masaFromJson(response.body);
  return masaDetay;
}

Future<ProfilDetay> profilDetayGetir(String musteriID) async {
  http.Response response = await http.post(
    "https://burkayarac.com.tr/yervarmi/api/profil-detay.php",
    body: {
      "MusteriID": musteriID,
    },
  );
  final ProfilDetay profilDetay = profilFromJson(response.body);
  return profilDetay;
}

Future<String> profilBilgiGuncelle(
    String musteriMail,
    String musteriAdi,
    String musteriSoyadi,
    String musteriTelefon,
    String musteriSifre,
    String musteriID) async {
  http.Response response = await http.post(
      'https://burkayarac.com.tr/yervarmi/api/profil-guncelle.php',
      body: {
        "MusteriID": musteriID,
        "MusteriEmail": musteriMail,
        "MusteriAd": musteriAdi,
        "MusteriSoyad": musteriSoyadi,
        "MusteriSifre": musteriSifre,
        "MusteriTelefon": musteriTelefon
      });
  String Mesaj = jsonDecode(response.body)["message"];
  return Mesaj;
}

Future<String> rezervasyonTamamla(
  String masaID,
  String tarih,
  String basSaati,
  String bitSaati,
  String musteriID,
) async {
  http.Response response = await http.post(
      "http://www.burkayarac.com.tr/yervarmi/api/rezervasyon-ekle.php",
      body: {
        "Tarih": tarih,
        "BaslangicSaat": basSaati,
        "BitisSaat": bitSaati,
        "MusteriID": musteriID,
        "MasaID": masaID,
      });
  String mesaj = jsonDecode(response.body)["message"];
  print(mesaj);
  return mesaj;
}

Future<List<Widget>> rezervasyonGetir(String durumID, String userID) async {
  List<Widget> rezervasyonlar = [];
  http.Response response = await http.post(
      "http://www.burkayarac.com.tr/yervarmi/api/rezervasyon-listele.php",
      body: {
        "DurumID": durumID,
        "MusteriID": userID,
      });
  var mesaj = jsonDecode(response.body);
  if (mesaj["message"] == "Başarı ile rezervasyonlar listelendi.") {
    for (int i = 0; i < mesaj["RezervasyonData"].length; i++) {
      rezervasyonlar.add(rezDetayOlusturucu(
        resim: mesaj["RezervasyonData"][i]["FirmaLogo"].toString(),
        firmaAdi: mesaj["RezervasyonData"][i]["FirmaAd"].toString(),
        rezBas:
            mesaj["RezervasyonData"][i]["RezervasyonBaslangicTarih"].toString(),
        rezBit: mesaj["RezervasyonData"][i]["RezervasyonBitisTarih"].toString(),
        rezID: mesaj["RezervasyonData"][i]["RezervasyonID"].toString(),
        masaNo: mesaj["RezervasyonData"][i]["MasaNo"].toString(),
        rezDurum: durumID,
      ));
    }
    return rezervasyonlar;
  } else if (mesaj["message"] == "Rezervasyon Bulunamadı") {
    return null;
  }
}

Future<RezDetay> rezDetayGetir(String rezID) async {
  http.Response response = await http.post(
    "http://burkayarac.com.tr/yervarmi/api/rezervasyon-detay.php",
    body: {
      "RezervasyonID": rezID,
    },
  );
  final RezDetay rezDetaylari = RezFromJson(response.body);
  return rezDetaylari;
}

Future<String> rezYorumGonder(String rezID, String yorum, String puan) async {
  http.Response response = await http.post(
    "http://burkayarac.com.tr/yervarmi/api/yorum-ekle.php",
    body: {
      "RezervasyonID": rezID,
      "YorumIcerik": yorum,
      "YorumPuan": puan,
    },
  );
  String mesaj = jsonDecode(response.body)["message"];
  return mesaj;
}

Future<String> rezIptalEt(String rezID) async {
  http.Response response = await http.post(
    "http://burkayarac.com.tr/yervarmi/api/rezervasyon-iptal.php",
    body: {
      "RezervasyonID": rezID,
    },
  );
  String mesaj = jsonDecode(response.body)["message"];
  return mesaj;
}

class Firma {
  int firmaID;
  String firmaAdi;
  String firmaAdres;
  String firmaLogo;
  String firmaPuan;
  Firma({
    this.firmaID,
    this.firmaAdi,
    this.firmaLogo,
    this.firmaAdres,
    this.firmaPuan,
  });
}

class FirmaDetay extends Firma {
  String firmaMail;
  String firmaTelefon;
  FirmaDetay({
    this.firmaMail,
    this.firmaTelefon,
  });
}

class Kroki extends FirmaDetay {
  int krokiAdet;
  List<String> krokiResim = [];
  int masaAdet;
  int krokiBirimFiyat;
  int krokiBirimSaat;
  Kroki({
    this.krokiAdet,
    this.krokiResim,
    this.masaAdet,
    this.krokiBirimFiyat,
    this.krokiBirimSaat,
  });
}
