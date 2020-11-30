import 'package:flutter/material.dart';
import 'package:yervarmitez/constants.dart';
import 'package:yervarmitez/firmalarEkrani.dart';
import 'package:yervarmitez/servisler.dart';

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
            return FirmalarEkrani(
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
            borderRadius: BorderRadius.circular(15), color: kPrimaryColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(
              kategoriResmi,
              height: size.height * 0.05,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              kategoriAdi,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: size.height * 0.025),
            ),
          ],
        ),
      ),
    );
  }
}
