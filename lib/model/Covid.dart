class Covid {
  int cases;
  int deaths;
  int recovered;
  int active;
  int updated;

  Covid.empty();

//{
//"cases": 615970,
//"deaths": 28375,
//"recovered": 137336,
//"updated": 1585401049081,
//"active": 450259
//}
  Covid.map(dynamic obj) {
    this.cases = obj["cases"];
    this.deaths = obj["deaths"];
    this.recovered = obj["recovered"];
    this.updated = obj["updated"];
    this.active = obj["active"];
  }
}