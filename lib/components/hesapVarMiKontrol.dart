import 'package:flutter/material.dart';

import '../constants.dart';

class HesapVarMiKontrolSatiri extends StatelessWidget {
  final bool giris;
  final Function press;

  const HesapVarMiKontrolSatiri({
    Key key,
    this.giris = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          giris ? "Hesabınız yok mu?" : "Hesabınız var mı?",
          style: TextStyle(
            color: kPrimaryLightColor,
          ),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            giris ? " Kayıt ol" : "Giris yap",
            style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
