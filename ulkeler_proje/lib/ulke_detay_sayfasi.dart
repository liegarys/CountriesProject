// ignore_for_file: prefer_final_fields, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ulkeler_proje/ulke.dart';

class UlkeDetaySayfasi extends StatelessWidget {
  Ulke _ulke;

  UlkeDetaySayfasi(this._ulke);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      title: Text(_ulke.isim),
      centerTitle: true,
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30,
          width: double.infinity,
        ),
        _buildFlag(context),
        SizedBox(
          height: 10,
        ),
        _buildCountryNameText(),
        SizedBox(
          height: 36,
        ),
        _buildAllDetails(),
      ],
    );
  }

  Widget _buildFlag(BuildContext context) {
    return Image.network(
      _ulke.bayrak,
      width: MediaQuery.sizeOf(context).width / 2,
      fit: BoxFit.fitWidth,
    );
  }

  Widget _buildCountryNameText() {
    return Text(
      _ulke.isim,
      style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildDetailRow(String title, String name) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            name,
            style: TextStyle(fontSize: 24),
          ),
        ),
      ],
    );
  }

  Widget _buildAllDetails() {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Column(
        children: [
          _buildDetailRow("Ülke ismi: ", _ulke.isim),
          _buildDetailRow("Başkent: ", _ulke.baskent),
          _buildDetailRow("Bölge: ", _ulke.bolge),
          _buildDetailRow("Nüfüs: ", _ulke.nufus.toString()),
          _buildDetailRow("Dİl: ", _ulke.dil),
        ],
      ),
    );
  }
}
