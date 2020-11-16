import 'package:flutter/material.dart';
import 'package:yervarmitez/constants.dart';

import 'ekranlar/hosgeldin/hosgeldinEkrani.dart';

void main() {
  runApp(YerVarMi());
}

class YerVarMi extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yer Var Mı? ',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Color(0xFFFFD180),
      ),
      home: HosgeldinEkrani(),
    );
  }
}
