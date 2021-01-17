import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yervarmitez/components/roundedButton.dart';
import 'package:yervarmitez/masaDetayJsonParse.dart';
import 'package:yervarmitez/servisler.dart';

import '../../constants.dart';
import '../../firmaDetayJsonParse.dart';
import '../../masaDetayJsonParse.dart';

class FirmaDetayEkrani extends StatefulWidget {
  const FirmaDetayEkrani({
    Key key,
    @required this.firmaID,
    @required this.firmaAdi,
    @required this.firmaLogo,
    this.firmaDetaylari,
    this.masaDetaylari,
    this.userID,
  }) : super(key: key);
  final int firmaID;
  final String firmaAdi;
  final String firmaLogo;
  final Future<FirmaHakkinda> firmaDetaylari;
  final Future<MasaHakkinda> masaDetaylari;
  final String userID;

  @override
  _FirmaDetayEkraniState createState() => _FirmaDetayEkraniState();
}

class _FirmaDetayEkraniState extends State<FirmaDetayEkrani> {
  String masaNum = '1', ilkSaat = "00:00", sonSaat = "00:00";
  DateTime selectedDate = DateTime.now();
  Future<MasaHakkinda> masaHakkinda;
  int ilkDeger, sonDeger, mesaiBas, mesaiSon, rezFiyat = 0;
  List<Widget> yorumlar = [];
  List<String> saatler = [
    "00:00",
    "01:00",
    "02:00",
    "03:00",
    "04:00",
    "05:00",
    "06:00",
    "07:00",
    "08:00",
    "09:00",
    "10:00",
    "11:00",
    "12:00",
    "13:00",
    "14:00",
    "15:00",
    "16:00",
    "17:00",
    "18:00",
    "19:00",
    "20:00",
    "21:00",
    "22:00",
    "23:00",
  ];

  @override
  void initState() {
    super.initState();
    masaHakkinda = widget.masaDetaylari;
  }

