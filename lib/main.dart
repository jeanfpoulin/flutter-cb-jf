import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

import 'modele/nouvelle.dart';

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
          primarySwatch: globals.cbColor),
      home: PageMaison(),
    );
  }
}

class PageMaison extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Mon Collège Boréal"),
        ),
        body: new Stack(children: <Widget>[
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
    return _buildNewsList(context);
  }

  Widget _buildNewsList(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('nouvelles').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        //return Text('success');
        return ListView(
          padding: const EdgeInsets.only(top: 20.0),
          children: snapshot.data.documents
              .map((data) => _buildNewsListItem(context, data))
              .toList(),
        );
      },
    );
  }

  Widget _buildNewsListItem(BuildContext context, DocumentSnapshot data) {
    final record = Nouvelle.fromSnapshot(data);

    return Padding(
        key: ValueKey(record.nom),
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: ListTile(
              title: Text(record.nom),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PageDetails(record: record, heroName: "test")),
                );
              }),
        ));
  }
}

class PageDetails extends StatelessWidget {
  Nouvelle record;
  String heroName;
  PageDetails({this.record, this.heroName});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Mon Collège Boréal"),
        ),
        body: new Stack(children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bg/background-boreal-full.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(record.nom, style: TextStyle(color: Colors.white)),
        ]));
  }
}
