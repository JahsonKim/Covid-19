import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:virus/api/ApiInterfaces.dart';
import 'package:virus/model/Country.dart';
import 'package:virus/utils/Constants.dart';
import 'package:virus/utils/Utils.dart';

class CountryDetails extends StatefulWidget {
  CountryDetails(this.country, {Key key, this.title}) : super(key: key);
  final String country;
  final String title;

  @override
  CountryState createState() => CountryState();
}

class CountryState extends State<CountryDetails> {
  Country country;
  RestDatasource api = new RestDatasource();
  bool isLoading = false;
  String errorMessage;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getCasesByCountry();
  }

  getCasesByCountry() async {
    setState(() {
      isLoading = true;
    });
    await api.getCaseByCountry(widget.country).then((String response) {
      setState(() {
        isLoading = false;
      });
      print("country " + response);
      final res = json.decode(response);

      if (res != null) {
        setState(() {
          country = Country.map(res);
        });
      } else {
        //handle errors
      }
      errorMessage = null;
      //TODO process response here
    }).catchError((exception) {
      //handle errors
      errorMessage = "Error loading country data";
      print("exception " + exception.toString());
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget errorWidget() {
      return Container(
        padding: EdgeInsets.only(left: 10, top: 10),
        child: Row(
          children: <Widget>[
            Text(
              errorMessage,
              style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.normal),
            )
          ],
        ),
      );
    }

    Widget progressBar() {
      return Container(
        padding: EdgeInsets.only(left: 10, top: 10),
        child: Row(
          children: <Widget>[
            SizedBox(
              height: 15,
              width: 15,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5),
            ),
            Text(
              "loading ...",
              style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.normal),
            )
          ],
        ),
      );
    }

    List<Widget> dataWidget() {
      return [
        Padding(
          padding: EdgeInsets.only(top: 25, bottom: 8),
          child: Align(
            alignment: FractionalOffset.center,
            child: Text(
              Utils.formatNumber(country.cases),
              style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Align(
            alignment: FractionalOffset.center,
            child: Text(
              "Total Cases",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(5),
          child: Divider(
            color: Colors.black26,
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Deaths".toUpperCase(),
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 15, bottom: 8),
                            child: Align(
                              alignment: FractionalOffset.center,
                              child: Text(
                                Utils.formatNumber(country.deaths),
                                style: TextStyle(
                                    color: PrimaryColor,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Align(
                            alignment: FractionalOffset.center,
                            child: Text(
                              "Total Deaths",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 15, bottom: 8),
                            child: Align(
                              alignment: FractionalOffset.center,
                              child: Text(
                                "+" + Utils.formatNumber(country.todayDeaths),
                                style: TextStyle(
                                    color: PrimaryColor,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Align(
                            alignment: FractionalOffset.center,
                            child: Text(
                              "Today\'s Deaths",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(5),
          child: Divider(
            color: Colors.black26,
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Cases".toUpperCase(),
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 15, bottom: 8),
                            child: Align(
                              alignment: FractionalOffset.center,
                              child: Text(
                                Utils.formatNumber(country.todayCases),
                                style: TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Align(
                            alignment: FractionalOffset.center,
                            child: Text(
                              "Today\'s Cases",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 15, bottom: 8),
                            child: Align(
                              alignment: FractionalOffset.center,
                              child: Text(
                                Utils.formatNumber(country.active),
                                style: TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Align(
                            alignment: FractionalOffset.center,
                            child: Text(
                              "Active",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Divider(
                  color: Colors.black26,
                ),
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 15, bottom: 8),
                            child: Align(
                              alignment: FractionalOffset.center,
                              child: Text(
                                Utils.formatNumber(country.recovered),
                                style: TextStyle(
                                    color: ColorAccent,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Align(
                            alignment: FractionalOffset.center,
                            child: Text(
                              "Recovered",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 15, bottom: 8),
                            child: Align(
                              alignment: FractionalOffset.center,
                              child: Text(
                                Utils.formatNumber(country.critical),
                                style: TextStyle(
                                    color: PrimaryColor,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Align(
                            alignment: FractionalOffset.center,
                            child: Text(
                              "Ctitical",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(5),
          child: Divider(
            color: Colors.black26,
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Cases & Deaths per Million".toUpperCase(),
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 15, bottom: 8),
                            child: Align(
                              alignment: FractionalOffset.center,
                              child: Text(
                                country.casesPerOneMillion.toString(),
                                style: TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Align(
                            alignment: FractionalOffset.center,
                            child: Text(
                              "Cases",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 15, bottom: 8),
                            child: Align(
                              alignment: FractionalOffset.center,
                              child: Text(
                                country.deathsPerOneMillion.toString(),
                                style: TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Align(
                            alignment: FractionalOffset.center,
                            child: Text(
                              "Deaths",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        )
      ];
    }

    Widget body() {
      return ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          errorMessage != null ? errorWidget() : Container(),
          isLoading ? progressBar() : Container(),
          country != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: dataWidget(),
                )
              : Container(),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(country != null ? country.country : "Country"),
      ),
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: Container(
          color: BackgroundColor,
          child: body(),
        ),
      ),
    );
  }

  Future<void> refreshData() async {
    getCasesByCountry();
  }
}
