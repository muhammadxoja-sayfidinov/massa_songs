import 'package:flutter/material.dart';
import 'package:music_app/pages/frist.dart';
import 'package:music_app/pages/home.page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/home',
    routes: {

      '/home' : (context) => frist_page(),

    },
  ));
}


