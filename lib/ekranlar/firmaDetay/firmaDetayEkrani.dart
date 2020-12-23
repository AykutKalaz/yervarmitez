import 'package:flutter/material.dart';

import '../../constants.dart';

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
  void initState() {
    super.initState();
  }

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Text("FirmaID: ${widget.firmaID}"),
          ),
        ),
      ),
    );
  }
}
