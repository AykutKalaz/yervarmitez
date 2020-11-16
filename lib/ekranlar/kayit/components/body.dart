import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yervarmitez/components/hesapVarMiKontrol.dart';
import 'package:yervarmitez/components/roundedButton.dart';
import 'package:yervarmitez/components/roundedInputField.dart';
import 'package:yervarmitez/ekranlar/giris/girisEkrani.dart';

import 'file:///E:/flutter/yervarmitez/lib/components/roundedParolaField.dart';

import '../../../servisler.dart';

class Body extends StatelessWidget {
  String musteriMail = "",
      musteriAdi = "",
      musteriSoyadi = "",
      musteriTelefon = "",
      musteriSifre = "";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/logo2.png",
              height: size.height * 0.23,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            RoundedInputField(
              hintText: "Email",
              onChanged: (value) {
                musteriMail = value;
              },
            ),
            RoundedParolaField(
              onChanged: (value) {
                musteriSifre = value;
              },
            ),
            RoundedInputField(
              hintText: "İsim",
              icon: Icons.perm_identity,
              onChanged: (value) {
                musteriAdi = value;
              },
            ),
            RoundedInputField(
              hintText: "Soyisim",
              icon: Icons.perm_identity,
              onChanged: (value) {
                musteriSoyadi = value;
              },
            ),
            RoundedInputField(
              hintText: "Telefon",
              icon: Icons.phone,
              onChanged: (value) {
                musteriTelefon = value;
              },
            ),
            RoundedButton(
              text: "Kayıt Ol",
              press: () {
                KayitBilgiGonder(musteriMail, musteriAdi, musteriSoyadi,
                    musteriTelefon, musteriSifre);
              },
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            HesapVarMiKontrolSatiri(
              giris: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return GirisEkrani();
                  }),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
