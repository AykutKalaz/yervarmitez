import 'package:flutter/material.dart';

class KategoriOlustur extends StatelessWidget {
  const KategoriOlustur({
    Key key,
    @required this.kategoriResmi,
    @required this.kategoriAdi,
  }) : super(key: key);

  final String kategoriResmi;
  final String kategoriAdi;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
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
          ],
        ),
      ),
    );
  }
}
