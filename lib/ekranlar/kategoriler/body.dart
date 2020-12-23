import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yervarmitez/constants.dart';
import 'package:yervarmitez/profil.dart';
import 'package:yervarmitez/servisler.dart';

class KategoriEkrani extends StatefulWidget {
  @override
  _KategoriEkraniState createState() => _KategoriEkraniState();
}

class _KategoriEkraniState extends State<KategoriEkrani> {
  Future<List<Widget>> kategori = KategoriBilgiGetir();

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 0) {
      if (context.widget == KategoriEkrani()) {
        return null;
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return KategoriEkrani();
          }),
        );
      }
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return ProfilEkrani();
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MultiProvider(
      providers: [
        FutureProvider<List<Widget>>(
          create: (context) => kategori,
          initialData: <Widget>[CircularProgressIndicator()],
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text("Kategori Ekrani"),
        ),
        body: Consumer<List<Widget>>(
          builder: (context, deneme, child) {
            return GridView.count(
              primary: false,
              padding: EdgeInsets.all(20.0),
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: deneme,
            );
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
      ),
    );
  }
}
