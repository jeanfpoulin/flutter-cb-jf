import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'globals.dart' as globals;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon Collège Boréal',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: globals.cbColor
      ),
      home: PageMaison(),
    );
  }
}

class PageMaison extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(appBar: AppBar(title: Text("Mon Collège Boréal"),),
    body:new Stack(children: <Widget>[
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg/background-boreal-full.png"),
            fit: BoxFit.cover,
          ),
        ),
        ),
        MenuPrincipal(),
    ]));
  }

}

class MenuPrincipal extends StatelessWidget {
  const MenuPrincipal({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 2.0,
            color: globals.cbColor,
            child: new InkWell(
              highlightColor: globals.cbColor,
              splashColor: globals.cbColor.shade700,
              child: ListTile(
                leading: Image(image: new AssetImage("assets/icons/brightspace_logo_48.png")),
                title: Text("Mes cours", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                trailing: Icon(Icons.web, color: Colors.grey,),
              ),
              onTap: _onMenuTap(true, "https://collegeboreal.brightspace.com/"),
            ),
          ),
        )
      ],
    );
  }

  _onMenuTap(bool external, String destination) async {
    if(external && (await canLaunch(destination))){ 
      await launch(destination);
    } else {
      throw 'Could not launch';
    }
  }
}
