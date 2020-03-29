import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'package:flutter/services.dart';
import 'package:virus/utils/Constants.dart';
import 'package:virus/utils/Theme.dart';
import 'package:virus/views/Home.dart';


import 'api/ApiInterfaces.dart';
import 'model/Country.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: PrimaryDarkColor, //or set color with: Color(0xFF0000FF)
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid-19',
      theme: CustomThemeData,
      home: Home(title: 'Covid-19'),
    );
  }
}
