import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yervarmitez/masaDetayJsonParse.dart';
import 'package:yervarmitez/servisler.dart';

import '../../constants.dart';
import '../../firmaDetayJsonParse.dart';

class FirmaDetayEkrani extends StatefulWidget {
  const FirmaDetayEkrani({
    Key key,
    @required this.firmaID,
    @required this.firmaAdi,
    @required this.firmaLogo,
    this.firmaDetaylari,
    this.masaDetaylari,
  }) : super(key: key);
  final int firmaID;
  final String firmaAdi;
  final String firmaLogo;
  final Future<FirmaHakkinda> firmaDetaylari;
  final Future<MasaHakkinda> masaDetaylari;

  @override
  _FirmaDetayEkraniState createState() => _FirmaDetayEkraniState();
}

class _FirmaDetayEkraniState extends State<FirmaDetayEkrani> {
  String masaNum = '1';
  DateTime selectedDate = DateTime.now();
  MasaHakkinda masaDetails;
  FirmaHakkinda firmaDetails;
  Future<void> _initForm;

  @override
  void initState() {
    super.initState();
    _initForm = _initAsyncForm();
  }

  Future<void> MasaDetayGetir(int firmaID, String masaNum, String tarih) async {
    try {
      final MasaHakkinda masaDetayi =
          await masaBilgiGetir(firmaID, masaNum, tarih);
      masaDetails = masaDetayi;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> FirmaDetayGetir(int firmaID) async {
    try {
      final FirmaHakkinda firmaDetayi = await firmaDetayGetir(widget.firmaID);
      firmaDetails = firmaDetayi;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _initAsyncForm() async {
    masaDetails = await widget.masaDetaylari;
    firmaDetails = await widget.firmaDetaylari;
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
      body: FutureBuilder(
        future: _initForm,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Size size = MediaQuery.of(context).size;
            String ilkKroki = firmaDetails.firmaDetay.krokiler[0].krokiBaslik;
            String birimFiyat, birimSaat;

            masaSayisiGetir(String value) {
              for (int i = 0;
                  i < firmaDetails.firmaDetay.krokiler.length;
                  i++) {
                if (value == firmaDetails.firmaDetay.krokiler[i].krokiBaslik) {
                  // String masaNum =
                  //     firmaDetails.firmaDetay.krokiler[i].masalar[0].masaNo;
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
                              "Bu krokide ki Birim saat: $birimSaat // Birim saatlik ücreti: $birimFiyat",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                              ),
                            ),
                      ExpansionTile(
                        title: Text("Seçilen masa ve tarih için boş saatler"),
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text("Saat aralığı: 00.00-01.00"),
                              Text("Durum: Boş"),
                              Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            print("${firmaDetails.firmaDetay.krokiler[0].krokiBaslik}");
            print("${masaDetails.saatData[0].saat}");
            return Center(child: const CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
