import 'package:flutter/material.dart';
import 'package:yervarmitez/servisler.dart';

import '../../constants.dart';
import '../../firmaDetayJsonParse.dart';

class FirmaDetayEkrani extends StatefulWidget {
  const FirmaDetayEkrani({
    Key key,
    @required this.firmaID,
    @required this.firmaAdi,
    @required this.firmaLogo,
  }) : super(key: key);
  final int firmaID;
  final String firmaAdi;
  final String firmaLogo;

  @override
  _FirmaDetayEkraniState createState() => _FirmaDetayEkraniState();
}

class _FirmaDetayEkraniState extends State<FirmaDetayEkrani> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Card(
          child: new Image.network("${widget.firmaLogo}"),
        ),
        backgroundColor: kPrimaryColor,
        title: Text(
          "${widget.firmaAdi} Ekrani",
        ),
      ),
      body: FutureBuilder(
          future: firmaDetayGetir(widget.firmaID),
          builder: (context, snapshot) {
            FirmaHakkinda firmaDetails = snapshot.data;
            Size size = MediaQuery.of(context).size;
            String ilkKroki = firmaDetails.firmaDetay.krokiler[0].krokiBaslik;
            String birimFiyat, birimSaat = null;

            masaSayisiGetir(String value) {
              for (int i = 0;
                  i < firmaDetails.firmaDetay.krokiler.length;
                  i++) {
                if (value == firmaDetails.firmaDetay.krokiler[i].krokiBaslik) {
                  String masaNum =
                      firmaDetails.firmaDetay.krokiler[i].masalar[0].masaNo;
                  birimFiyat =
                      firmaDetails.firmaDetay.krokiler[i].krokiBirimFiyat;
                  birimSaat =
                      firmaDetails.firmaDetay.krokiler[i].krokiBirimSaat;
                  return Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                    padding: EdgeInsets.fromLTRB(15, 1, 15, 1),
                    color: Colors.deepOrange,
                    child: DropdownButton(
                      value: masaNum,
                      dropdownColor: Colors.orangeAccent,
                      onChanged: (String newValue) {
                        this.setState(() {
                          masaNum = newValue;
                          print(masaNum);
                        });
                      },
                      items:
                          firmaDetails.firmaDetay.krokiler[i].masalar.map((e) {
                        return DropdownMenuItem(
                          value: e.masaNo,
                          child: Text(
                            e.masaNo,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }
              }
            }

            return SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Image.network(
                        firmaDetails.firmaDetay.krokiler[0].krokiResim
                            .toString(),
                        height: size.height * 0.35,
                        width: size.width * 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Kroki Seçiniz -->",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            padding: EdgeInsets.fromLTRB(15, 1, 15, 1),
                            color: Colors.deepOrange,
                            child: DropdownButton<String>(
                              value: ilkKroki,
                              dropdownColor: Colors.orangeAccent,
                              onChanged: (String newValue) {
                                setState(() {
                                  ilkKroki = newValue;
                                  masaSayisiGetir(ilkKroki);
                                });
                              },
                              items: firmaDetails.firmaDetay.krokiler.map((e) {
                                return DropdownMenuItem<String>(
                                  value: e.krokiBaslik,
                                  child: Text(
                                    e.krokiBaslik,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Masa Seçiniz -->",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor,
                            ),
                          ),
                          masaSayisiGetir(ilkKroki),
                        ],
                      ),
                      (birimSaat == null)
                          ? Text("")
                          : Text(
                              "Bu krokide ki Birim saat: ${birimSaat} // Birim saatlik ücreti: ${birimFiyat}",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
