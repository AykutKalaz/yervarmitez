import 'package:flutter/material.dart';
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
  String musteriID;
  bool paroleTest = true;

  basariliGiris() {
    if (ctrl == "success") {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Giriş Bilgilendirme',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    'Giriş başarılı. 2 saniye içinde yönlendiriliyorsunuz',
                    style: TextStyle(
                      fontSize: 23,
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              Container(
                child: RoundedButton(
                  text: "Tamam",
                  press: () {
                    Navigator.of(context).pop();
                  },
                  color: Colors.green,
                ),
              ),
            ],
          );
        },
      );
      Future.delayed(Duration(seconds: 2), () {
        {
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
    } else if (ctrl == "false") {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Giriş Bilgilendirme',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    'Email yada şifre yanlış. Lütfen tekrar deneyiniz.',
                    style: TextStyle(
                      fontSize: 23,
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              Container(
                child: RoundedButton(
                  text: "Tamam",
                  press: () {
                    Navigator.of(context).pop();
                  },
                  color: Colors.red,
                ),
              ),
            ],
          );
        },
      );
    } else if (ctrl == "null") {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Giriş Bilgilendirme',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    'Email yada şifre boş bırakılamaz.',
                    style: TextStyle(
                      fontSize: 23,
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              Container(
                child: RoundedButton(
                  text: "Tamam",
                  press: () {
                    Navigator.of(context).pop();
                  },
                  color: Colors.red,
                ),
              ),
            ],
          );
        },
      );
    } else {
      return CircularProgressIndicator();
    }
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
            RoundedButton(
              text: "Giriş Yap",
              press: () {
                if (musteriMail == "" || musteriSifre == "") {
                  ctrl = "null";
                  basariliGiris();
                } else {
                  deneme();
                  basariliGiris();
                }
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
