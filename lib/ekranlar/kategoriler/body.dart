import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yervarmitez/constants.dart';
import 'package:yervarmitez/profil.dart';
import 'package:yervarmitez/servisler.dart';

import 'file:///E:/flutter/yervarmitez/lib/rezervasyon/rezervasyonlarim.dart';

class KategoriEkrani extends StatefulWidget {
  final String userID;
  KategoriEkrani({this.userID});
  @override
  _KategoriEkraniState createState() => _KategoriEkraniState();
}

class _KategoriEkraniState extends State<KategoriEkrani> {
  Future<List<Widget>> kategori;

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 0) {
      if (context.widget == KategoriEkrani()) {
        return null;
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return KategoriEkrani(
              userID: widget.userID,
            );
          }),
        );
      }
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return RezervasyonlarEkrani(
            userID: widget.userID,
          );
        }),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return ProfilEkrani(
            userID: widget.userID,
          );
        }),
      );
    }
  }

  @override
  void initState() {
    kategori = KategoriBilgiGetir(widget.userID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text("Kategori Ekrani"),
      ),
      body: FutureBuilder(
        future: kategori,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.count(
              primary: false,
              padding: EdgeInsets.all(20.0),
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: snapshot.data,
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kPrimaryColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 35,
            ),
            title: Text('Ana Sayfa'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.assignment,
              size: 35,
            ),
            title: Text('Rezervasyonlar',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 35,
            ),
            title: Text(
              'Profil',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber,
        onTap: _onItemTapped,
      ),
    );
  }
}
