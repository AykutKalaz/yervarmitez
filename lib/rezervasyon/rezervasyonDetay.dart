import 'package:flutter/material.dart';

class RezervasyonDetay extends StatefulWidget {
  final String baslik;
  final Future<List<Widget>> rezervasyonlar;
  RezervasyonDetay({
    this.baslik,
    this.rezervasyonlar,
  });
  @override
  _RezervasyonDetayState createState() => _RezervasyonDetayState();
}

class _RezervasyonDetayState extends State<RezervasyonDetay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.baslik} Rezervasyonlar"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: widget.rezervasyonlar,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            return Center(
              child: Column(
                children: snapshot.data,
              ),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else if (snapshot.data == null) {
            return Center(
              child: Text(
                "Rezervasyon bulunamadı",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
