import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'components/kategoriOlusturucu.dart';

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

Future<int> GirisBilgiGonder(String musteriMail, String musteriSifre) async {
  http.Response response = await http
      .post('http://www.burkayarac.com.tr/yervarmi/api/giris-yap.php', body: {
    "MusteriEmail": musteriMail,
    "MusteriSifre": musteriSifre,
  });
  print(jsonDecode(response.body));
  print("Status: " + (response.statusCode).toString() + musteriMail);
  return response.statusCode;
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
        kategoriAdi: kategoriListe[i]["KategoriAdi"].toString(),
        kategoriResmi: kategoriListe[i]["KategoriResim"].toString()));
  }
  print(kategoriSinif[0].kategoriResmi);
  for (int i = 0; i < kategoriSinif.length; i++) {
    kategori.add(KategoriOlustur(
      kategoriResmi: kategoriSinif[i].kategoriResmi,
      kategoriAdi: kategoriSinif[0].kategoriAdi,
    ));
    print(kategori.length);
  }
  print(kategori.length);
  return kategori;
}

class Kategori {
  String kategoriAdi;
  String kategoriResmi;

  Kategori({
    this.kategoriAdi,
    this.kategoriResmi,
  });
}