  @override
  Widget build(BuildContext context) {
    _selectDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2025),
        helpText: 'Lütfen tarih seçiniz',
        cancelText: 'İptal et',
        confirmText: 'Tamam',
        fieldHintText: 'Ay/Gün/Yıl',
        fieldLabelText: 'Tarih formatı',
        builder: (context, child) {
          return Theme(
            data: ThemeData.dark(),
            child: child,
          );
        },
      );
      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked;
          masaHakkinda = masaBilgiGetir(widget.firmaID, masaNum,
              DateFormat.yMd('tr_TR').format(selectedDate).toString());
        });
      }
    }

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
      body: FutureBuilder<dynamic>(
        future: Future.wait([
          widget.firmaDetaylari,
          masaHakkinda,
        ]),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            Size size = MediaQuery.of(context).size;
            final FirmaHakkinda firmaDetaylari = snapshot.data[0];
            final MasaHakkinda masaDetaylari = snapshot.data[1];
            String ilkKroki = firmaDetaylari.firmaDetay.krokiler[0].krokiBaslik;
            String birimFiyat, birimSaat, firmaMesaiBas, firmaMesaiBit;
            String krokiResim =
                firmaDetaylari.firmaDetay.krokiler[0].krokiResim.toString();
            firmaMesaiBas = firmaDetaylari.firmaDetay.firmaMesaiBas;
            firmaMesaiBit = firmaDetaylari.firmaDetay.firmaMesaiBit;

            Widget ucretHesapla(int ilk, int son) {
              if (ilk != null && son != null) {
                mesaiBas = int.parse(firmaMesaiBas[0] + firmaMesaiBas[1]);
                mesaiSon = int.parse(firmaMesaiBit[0] + firmaMesaiBit[1]);
                if (mesaiBas != null || mesaiSon != null) {
                  if (ilk >= mesaiBas && son <= mesaiSon) {
                    if (ilk < son) {
                      rezFiyat = (son - ilk) * int.parse(birimFiyat);
                      return Text(
                        "Rezervasyon ücretiniz ---> ${(son - ilk) * int.parse(birimFiyat)}",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      );
                    } else {
                      return Text(
                        "Rezervasyon bitiş saati, başlangıç saatinden küçük olamaz.",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                        ),
                      );
                    }
                  } else {
                    return Text(
                      "Mesai Saatleri dışında zaman seçtiniz",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                      ),
                    );
                  }
                }
              } else {
                return Text(
                  "Rezervasyon ücretiniz ---> ?",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                );
              }
            }

            void yorumGetir() {
              yorumlar.clear();
              for (int i = 0;
                  i < firmaDetaylari.firmaDetay.yorumlar.length;
                  i++) {
                if (firmaDetaylari.firmaDetay.yorumlar.length < 1) {
                  return yorumlar.add(Text("Henüz bir yorum bulunmuyor"));
                } else {
                  return yorumlar.add(
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        width: size.width * 0.95,
                        color: Colors.orange,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                  "${firmaDetaylari.firmaDetay.yorumlar[i].musteriAd}"),
                              subtitle: Text(
                                  "${firmaDetaylari.firmaDetay.yorumlar[i].yorumIcerik}"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              }
            }

            yorumGetir();

            masaSayisiGetir(String value) {
              for (int i = 0;
                  i < firmaDetaylari.firmaDetay.krokiler.length;
                  i++) {
                if (value ==
                    firmaDetaylari.firmaDetay.krokiler[i].krokiBaslik) {
                  birimFiyat =
                      firmaDetaylari.firmaDetay.krokiler[i].krokiBirimFiyat;
                  birimSaat =
                      firmaDetaylari.firmaDetay.krokiler[i].krokiBirimSaat;

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
                          masaHakkinda = masaBilgiGetir(
                              int.parse(firmaDetaylari.firmaDetay.firmaId),
                              masaNum,
                              DateFormat.yMd('tr_TR')
                                  .format(selectedDate)
                                  .toString());
                        });
                      },
                      items: firmaDetaylari.firmaDetay.krokiler[i].masalar
                          .map((e) {
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
                              items:
                                  firmaDetaylari.firmaDetay.krokiler.map((e) {
                                krokiResim = e.krokiResim;
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
                      SizedBox(
                        height: size.height * 0.015,
                      ),
                      Image.network(
                        krokiResim,
                        height: size.height * 0.35,
                        width: size.width * 1,
                      ),
                      SizedBox(
                        height: size.height * 0.015,
                      ),
                      Text(
                        "Firma Puanı --> ${firmaDetaylari.firmaDetay.firmaPuan}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.015,
                      ),
                      Container(
                        width: size.width * 0.95,
                        color: Colors.deepOrange,
                        child: ExpansionTile(
                          backgroundColor: Colors.orangeAccent,
                          title: Text(
                            "Rezervasyon almak için tıklayın",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  "${(DateFormat.yMd('tr_TR').format(selectedDate)).toString()}",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                RaisedButton(
                                  onPressed: () => _selectDate(context),
                                  child: Text(
                                    'Tarih seçin',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  color: Colors.deepOrange,
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
                                ? Text('')
                                : Text(
                                    "Bu krokide ki Birim saat: $birimSaat // Birim saatlik ücreti: $birimFiyat \nBu firmanın mesai başlangıç saati: $firmaMesaiBas \n Mesai bitiş saati: $firmaMesaiBit",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: kPrimaryColor,
                                    ),
                                  ),
                            Container(
                              width: size.width * 0.9,
                              color: Colors.deepOrange,
                              child: ExpansionTile(
                                backgroundColor: Colors.orangeAccent,
                                title: Text(
                                  "Seçilen masa ve tarih için boş saatler",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                children: <Widget>[
                                  ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: masaDetaylari.saatData.length,
                                      itemBuilder: (context, i) {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              "Saat aralığı: ${masaDetaylari.saatData[i].saat}",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              " // Durum: ${masaDetaylari.saatData[i].durum}    ",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            (masaDetaylari.saatData[i].durum ==
                                                    "Dolu")
                                                ? Icon(
                                                    Icons.remove_circle,
                                                    color: Colors.red,
                                                  )
                                                : Icon(
                                                    Icons.check_circle,
                                                    color: Colors.green,
                                                  )
                                          ],
                                        );
                                      }),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  "Rezervasyon Başlangıç Saati ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: kPrimaryColor,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  padding: EdgeInsets.fromLTRB(15, 1, 15, 1),
                                  color: Colors.deepOrange,
                                  child: DropdownButton<String>(
                                    value: ilkSaat,
                                    dropdownColor: Colors.orangeAccent,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        ilkSaat = newValue;
                                        ilkDeger =
                                            int.parse(ilkSaat[0] + ilkSaat[1]);
                                      });
                                    },
                                    items: saatler.map((e) {
                                      krokiResim = e;
                                      return DropdownMenuItem<String>(
                                        value: e,
                                        child: Text(
                                          e,
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  "Rezervasyon Bitiş Saati         ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: kPrimaryColor,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  padding: EdgeInsets.fromLTRB(15, 1, 15, 1),
                                  color: Colors.deepOrange,
                                  child: DropdownButton<String>(
                                    value: sonSaat,
                                    dropdownColor: Colors.orangeAccent,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        sonSaat = newValue;
                                        sonDeger =
                                            int.parse(sonSaat[0] + sonSaat[1]);
                                      });
                                    },
                                    items: saatler.map((e) {
                                      krokiResim = e;
                                      return DropdownMenuItem<String>(
                                        value: e,
                                        child: Text(
                                          e,
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
                            ucretHesapla(ilkDeger, sonDeger),
                            RoundedButton(
                              text: "Rezervasyonu Tamamla",
                              press: () async {
                                if (rezFiyat == 0) {
                                  return showDialog<void>(
                                    context: context,
                                    barrierDismissible:
                                        false, // user must tap button!
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          'Rezervasyon',
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: <Widget>[
                                              Text(
                                                'Lütfen rezervasyon bilgilerini uygun şekilde doldurun',
                                                style: TextStyle(
                                                  fontSize: 23,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          Container(
                                            child: RoundedButton(
                                              text: "Tamam",
                                              press: () {
                                                Navigator.of(context).pop();
                                              },
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  String mesaj = await rezervasyonTamamla(
                                      masaNum,
                                      (DateFormat.yMd('tr_TR')
                                              .format(selectedDate))
                                          .toString(),
                                      ilkSaat,
                                      sonSaat,
                                      widget.userID);
                                  if (mesaj ==
                                      "Başarı ile rezervasyon yaptınız.") {
                                    return showDialog<void>(
                                      context: context,
                                      barrierDismissible:
                                          false, // user must tap button!
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            'Rezervasyon',
                                            style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: <Widget>[
                                                Text(
                                                  'Başarı ile rezervasyon yaptınız.',
                                                  style: TextStyle(
                                                    fontSize: 23,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            Container(
                                              child: RoundedButton(
                                                text: "Tamam",
                                                press: () {
                                                  Navigator.of(context).pop();
                                                },
                                                color: Colors.green,
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  } else if (mesaj ==
                                      "Daha önceden rezerve edilmiş bir masayı rezerve etmektesiniz.") {
                                    return showDialog<void>(
                                      context: context,
                                      barrierDismissible:
                                          false, // user must tap button!
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            'Rezervasyon',
                                            style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: <Widget>[
                                                Text(
                                                  'Daha önceden rezerve edilmiş bir masayı rezerve etmektesiniz.',
                                                  style: TextStyle(
                                                    fontSize: 23,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            Container(
                                              child: RoundedButton(
                                                text: "Tamam",
                                                press: () {
                                                  Navigator.of(context).pop();
                                                },
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  } else {
                                    return Text("Bir hata meydana geldi.");
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.015,
                      ),
                      Container(
                        width: size.width * 0.95,
                        color: Colors.deepOrange,
                        child: ExpansionTile(
                          backgroundColor: Colors.orangeAccent,
                          title: Text(
                            "Firma hakkında yorumlar için tıklayın",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          children: yorumlar,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            print(snapshot.error);

            return Text(snapshot.error.toString());
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
