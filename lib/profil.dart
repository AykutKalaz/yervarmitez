import 'package:flutter/material.dart';
import 'package:yervarmitez/components/roundedButton.dart';
import 'package:yervarmitez/components/roundedInputField.dart';
import 'package:yervarmitez/profilDetayJsonParse.dart';
import 'package:yervarmitez/servisler.dart';

class ProfilEkrani extends StatefulWidget {
  final String userID;
  ProfilEkrani({
    @required this.userID,
  });
  @override
  _ProfilEkraniState createState() => _ProfilEkraniState();
}

class _ProfilEkraniState extends State<ProfilEkrani> {
  Future<ProfilDetay> profilBilgi;
  String mesaj;
  String musteriAdi = "",
      musteriSoyadi = "",
      musteriMail = "",
      musteriSifre = "",
      musteriTelefon = "";
  final Kontrolcu = TextEditingController();

  @override
  void initState() {
    Kontrolcu.addListener(() {
      setState(() {});
    });
    profilBilgiGetir();
    super.initState();
  }

  profilBilgiGetir() {
    profilBilgi = profilDetayGetir(widget.userID);
  }

  profiliGuncelle() async {
    mesaj = await profilBilgiGuncelle(musteriMail, musteriAdi, musteriSoyadi,
        musteriTelefon, musteriSifre, widget.userID);
    print(mesaj);
    if (mesaj == "Başarı ile profil güncellendi.") {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Güncelleme',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    'Profiliniz başarıyla güncellendi',
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
      return AlertDialog(
        title: Text('Güncelleme'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Bir hata meydana geldi.'),
            ],
          ),
        ),
        actions: <Widget>[
          RoundedButton(
            text: "Tamam",
            press: () {
              Navigator.of(context).pop();
            },
            color: Colors.red,
          ),
        ],
      );
    }
  }

  bool paroleTest = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Profil Sayfası",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder(
        future: profilBilgi,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            final ProfilDetay profilDetaylari = snapshot.data;
            musteriAdi = profilDetaylari.userInfo[0].musteriAd;
            musteriSoyadi = profilDetaylari.userInfo[0].musteriSoyad;
            musteriSifre = profilDetaylari.userInfo[0].musteriSifre;
            musteriMail = profilDetaylari.userInfo[0].musteriEmail;
            musteriTelefon = profilDetaylari.userInfo[0].musteriTelefon;
            return SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          "https://burkayarac.com.tr/yervarmi/resimler/default-avatar.png",
                          height: 100,
                          width: 100,
                        ),
                      ),
                      RoundedInputField(
                        icon: Icons.perm_identity,
                        hintText: "İsminiz",
                        kontrol: profilDetaylari.userInfo[0].musteriAd,
                        onChanged: (value) {
                          musteriAdi = value.toString();
                        },
                      ),
                      RoundedInputField(
                        icon: Icons.perm_identity,
                        hintText: "Soyadınız",
                        kontrol: profilDetaylari.userInfo[0].musteriSoyad,
                        onChanged: (value) {
                          musteriSoyadi = value.toString();
                        },
                      ),
                      RoundedInputField(
                        icon: Icons.lock,
                        hintText: "Şifreniz",
                        kontrol: profilDetaylari.userInfo[0].musteriSifre,
                        onChanged: (value) {
                          musteriSifre = value.toString();
                          print(musteriSifre);
                        },
                      ),
                      RoundedInputField(
                        hintText: "Email adresiniz",
                        kontrol: profilDetaylari.userInfo[0].musteriEmail,
                        onChanged: (value) {
                          musteriMail = value.toString();
                        },
                      ),
                      RoundedInputField(
                        icon: Icons.phone,
                        hintText: "Telefon numaranız",
                        kontrol: profilDetaylari.userInfo[0].musteriTelefon,
                        onChanged: (value) {
                          musteriTelefon = value.toString();
                        },
                      ),
                      RoundedButton(
                        text: "Güncelle",
                        press: () {
                          profiliGuncelle();
                          profilBilgiGetir();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Text(snapshot.error.toString());
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
