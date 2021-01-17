import 'package:flutter/material.dart';

import 'file:///E:/flutter/yervarmitez/lib/rezervasyon/rezervasyonIcerigi.dart';

class rezDetayOlusturucu extends StatelessWidget {
  final String resim;
  final String firmaAdi;
  final String rezBas;
  final String rezBit;
  final String rezID;
  final String masaNo;
  final String rezDurum;
  rezDetayOlusturucu({
    this.resim,
    this.firmaAdi = "",
    this.rezBas = "",
    this.rezBit = "",
    this.rezID,
    this.masaNo,
    this.rezDurum,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return RezervasyonIcerigi(
            rezID: rezID,
            rezDurum: rezDurum,
          );
        }));
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: Container(
          color: Colors.orangeAccent,
          child: ListTile(
            leading: Image.network(resim),
            title: Text(
              firmaAdi,
            ),
            subtitle: Text(
              "$rezBas -- $rezBit \n Masa No: $masaNo",
            ),
          ),
        ),
      ),
    );
  }
}
