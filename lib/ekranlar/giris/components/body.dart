import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yervarmitez/components/roundedButton.dart';
import 'package:yervarmitez/components/roundedInputField.dart';
import 'package:yervarmitez/constants.dart';
import 'package:yervarmitez/ekranlar/kategoriler/body.dart';
import 'package:yervarmitez/ekranlar/kayit/kayitEkrani.dart';

import 'file:///E:/flutter/yervarmitez/lib/components/roundedParolaField.dart';

import '../../../components/hesapVarMiKontrol.dart';
import '../../../servisler.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String musteriMail = "", musteriSifre = "", ctrl;
  bool checkValue = false;
  SharedPreferences prefs;

  @override
  void initState() {
    pageRoute();
    super.initState();
  }

  @override
  void setState(fn) {
    pageRoute();
    super.setState(fn);
  }

  Future<void> pageRoute() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("userId") == true) {
      await GirisBilgiGonder(prefs.getString("email"), prefs.getString("sifre"))
          .then((value) {
        if (value.toString() == "success") {
          ctrl = "success";
          print(ctrl);
          basariliGiris();
        } else {
          ctrl = "false";
          prefs.setBool("userId", false);
          print(ctrl);
        }
      });
    }
  }

  basariliGiris() {
    Future.delayed(Duration(seconds: 2), () {
      if (ctrl == "success") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return KategoriEkrani();
          }),
        );
      }
    });
  }

  Future<void> deneme() async {
    prefs = await SharedPreferences.getInstance();
    await GirisBilgiGonder(musteriMail, musteriSifre).then((value) {
      if (value.toString() == "success") {
        prefs.setString("email", musteriMail);
        prefs.setString("sifre", musteriSifre);
        prefs.setBool("userId", true);
        ctrl = "success";
      } else {
        prefs.setBool("userId", false);
        ctrl = "false";
      }
    });
  }

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
              height: size.height * 0.30,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              "Giriş Ekranı",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                musteriMail = value;
              },
            ),
            RoundedParolaField(
              onChanged: (value) {
                musteriSifre = value;
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Checkbox(
                  value: checkValue,
                  onChanged: (bool value) {
                    setState(() {
                      checkValue = value;
                    });
                  },
                  activeColor: kPrimaryColor,
                ),
                Text("Bilgileri kaydetmek için tıklayın"),
              ],
            ),
            RoundedButton(
              text: "Giriş Yap",
              press: () {
                deneme();
                basariliGiris();
              },
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            HesapVarMiKontrolSatiri(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return KayitEkrani();
                  }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
