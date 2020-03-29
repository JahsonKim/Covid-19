import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:virus/api/ApiInterfaces.dart';
import 'package:virus/model/Country.dart';
import 'package:virus/utils/Constants.dart';
import 'package:virus/utils/Utils.dart';

import 'CountryDetails.dart';

class AllCountries extends StatefulWidget {
  AllCountries(this.countries, {Key key, this.title}) : super(key: key);
  final List<Country> countries;
  final String title;

  @override
  CountriesState createState() => CountriesState();
}

class CountriesState extends State<AllCountries> {
  List<Country> countries = new List();
  RestDatasource api = new RestDatasource();
  bool isLoading = false, isCountryLoading = false;
  String errorMessage;

  @override
  void initState() {
    // TODO: implement initState
//    getAllCountries();
    countries = widget.countries;
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
      } else {
        //handle errors
      }
      errorMessage = null;
      //TODO process response here
    }).catchError((exception) {
      //handle errors
      errorMessage = "Error loading countries data";
      setState(() {
        isCountryLoading = false;
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

    Widget getTitleItemWidget(String label, double width) {
      return Container(
        child: Text(label,
            style: TextStyle(
              color: PrimaryText,
              fontWeight: FontWeight.bold,
            )),
        width: width,
        height: 40,
        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        alignment: Alignment.center,
      );
    }

    Widget generateFirstColumnRow(BuildContext context, int index) {
      return ConstrainedBox(
          constraints: new BoxConstraints(
            minHeight: 40.0,
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
                    : Utils.formatNumber(countries[index].todayCases),
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
                minHeight: 40.0,
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
        getTitleItemWidget('Deaths', 100),
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
        color: PrimaryColor,
        child: HorizontalDataTable(
          leftHandSideColumnWidth: 100,
          rightHandSideColumnWidth: 950,
          isFixedHeader: true,
          headerWidgets: _getTitleWidget(),
          leftSideItemBuilder: generateFirstColumnRow,
          rightSideItemBuilder: generateRightHandSideColumnRow,
          itemCount: countries.length,
          rowSeparatorWidget: const Divider(
            color: Colors.black38,
            height: 1.0,
            thickness: 0.0,
          ),
          leftHandSideColBackgroundColor: Color(0xFFFFFFFF),
          rightHandSideColBackgroundColor: Color(0xFFFFFFFF),
        ),
        height: MediaQuery.of(context).size.height,
      );
    }

    Widget body() {
      return ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          errorMessage != null ? errorWidget() : Container(),
          isCountryLoading ? progressBar() : Container(),
          countries.length > 0 ? topCountries() : Container(),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Coronavirus update"),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: Colors.white),
          )
        ],
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
    getAllCountries();
  }
}
