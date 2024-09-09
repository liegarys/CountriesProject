import 'package:flutter/material.dart';
import 'package:ulkeler_proje/common_list.dart';
import 'package:ulkeler_proje/ulke.dart';

class Favorites extends StatefulWidget {
  final List<Ulke> _tumUlkeler;
  final List<String> _favoriteCountryCodes;

  Favorites(this._tumUlkeler, this._favoriteCountryCodes);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  List<Ulke> favoriteCountries = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    for(Ulke ulke in widget._tumUlkeler)
    {
      if(widget._favoriteCountryCodes.contains(ulke.ulkeKodu))
      {
        favoriteCountries.add(ulke);
      }
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody() ,
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      title: Text("Favorites"),
      centerTitle: true,
    );
  }

  Widget _buildBody()
  {
    return CommonList(favoriteCountries, widget._favoriteCountryCodes);
  }
}
