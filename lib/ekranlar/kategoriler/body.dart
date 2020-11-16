import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yervarmitez/servisler.dart';

class KategoriEkrani extends StatefulWidget {
  @override
  _KategoriEkraniState createState() => _KategoriEkraniState();
}

class _KategoriEkraniState extends State<KategoriEkrani> {
  Future<List<Widget>> kategori = KategoriBilgiGetir();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Test Ekrani"),
          ),
          body: GridView.count(
            primary: false,
            padding: EdgeInsets.all(20.0),
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: <Widget>[
              Column(),
            ],
          )),
    );
  }
}
