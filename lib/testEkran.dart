import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  int il_no;
  List<Iller> ilListesi = <Iller>[];
  List<Ilceler> ilceListesi = <Ilceler>[];
  Iller seciliIl;
  Ilceler seciliIlce;
  Future<void> _initForm;

  @override
  void initState() {
    super.initState();
    _initForm = _initStateAsync();
  }

  Future<void> _initStateAsync() async {
    ilListesi.clear();
    ilListesi.addAll(await widget.ilListesi);
  }

  void _onIlSelected(Iller seciliIl) async {
    try {
      final cityList = await ilceGetir(seciliIl.ilID);
      setState(() {
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
              child: Container(
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
            );
        },
      ),
    );
  }
}
