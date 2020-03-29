import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:virus/utils/Constants.dart';

class Disclaimer extends StatefulWidget {
  Disclaimer({Key key, this.title}) : super(key: key);
  final String title;

  @override
  MyState createState() => new MyState();
}

class MyState extends State<Disclaimer> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Disclaimer"),
      ),
      body: new Container(
        margin: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
        child: new ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                "Data",
                style: TextStyle(
                    color: PrimaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                "We do not own the data provided here in this application."
                " All the data provided in here is publicly available through Postman APIS provided by the Postman team "
                "in a bid to provide real time data on novel coronavirus (COVID-19) pandemic "
                "to health care professionals, researchers, and government experts. "
                "Our mission here, is to organize this data and to make your search for the latest updates on COVID-19 easier.",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                "Postman COVID-19 API Resource Center",
                style: TextStyle(
                    color: PrimaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                "The postman team have provided API Collections to help in the COVID-19 Fight, which can be found in the following link.",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: GestureDetector(
                onTap: () async {
                  await launch("https://covid-19-apis.postman.com/");
                },
                child: Text(
                  "https://covid-19-apis.postman.com/",
                  style: TextStyle(
                    color: PrimaryColor,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
