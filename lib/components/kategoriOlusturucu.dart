import 'package:flutter/material.dart';
import 'package:yervarmitez/servisler.dart';
import 'package:yervarmitez/testEkran.dart';

class KategoriOlustur extends StatelessWidget {
  const KategoriOlustur({
    Key key,
    @required this.kategoriResmi,
    @required this.kategoriAdi,
    @required this.kategoriID,
  }) : super(key: key);

  final String kategoriResmi;
  final String kategoriAdi;
  final int kategoriID;

  @override
  Widget build(BuildContext context) {
    Future<List<Iller>> ilListesi = ilGetir();
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        return Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return TestEkrani(
              kategoriAdi: kategoriAdi,
              kategoriID: kategoriID,
              ilListesi: ilListesi,
            );
          }),
        );
      },
      child: Container(
        width: size.width * 0.4,
        height: size.height * 0.2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.blue),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(kategoriResmi),
            Text(kategoriAdi),
            Text("$kategoriID"),
          ],
        ),
      ),
    );
  }
}
