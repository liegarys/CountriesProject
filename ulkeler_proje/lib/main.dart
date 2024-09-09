// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ulkeler_proje/main_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MainPage(),);
  }
}