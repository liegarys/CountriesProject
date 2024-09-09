// ignore_for_file: prefer_final_fields, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ulkeler_proje/ulke.dart';
import 'package:ulkeler_proje/ulke_detay_sayfasi.dart';

class CommonList extends StatefulWidget {

  List<Ulke> _countries;
  List<String> _favoriteCountries;

  CommonList(this._countries, this._favoriteCountries);

  @override
  State<CommonList> createState() => _CommonListState();
}

class _CommonListState extends State<CommonList> {
  Widget? _lwUlkeler(BuildContext context, int index) {
    Ulke ulke = widget._countries[index];
    return Card(
        child: ListTile(
      title: Text(ulke.isim),
      subtitle: Text("Baskent ${ulke.baskent}"),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(ulke.bayrak),
      ),
      trailing: IconButton(
        onPressed: () {
          _favoriteCountriesClicked(ulke);
        },
        icon: Icon(
          widget._favoriteCountries.contains(ulke.ulkeKodu)
              ? Icons.favorite
              : Icons.favorite_border_sharp,
        ),
      ),
      onTap: () {
        _ulkeTiklandi(context, ulke);
      },
    ));
  }

    void _favoriteCountriesClicked(Ulke ulke) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (widget._favoriteCountries.contains(ulke.ulkeKodu)) {
      widget._favoriteCountries.remove(ulke.ulkeKodu);
    } else {
      widget._favoriteCountries.add(ulke.ulkeKodu);
    }

    sharedPreferences.setStringList("favorites", widget._favoriteCountries);

    setState(() {});
  }

 void _ulkeTiklandi(BuildContext context, Ulke ulke) {
    MaterialPageRoute _sayfaYolu = MaterialPageRoute(builder: (context) {
      return UlkeDetaySayfasi(ulke);
    });

    Navigator.push(context, _sayfaYolu);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget._countries.length, itemBuilder: _lwUlkeler);
  }
}
