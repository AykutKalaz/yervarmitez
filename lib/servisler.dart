import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'components/kategoriOlusturucu.dart';
import 'ilceler.dart';
import 'iller.dart';
import 'kategori.dart';

KayitBilgiGonder(String musteriMail, String musteriAdi, String musteriSoyadi,
    String musteriTelefon, String musteriSifre) async {
  http.Response response = await http
      .post('http://www.burkayarac.com.tr/yervarmi/api/kayit-ol.php', body: {
    "MusteriEmail": musteriMail,
    "MusteriAd": musteriAdi,
    "MusteriSoyad": musteriSoyadi,
    "MusteriSifre": musteriSifre,
    "MusteriTelefon": musteriTelefon
  });
  print(jsonDecode(response.body));
  print("Status: " + (response.statusCode).toString());
}

Future<String> GirisBilgiGonder(String musteriMail, String musteriSifre) async {
  http.Response response = await http
      .post('http://www.burkayarac.com.tr/yervarmi/api/giris-yap.php', body: {
    "MusteriEmail": musteriMail,
    "MusteriSifre": musteriSifre,
  });
  String test = jsonDecode(response.body)["status"];
  print(jsonDecode(response.body));
  print("Status: " + (response.statusCode).toString() + musteriMail);
  return test;
}

Future<List<Widget>> KategoriBilgiGetir() async {
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
      kategoriID: kategoriSinif[i].kategoriID,
      kategoriResmi: kategoriSinif[i].kategoriResmi,
      kategoriAdi: kategoriSinif[i].kategoriAdi,
    ));
    print(kategori.length);
  }
  print(kategori.length);
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
            firmaLogo: firmaListe[i]["FirmaLogo"]),
      );
    }
  }
  return firmalar;
}

class Firma {
  int firmaID;
  String firmaAdi;
  String firmaAdres;
  String firmaLogo;
  Firma({
    this.firmaID,
    this.firmaAdi,
    this.firmaLogo,
    this.firmaAdres,
  });
}
