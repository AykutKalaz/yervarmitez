import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yervarmitez/rezervasyonDetay.dart';
import 'package:yervarmitez/servisler.dart';

class RezervasyonlarEkrani extends StatefulWidget {
  final String userID;
  RezervasyonlarEkrani({
    this.userID,
  });

  @override
  _RezervasyonlarEkraniState createState() => _RezervasyonlarEkraniState();
}

class _RezervasyonlarEkraniState extends State<RezervasyonlarEkrani> {
  Future<List<Widget>> rezervasyonlar;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Rezervasyon Sayfası",
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: size.width * 0.9,
              child: Card(
                color: Colors.orangeAccent,
                child: GestureDetector(
                  onTap: () async {
                    rezervasyonlar = rezervasyonGetir("2", widget.userID);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return RezervasyonDetay(
                        baslik: "Tamamlanan",
                        rezervasyonlar: rezervasyonlar,
                      );
                    }));
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.event_available,
                      color: Colors.green,
                      size: 30.0,
                    ),
                    title: Text(
                      "Tamamlanan rezervasyonlar",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.brown),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: size.width * 0.9,
              child: Card(
                color: Colors.orangeAccent,
                child: GestureDetector(
                  onTap: () {
                    rezervasyonlar = rezervasyonGetir("1", widget.userID);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return RezervasyonDetay(
                        baslik: "Devam Eden",
                        rezervasyonlar: rezervasyonlar,
                      );
                    }));
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.event_note,
                      color: Colors.yellow,
                      size: 30.0,
                    ),
                    title: Text(
                      "Devam eden rezervasyonlar",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.brown),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: size.width * 0.9,
              child: Card(
                color: Colors.orangeAccent,
                child: GestureDetector(
                  onTap: () {
                    rezervasyonlar = rezervasyonGetir("3", widget.userID);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return RezervasyonDetay(
                        baslik: "İptal Edilen",
                        rezervasyonlar: rezervasyonlar,
                      );
                    }));
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.event_busy,
                      color: Colors.red,
                      size: 30.0,
                    ),
                    title: Text(
                      "İptal edilen rezervasyonlar",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.brown),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
