import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'components/kategoriOlusturucu.dart';

int il_no = 1;

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

Future<List<Ilceler>> ilceGetir(il_no) async {
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

class Iller {
  int ilID;
  String ilAdi;

  Iller({
    this.ilAdi,
    this.ilID,
  });
}

class Ilceler extends Iller {
  int ilceID;
  String ilceAdi;
  Ilceler({
    this.ilceAdi,
    this.ilceID,
  });
}

class Kategori {
  String kategoriAdi;
  String kategoriResmi;
  int kategoriID;

  Kategori({
    this.kategoriAdi,
    this.kategoriResmi,
    this.kategoriID,
  });
}
