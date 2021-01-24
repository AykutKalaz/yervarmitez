import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:yervarmitez/constants.dart';
import 'package:yervarmitez/ekranlar/firma/firmaDetayEkrani.dart';
import 'package:yervarmitez/servisler.dart';

import 'firmaDetayJsonParse.dart';
import 'ilceler.dart';
import 'iller.dart';
import 'masaDetayJsonParse.dart';

class FirmalarEkrani extends StatefulWidget {
  String kategoriAdi, userID;
  int kategoriID;
  Future<List<Iller>> ilListesi;

  FirmalarEkrani(
      {this.kategoriAdi, this.kategoriID, this.ilListesi, this.userID});
  @override
  _FirmalarEkraniState createState() => _FirmalarEkraniState();
}

class _FirmalarEkraniState extends State<FirmalarEkrani> {
  int il_no;
  List<Iller> ilListesi = <Iller>[];
  List<Ilceler> ilceListesi = <Ilceler>[];
  List<Firma> firmaListesi = <Firma>[];
  Iller seciliIl;
  Ilceler seciliIlce;
  List<Widget> firmalar = [];

  Future<FirmaHakkinda> firmaDetails;

  Future<void> _onIlSelected(Iller seciliIl) async {
    try {
      final cityList = await ilceGetir(seciliIl.ilID);
      setState(() {
        firmalar.clear();
        this.seciliIl = seciliIl;
        seciliIlce = null;
        ilceListesi.clear();
        ilceListesi.addAll(cityList);
      });
    } catch (e) {
      //TODO: handle error
      rethrow;
    }
  }

  Future<void> _onIlceSelected(Ilceler seciliIlce) async {
    try {
      final firmaList = await firmaGetir(seciliIlce.ilceID, widget.kategoriID);
      setState(() {
        firmaListesi.clear();
        if (seciliIlce.ilceID != null) {
          firmaListesi.addAll(firmaList);
          firmaOlustur(firmaListesi);
        } else {
          CircularProgressIndicator();
        }
      });
    } catch (e) {
      //TODO: handle error
      rethrow;
    }
  }

  firmaOlustur(List<Firma> firmalistesi) {
    firmalar.clear();
    if (firmalistesi.length == 0) {
      firmalar.add(
        Text(
          "Bu il ve ilçeye ait ${widget.kategoriAdi} bulunamadı",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      );
    }
    for (int i = 0; i < firmalistesi.length; i++) {
      firmalar.add(
        Card(
          color: Colors.orangeAccent,
          child: GestureDetector(
            onTap: () {
              firmaDetayGetir(firmalistesi[i].firmaID);
              print("tıklandı");
              final Future<FirmaHakkinda> firmaDetay =
                  firmaDetayGetir(firmalistesi[i].firmaID);
              final Future<MasaHakkinda> masaDetay = masaBilgiGetir(
                  firmalistesi[i].firmaID,
                  '1',
                  DateFormat.yMd('tr_TR').format(DateTime.now()).toString());
              firmaDetaylari(firmalistesi[i], firmaDetay, masaDetay);
            },
            child: ListTile(
              leading: Image.network(firmaListesi[i].firmaLogo),
              title: Text(firmaListesi[i].firmaAdi),
              subtitle: Text(firmaListesi[i].firmaAdres +
                  "\nFirma Puanı: ${firmalistesi[i].firmaPuan}"),
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildLoading() {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 10.0),
            Text('İller yükleniyor...'),
          ],
        ),
      );
    }

    Widget _buildError(dynamic error) {
      return Center(
        child: Text("Error occured: $error"),
      );
    }

    initializeDateFormatting('tr_TR', null);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          "${widget.kategoriAdi} Ekrani",
        ),
      ),
      body: FutureBuilder<void>(
        future: widget.ilListesi,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ilListesi = snapshot.data as List<Iller>;

            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    color: kPrimaryLightColor,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          DropdownButton<Iller>(
                            value: seciliIl,
                            onChanged: _onIlSelected,
                            dropdownColor: Colors.orangeAccent,
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            items: ilListesi
                                .map(
                                  (e) => DropdownMenuItem(
                                    child: Text(
                                      e.ilAdi,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    value: e,
                                  ),
                                )
                                .toList(),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          DropdownButton<Ilceler>(
                            value: seciliIlce,
                            onChanged: (Ilceler selectedIlce) {
                              setState(() {
                                this.seciliIlce = selectedIlce;
                                _onIlceSelected(seciliIlce);
                              });
                            },
                            dropdownColor: Colors.orangeAccent,
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            items: ilceListesi
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e.ilceAdi,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]..addAll(
                    List.generate(firmalar.length, (index) {
                      if (firmalar.length == 0) {
                        return CircularProgressIndicator();
                      } else {
                        return firmalar[index];
                      }
                    }),
                  ),
              ),
            );
          } else if (snapshot.hasError) {
            return _buildError(snapshot.error);
          } else {
            return _buildLoading();
          }
        },
      ),
    );
  }

  firmaDetaylari(Firma firma, Future<FirmaHakkinda> firmaDetay,
      Future<MasaHakkinda> masaDetay) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return FirmaDetayEkrani(
          userID: widget.userID,
          firmaID: firma.firmaID,
          firmaAdi: firma.firmaAdi,
          firmaLogo: firma.firmaLogo,
          masaDetaylari: masaDetay,
          firmaDetaylari: firmaDetay,
        );
      }),
    );
  }
}
