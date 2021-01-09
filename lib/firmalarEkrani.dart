import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:yervarmitez/constants.dart';
import 'package:yervarmitez/ekranlar/firmaDetay/firmaDetayEkrani.dart';
import 'package:yervarmitez/profil.dart';
import 'package:yervarmitez/servisler.dart';

import 'ekranlar/kategoriler/body.dart';
import 'firmaDetayJsonParse.dart';
import 'ilceler.dart';
import 'iller.dart';
import 'masaDetayJsonParse.dart';

class FirmalarEkrani extends StatefulWidget {
  String kategoriAdi;
  int kategoriID;
  Future<List<Iller>> ilListesi;

  FirmalarEkrani({this.kategoriAdi, this.kategoriID, this.ilListesi});
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
  Future<void> _initForm;

  int _selectedIndex = 0;
  Future<FirmaHakkinda> firmaDetails;

  void _onItemTapped(int index) {
    if (index == 0) {
      if (context.widget == KategoriEkrani()) {
        return null;
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return KategoriEkrani();
          }),
        );
      }
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return ProfilEkrani();
        }),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _initForm = _initStateAsync();
  }

  Future<void> _initStateAsync() async {
    ilListesi.clear();
    ilListesi.addAll(await widget.ilListesi);
  }

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
    for (int i = 0; i < firmalistesi.length; i++) {
      firmalar.add(
        Card(
          color: Colors.orangeAccent,
          child: GestureDetector(
            onTap: () {
              firmaDetayGetir(firmalistesi[i].firmaID);
              print("tıklandı");
              Future<FirmaHakkinda> firmaDetay =
                  firmaDetayGetir(firmalistesi[i].firmaID);
              Future<MasaHakkinda> masaDetay = masaBilgiGetir(
                  firmalistesi[i].firmaID,
                  '1',
                  DateFormat.yMd('tr_TR').format(DateTime.now()).toString());
              firmaDetaylari(firmalistesi[i], firmaDetay, masaDetay);
            },
            child: ListTile(
              leading: Image.network(firmaListesi[i].firmaLogo),
              title: Text(firmaListesi[i].firmaAdi),
              subtitle: Text(firmaListesi[i].firmaAdres),
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
        future: _initForm,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return _buildLoading();
          else if (snapshot.hasError)
            return _buildError(snapshot.error);
          else
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
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kPrimaryColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 35,
            ),
            title: Text('Ana Sayfa'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 35,
            ),
            title: Text(
              'Profil',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber,
        onTap: _onItemTapped,
      ),
    );
  }

  firmaDetaylari(Firma firma, Future<FirmaHakkinda> firmaDetay,
      Future<MasaHakkinda> masaDetay) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return FirmaDetayEkrani(
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
