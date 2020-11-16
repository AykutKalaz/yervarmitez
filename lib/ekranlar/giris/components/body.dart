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
  String musteriMail = "", musteriSifre = "";
  bool checkValue = false;

  Future<void> AutoLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userId = prefs.getString('username');
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
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return KategoriEkrani();
                }));
                Future<int> ctrl = GirisBilgiGonder(musteriMail, musteriSifre);
                //KategoriBilgiGetir();
                /*if (ctrl == 200) {
                var autoValidate = true;
                SharedPrefs.mailKaydet(musteriMail);
                SharedPrefs.sifreKaydet(musteriSifre);
                SharedPrefs.giris();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return TestEkrani(
                      kullaniciMail: musteriMail,
                    );
                  }),
                );
                }*/
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
