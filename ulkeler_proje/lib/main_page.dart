// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_final_fields

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ulkeler_proje/common_list.dart';
import 'package:ulkeler_proje/favorites.dart';
import 'package:ulkeler_proje/ulke.dart';
import 'package:http/http.dart' as http;
import 'package:ulkeler_proje/ulke_detay_sayfasi.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getFavoritesFromDevice().then((_) {
        _getCountriesFromInternet();
      });
    });
  }

  final String _apiUrl =
      ""; // Your API;

  List<Ulke> _tumUlkeler = [];
  List<String> _favoriteCountries = [];

  void _getCountriesFromInternet() async {
    Uri uri = Uri.parse(_apiUrl);
    http.Response response = await http.get(uri);

    List<dynamic> parsedResponse = jsonDecode(response.body);

    for (int i = 0; i < parsedResponse.length; i++) {
      Map<String, dynamic> ulkeMap = parsedResponse[i];
      Ulke ulke = Ulke.fromMap(ulkeMap);
      _tumUlkeler.add(ulke);
    }

    setState(() {});
  }

 



  Future<void> _getFavoritesFromDevice() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String>? favorites = sharedPreferences.getStringList("favorites");

    if (favorites != null) {
      for (String _codes in favorites) {
        _favoriteCountries.add(_codes);
      }
    }
  }

  void _goToFavoritePage(BuildContext context) {
    MaterialPageRoute route = MaterialPageRoute(builder: (context) {
      return Favorites(_tumUlkeler, _favoriteCountries);
    });

    Navigator.push(context, route);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context),
      body: _buildBody(),
    );
  }

  AppBar _buildAppbar(BuildContext context) {
    return AppBar(
      title: Text("Ülkeler"),
      actions: [
        IconButton(
            onPressed: () {
              _goToFavoritePage(context);
            },
            icon: Icon(
              Icons.favorite_border,
              color: Colors.purple,
            ))
      ],
    );
  }

  Widget _buildBody() {
    return _tumUlkeler.isEmpty
        ? Center(child: CircularProgressIndicator())
        : CommonList(_tumUlkeler, _favoriteCountries);
  }
}
