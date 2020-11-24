import 'package:flutter/material.dart';
import 'package:yervarmitez/components/roundedButton.dart';
import 'package:yervarmitez/constants.dart';
import 'package:yervarmitez/ekranlar/giris/girisEkrani.dart';
import 'package:yervarmitez/ekranlar/kayit/kayitEkrani.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: SafeArea(
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
              RoundedButton(
                text: "GİRİŞ",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return GirisEkrani();
                    }),
                  );
                },
              ),
              RoundedButton(
                text: "KAYIT",
                color: kPrimaryLightColor,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return KayitEkrani();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
