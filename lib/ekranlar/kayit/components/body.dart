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
      musteriSifre = "",
      mesaj;
  bool paroleTest = false, kontrol = true, kontrol2 = true;

  musteriMailKontrol(String musteriMailCheck) {
    if (musteriMailCheck.contains('@') == true &&
        musteriMailCheck.contains(".com") == true) {
      kontrol = true;
      return kontrol;
    } else {
      kontrol = false;
      return kontrol;
    }
  }

  musteriSifreKontrol(String musteriSifreCheck) {
    if (musteriSifreCheck.length > 7 && musteriSifreCheck.length < 17) {
      kontrol2 = true;
      return 2;
    } else {
      kontrol2 = false;
      return kontrol2;
    }
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
                  musteriMailKontrol(musteriMail);
                },
                textInputType: TextInputType.emailAddress),
            TextFieldContainer(
              child: TextField(
                onChanged: (value) {
                  musteriSifre = value;
                  musteriSifreKontrol(musteriSifre);
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
              press: () async {
                if (musteriSifre == "" ||
                    musteriTelefon == "" ||
                    musteriMail == "" ||
                    musteriSoyadi == "" ||
                    musteriAdi == "") {
                  return showDialog<void>(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          'Kayıt Bilgilendirme',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text(
                                "Kayıt bilgilerinden herhangi biri boş olamaz",
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
                  if (kontrol == true) {
                    if (kontrol2 == true) {
                      mesaj = await KayitBilgiGonder(musteriMail, musteriAdi,
                          musteriSoyadi, musteriTelefon, musteriSifre);
                      return showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'Kayıt Bilgilendirme',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text(
                                    mesaj,
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
                    } else {
                      return showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'Kayıt Bilgilendirme',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text(
                                    "Şifreniz 8-16 karakter arasında olmalıdır.",
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
                    }
                  } else {
                    return showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'Kayıt Bilgilendirme',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text(
                                  "Lütfen geçerli bir mail adresi giriniz",
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
                  }
                }
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
