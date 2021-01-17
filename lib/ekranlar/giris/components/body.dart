import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yervarmitez/components/roundedButton.dart';
import 'package:yervarmitez/components/roundedInputField.dart';
import 'package:yervarmitez/components/textFieldContainer.dart';
import 'package:yervarmitez/constants.dart';
import 'package:yervarmitez/ekranlar/kategoriler/body.dart';
import 'package:yervarmitez/ekranlar/kayit/kayitEkrani.dart';

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
  String musteriID;
  bool paroleTest = true;

  basariliGiris() {
    Future.delayed(Duration(seconds: 2), () {
      if (ctrl == "success") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return KategoriEkrani(
              userID: musteriID,
            );
          }),
        );
      }
    });
  }

  Future<void> deneme() async {
    await GirisBilgiGonder(musteriMail, musteriSifre).then((value) {
      if (value != null) {
        musteriID = value.toString();
        ctrl = "success";
      } else {
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
              hintText: "isim@ornek.com",
              onChanged: (value) {
                musteriMail = value;
              },
              textInputType: TextInputType.emailAddress,
            ),
            TextFieldContainer(
              child: TextField(
                onChanged: (value) {
                  musteriSifre = value;
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
