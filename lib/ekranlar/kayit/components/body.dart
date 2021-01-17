import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yervarmitez/components/hesapVarMiKontrol.dart';
import 'package:yervarmitez/components/roundedButton.dart';
import 'package:yervarmitez/components/roundedInputField.dart';
import 'package:yervarmitez/components/textFieldContainer.dart';
import 'package:yervarmitez/ekranlar/giris/girisEkrani.dart';

import '../../../constants.dart';
import '../../../servisler.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String musteriMail = "",
      musteriAdi = "",
      musteriSoyadi = "",
      musteriTelefon = "",
      musteriSifre = "";
  bool paroleTest = false;

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
            Text(
              "Kayıt Ekranı",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            RoundedInputField(
                hintText: "isim@ornek.com",
                onChanged: (value) {
                  musteriMail = value;
                },
                textInputType: TextInputType.emailAddress),
            TextFieldContainer(
              child: TextField(
                onChanged: (value) {
                  musteriSifre = value;
                  print(musteriSifre);
                  print(value);
                },
                style: TextStyle(fontSize: 19),
                obscureText: paroleTest,
                decoration: InputDecoration(
                  hintText: "Parola",
                  icon: Icon(
                    Icons.lock,
                    color: kPrimaryColor,
                  ),
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    color: kPrimaryColor,
                    icon: paroleTest
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                    onPressed: () => setState(() => paroleTest = !paroleTest),
                  ),
                ),
              ),
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
              height: size.height * 0.005,
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
