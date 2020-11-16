import 'package:flutter/material.dart';

class TestEkrani extends StatefulWidget {
  String kullaniciMail;
  TestEkrani({this.kullaniciMail});
  @override
  _TestEkraniState createState() => _TestEkraniState();
}

class _TestEkraniState extends State<TestEkrani> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Test Ekrani",
      )),
      body: Container(
        child: Column(
          children: <Widget>[
            Text("Gelen veri: " + widget.kullaniciMail),
          ],
        ),
      ),
    );
  }
}
