import 'package:flutter/material.dart';
import 'package:yervarmitez/components/roundedButton.dart';
import 'package:yervarmitez/rezDetayJsonParse.dart';
import 'package:yervarmitez/servisler.dart';

import 'constants.dart';

class RezervasyonIcerigi extends StatefulWidget {
  final String rezID;
  final String rezDurum;
  RezervasyonIcerigi({
    this.rezID,
    this.rezDurum,
  });

  @override
  _RezervasyonIcerigiState createState() => _RezervasyonIcerigiState();
}

class _RezervasyonIcerigiState extends State<RezervasyonIcerigi> {
  Future<RezDetay> rezDetay;
  String yorum, puan = "1", mesaj;
  @override
  void initState() {
    rezDetay = rezDetayGetir(widget.rezID);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Rezervasyon Detayları"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: rezDetay,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          final RezDetay rezDetaylari = snapshot.data;
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "Firma Adı: ${rezDetaylari.rezervasyonData.firmaAd} \nRezervasyon alınan alan: ${rezDetaylari.rezervasyonData.krokiBaslik}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Center(
                        child: Container(
                          width: size.width * 0.8,
                          height: size.height * 0.4,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              "${rezDetaylari.rezervasyonData.krokiResim}",
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Masa Numarası: ${rezDetaylari.rezervasyonData.masaNo}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                    Text(
                      " Rezervasyon başlangıç zamanı: ${rezDetaylari.rezervasyonData.rezervasyonBaslangicTarih} \n Rezervasyon başlangıç zamanı: ${rezDetaylari.rezervasyonData.rezervasyonBitisTarih} \n Rezervasyon Ücreti: ${rezDetaylari.rezervasyonData.rezervasyonToplamFiyat}",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                    (widget.rezDurum == "1")
                        ? RoundedButton(
                            text: "Rezervasyon İptal Et",
                            color: kPrimaryColor,
                            press: () async {
                              mesaj = await rezIptalEt(widget.rezID);
                              return showDialog<void>(
                                  context: context,
                                  barrierDismissible:
                                      false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Rezervasyon İptali'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            Text(mesaj),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text("Tamam"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          color: Colors.green,
                                        ),
                                      ],
                                    );
                                  });
                            },
                          )
                        : SizedBox(
                            height: size.height * 0.02,
                          ),
                    (widget.rezDurum == "2")
                        ? Column(
                            children: <Widget>[
                              Container(
                                width: size.width * 0.95,
                                child: TextField(
                                  onChanged: (value) {
                                    yorum = value;
                                    print(yorum);
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Yorum yazınız",
                                  ),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Firma için puan veriniz --> ",
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
                                      value: puan,
                                      dropdownColor: Colors.orangeAccent,
                                      onChanged: (String newValue) {
                                        setState(() {
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                          puan = newValue;
                                        });
                                      },
                                      items: <String>[
                                        "1",
                                        "2",
                                        "3",
                                        "4",
                                        "5",
                                      ].map<DropdownMenuItem<String>>((value) {
                                        puan = value;
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
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
                              RoundedButton(
                                text: "Yorum ve Puan Gönder",
                                press: () async {
                                  mesaj = await rezYorumGonder(
                                      widget.rezID, yorum, puan);
                                  return showDialog<void>(
                                      context: context,
                                      barrierDismissible:
                                          false, // user must tap button!
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Yorum Yapma'),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: <Widget>[
                                                Text(mesaj),
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text("Tamam"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              color: Colors.green,
                                            ),
                                          ],
                                        );
                                      });
                                },
                                color: kPrimaryColor,
                              ),
                            ],
                          )
                        : SizedBox(
                            height: size.height * 0.02,
                          ),
                    Text(
                      "Firma İletişim \nFirma Telefon: ${rezDetaylari.rezervasyonData.firmaTelefon} \nFirma Adres: ${rezDetaylari.rezervasyonData.firmaAdres}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error);
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
