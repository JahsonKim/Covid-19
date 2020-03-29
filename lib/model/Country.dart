class Country {
  String country;
  CountryInfo countryInfo;
  int cases;
  int todayCases;
  int deaths;
  int todayDeaths;
  int recovered;
  int active;
  int critical;
  dynamic casesPerOneMillion;
  dynamic deathsPerOneMillion;

  Country.empty();

//  {
//  "country": "Zimbabwe",
//  "countryInfo": {
//  "_id": 716,
//  "lat": -20,
//  "long": 30,
//  "flag": "https://raw.githubusercontent.com/NovelCOVID/API/master/assets/flags/zw.png",
//  "iso3": "ZWE",
//  "iso2": "ZW"
//  },
//  "cases": 7,
//  "todayCases": 2,
//  "deaths": 1,
//  "todayDeaths": 0,
//  "recovered": 0,
//  "active": 6,
//  "critical": 0,
//  "casesPerOneMillion": 0.5,
//  "deathsPerOneMillion": 0.07
//  },

  Country.map(dynamic obj) {

    this.country = obj["country"];
    this.countryInfo = CountryInfo.map(obj['countryInfo']);
    this.cases = obj["cases"];
    this.todayCases = obj["todayCases"];
    this.deaths = obj["deaths"];
    this.todayDeaths = obj["todayDeaths"];
    this.recovered = obj["recovered"];
    this.active = obj["active"];
    this.critical = obj["critical"];
    this.casesPerOneMillion = obj["casesPerOneMillion"];
    this.deathsPerOneMillion = obj["deathsPerOneMillion"];

  }
}

class CountryInfo {
  dynamic lat;
  dynamic lng;
  String flag;
  String iso3;
  String iso2;

  CountryInfo.empty();

//  "countryInfo": {
//  "_id": 716,
//  "lat": -20,
//  "long": 30,
//  "flag": "https://raw.githubusercontent.com/NovelCOVID/API/master/assets/flags/zw.png",
//  "iso3": "ZWE",
//  "iso2": "ZW"
//  }

  CountryInfo.map(dynamic obj) {
    this.lat = obj["lat"];
    this.lng = obj["long"];
    this.flag = obj["flag"];
    this.iso3 = obj["iso3"];
    this.iso2 = obj["iso2"];

  }
}
