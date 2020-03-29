import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:virus/api/ApiInterfaces.dart';
import 'package:virus/helpers/MyPreferences.dart';
import 'package:virus/model/Country.dart';
import 'package:virus/model/Covid.dart';
import 'package:virus/model/DrawerItem.dart';
import 'package:virus/utils/Constants.dart';
import 'package:virus/utils/Utils.dart';
import 'package:virus/views/CountryDetails.dart';

import 'AllCountries.dart';
import 'drawer.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  List<Country> countries = new List();
  List<Country> searchList = new List();

  RestDatasource api = new RestDatasource();
  bool isLoading = false, isCountryLoading = false;
  Covid covid;

  String searchQuery = "Search";
  TextEditingController searchCtrl;
  bool isSearching = false;
  static final GlobalKey<ScaffoldState> scaffoldKey =
      new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    searchCtrl = new TextEditingController();
    MyPreferences().getCases().then((value) {
      setState(() {
        covid = value;
      });
    });

    MyPreferences().getTopTen().then((value) {
      setState(() {
        List<Country> countriesData = new List();
        for (var data in value) {
          Country country = Country.map(data);
          countriesData.add(country);
//          print("case "+data['countryInfo']['long'].toString() );
        }
        setState(() {
          countries = countriesData;
        });
      });
    });

    getAllCases();
    getAllCountries();
    super.initState();
  }

  getAllCountries() async {
    setState(() {
      isCountryLoading = true;
    });
    await api.getAllCountries().then((String response) {
      setState(() {
        isCountryLoading = false;
      });

      MyPreferences().setTopTen(response);
      final res = json.decode(response);

      if (res != null) {
        List<Country> countriesData = new List();
        for (var data in res) {
          Country country = Country.map(data);
          countriesData.add(country);
//          print("case "+data['countryInfo']['long'].toString() );
        }
        setState(() {
          countries = countriesData;
        });
        print("Size " + countries.length.toString());
      } else {
        //handle errors
      }
      //TODO process response here
    }).catchError((exception) {
      //handle errors
      setState(() {
        isCountryLoading = false;
      });
    });
  }

  getAllCases() async {
    setState(() {
      isLoading = true;
    });
    await api.getAllCases().then((String response) {
      setState(() {
        isLoading = false;
      });
      print(response);
      final res = json.decode(response);
      MyPreferences().setCases(response);
      if (res != null) {
        setState(() {
          covid = Covid.map(res);
        });
      } else {
        //handle errors
      }
      //TODO process response here
    }).catchError((exception) {
      //handle errors
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
              "updating ...",
              style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.normal),
            )
          ],
        ),
      );
    }

    Widget allCases() {
      return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 25, bottom: 8),
            child: Align(
              alignment: FractionalOffset.center,
              child: Text(
                Utils.formatNumber(covid.cases),
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
            padding: EdgeInsets.all(8),
            child: Divider(
              color: Colors.black26,
            ),
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
                            Utils.formatNumber(covid.deaths),
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: PrimaryColor,
                            ),
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
                                Utils.formatNumber(covid.recovered),
                                style: TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.bold),
                              ),
                            )),
                        Align(
                          alignment: FractionalOffset.center,
                          child: Text(
                            "Rocovered",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                  )),
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
                            Utils.formatNumber(covid.active),
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Align(
                        alignment: FractionalOffset.center,
                        child: Text(
                          "Active Cases",
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
            padding: EdgeInsets.only(top: 25, bottom: 10, right: 3),
            child: Align(
              alignment: FractionalOffset.centerRight,
              child: Text(
                "Updated at: " + Utils.formatTime(covid.updated),
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 9,
                    fontStyle: FontStyle.italic),
              ),
            ),
          )
        ],
      );
    }

    Widget getTitleItemWidget(String label, double width) {
      return Container(
        child: Text(label,
            style: TextStyle(
              color: PrimaryText,
              fontWeight: FontWeight.bold,
            )),
        width: width,
        height: 30,
        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        alignment: Alignment.center,
      );
    }

    Widget generateFirstColumnRow(BuildContext context, int index) {
      return ConstrainedBox(
          constraints: new BoxConstraints(
            minHeight: 30.0,
          ),
          child: GestureDetector(
            onTap: () {
              Route route = MaterialPageRoute(
                  builder: (context) =>
                      CountryDetails(countries[index].countryInfo.iso3));
              Navigator.push(context, route);
            },
            child: Container(
              child: Text(
                countries[index].country.toString(),
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
              width: 150,
              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
              alignment: Alignment.centerLeft,
            ),
          ));
    }

    Widget generateRightHandSideColumnRow(BuildContext context, int index) {
      return Row(
        children: <Widget>[
          Container(
            child: Text(Utils.formatNumber(countries[index].cases),
                style: TextStyle(fontSize: 14, color: PrimaryText)),
            width: 100,
//            height: 52,
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.center,
          ),
          Container(
            child: Text(
                countries[index].todayCases == 0
                    ? ""
                    : countries[index].todayCases.toString(),
                style: TextStyle(
                    fontSize: 14,
                    color: PrimaryText,
                    fontWeight: FontWeight.bold)),
            width: 100,
//            height: 52,
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.center,
          ),
          Container(
            child: Text(Utils.formatNumber(countries[index].deaths),
                style: TextStyle(fontSize: 14, color: PrimaryText)),
            width: 100,
//            height: 52,
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.center,
          ),
          ConstrainedBox(
              constraints: new BoxConstraints(
                minHeight: 30.0,
              ),
              child: Container(
                child: Text(
                    countries[index].todayDeaths == 0
                        ? ""
                        : "+" +
                            Utils.formatNumber(countries[index].todayDeaths),
                    style: TextStyle(
                        fontSize: 14,
                        color: PrimaryColor,
                        fontWeight: FontWeight.bold)),
                width: 100,

//            height: 52,
                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                alignment: Alignment.center,
              )),
          Container(
            child: Text(Utils.formatNumber(countries[index].recovered),
                style: TextStyle(fontSize: 14, color: PrimaryText)),
            width: 100,
//            height: 52,
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.center,
          ),
          Container(
            child: Text(Utils.formatNumber(countries[index].active),
                style: TextStyle(fontSize: 14, color: PrimaryText)),
            width: 100,
//            height: 52,
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.center,
          ),
          Container(
            child: Text(Utils.formatNumber(countries[index].critical),
                style: TextStyle(fontSize: 14, color: PrimaryText)),
            width: 100,
//            height: 52,
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.center,
          ),
          Container(
            child: Text(countries[index].casesPerOneMillion.toString(),
                style: TextStyle(fontSize: 14, color: PrimaryText)),
            width: 100,
//            height: 52,
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.center,
          ),
          Container(
            child: Text(countries[index].deathsPerOneMillion.toString(),
                style: TextStyle(fontSize: 14, color: PrimaryText)),
            width: 100,
//            height: 52,
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.center,
          ),
        ],
      );
    }

    List<Widget> _getTitleWidget() {
      return [
        getTitleItemWidget('Country', 150),
        getTitleItemWidget("Cases", 100),
        getTitleItemWidget('New Cases', 100),
        getTitleItemWidget('Death', 100),
        getTitleItemWidget('New Deaths', 100),
        getTitleItemWidget("Recovered", 100),
        getTitleItemWidget('Active', 100),
        getTitleItemWidget('Critical', 100),
        getTitleItemWidget('Cases/M', 100),
        getTitleItemWidget('Deaths/M', 100),
      ];
    }

    Widget topCountries() {
      return Container(
//        color: PrimaryColor,
        child: HorizontalDataTable(
          leftHandSideColumnWidth: 150,
          rightHandSideColumnWidth: 950,
          isFixedHeader: true,
          headerWidgets: _getTitleWidget(),
          leftSideItemBuilder: generateFirstColumnRow,
          rightSideItemBuilder: generateRightHandSideColumnRow,
          itemCount: 10,
          rowSeparatorWidget: const Divider(
            color: Colors.black38,
            height: 1.0,
            thickness: 0.0,
          ),
          leftHandSideColBackgroundColor: BackgroundColor,
          rightHandSideColBackgroundColor: BackgroundColor,
        ),
        height: 350,
      );
    }

    Widget viewAll() {
      return Align(
        alignment: Alignment.centerRight,
        child: FlatButton(
          onPressed: () {
            Route route = MaterialPageRoute(
                builder: (context) => AllCountries(countries));
            Navigator.push(context, route);
          },
          child: Text(
            "VIEW ALL COUNTRIES",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
      );
    }

    Widget body() {
      return ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          isLoading ? progressBar() : Container(),
          covid != null ? allCases() : Container(),
          Padding(
            padding: EdgeInsets.all(6),
            child: Divider(
              color: Colors.black26,
            ),
          ),
          isCountryLoading ? progressBar() : Container(),
          countries.length > 0 ? topCountries() : Container(),
          countries.length > 0 ? viewAll() : Container()
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Novel Coronavirus "),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: Colors.white),
          )
        ],
      ),
      drawer: AppDrawer(),
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
    print('refreshing data...');
    getAllCases();
    getAllCountries();
  }
}
