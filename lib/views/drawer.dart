import 'package:flutter/material.dart';
import 'package:virus/utils/Constants.dart';

import 'Disclaimer.dart';

class AppDrawer extends StatefulWidget {
  AppDrawer({Key key}) : super(key: key);

  @override
  MyDrawer createState() => MyDrawer();
}

class MyDrawer extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          createHeader(),
          createDrawerItem(
              icon: Icons.copyright,
              text: 'Disclaimer',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Disclaimer(title: 'Discalimer')));
              }),
        ],
      ),
    );
  }

  Widget createHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(color: PrimaryColor),
//        BoxDecoration(
//            image: DecorationImage(
//                fit: BoxFit.fill,
//                image: AssetImage('assets/icon.jpg'))),
        child: Stack(children: <Widget>[
          Positioned(
            bottom: 6.0,
            left: 16.0,
            child: Column(children: <Widget>[
              Text("COVID-19",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500)),
              Text("Coronavirus",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500))
            ]),
          ),
        ]));
  }

  Widget createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(
            icon,
            color:PrimaryText,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text,
                style: TextStyle(
                  color: PrimaryText,
//                    fontSize: 14.0,
//                    fontWeight: FontWeight.w500
                )),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
