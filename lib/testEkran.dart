import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yervarmitez/constants.dart';
import 'package:yervarmitez/servisler.dart';

class TestEkrani extends StatefulWidget {
  String kategoriAdi;
  int kategoriID;
  Future<List<Iller>> ilListesi;

  TestEkrani({this.kategoriAdi, this.kategoriID, this.ilListesi});
  @override
  _TestEkraniState createState() => _TestEkraniState();
}

class _TestEkraniState extends State<TestEkrani> {
  Future<List<Ilceler>> ilceListesi;
  SharedPreferences prefs;
  int il_no;
  Iller il;
  Ilceler ilce = null;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider<List<Iller>>(
          create: (context) => widget.ilListesi,
        ),
        FutureProvider<List<Ilceler>>(
          create: (context) => ilceListesi,
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text(
            "${widget.kategoriAdi} Ekrani",
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: kPrimaryLightColor,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Consumer<List<Iller>>(builder: (context, deneme, child) {
                    return DropdownButton(
                      value: il,
                      dropdownColor: Colors.orangeAccent,
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (Iller newValue) {
                        setState(() {
                          il = newValue;
                          il_no = il.ilID;
                        });
                      },
                      items: deneme
                          .map((e) => DropdownMenuItem<Iller>(
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      e.ilAdi,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                value: e,
                              ))
                          .toList(),
                    );
                  }),
                  SizedBox(
                    width: 10,
                  ),
                  FutureBuilder<List<Ilceler>>(
                    future: ilceGetir(il_no),
                    builder: (context, snapshot) {
                      return il_no == null
                          ? CircularProgressIndicator()
                          : DropdownButton(
                              value: ilce,
                              dropdownColor: Colors.orangeAccent,
                              underline: Container(
                                height: 2,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (Ilceler newValue) {
                                setState(() {
                                  print(newValue.ilceAdi);
                                  ilce = newValue;
                                });
                              },
                              items: snapshot.data
                                  .map(
                                    (Ilceler e) => DropdownMenuItem<Ilceler>(
                                      value: e,
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            e.ilceAdi,
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> deneme() async {
    prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
