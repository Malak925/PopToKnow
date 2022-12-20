import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:poptoknow/providers/DarkThemeProvider.dart';
import 'package:poptoknow/screens/details.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tmdb_api/tmdb_api.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) {
      return ThemeProvider();
    },
    builder: (context, child) {
      final pro = Provider.of<ThemeProvider>(context);
      return MaterialApp(
          theme: ThemeData(brightness: pro.Theme), home: MyApp());
    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Home();
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List popularToKnow = [];
  List details = [];
  bool light = true;
  final String _APIKey = 'ac4dda401eb7b12a4e1a497b8596885a';
  final String _readAccessTokin =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhYzRkZGE0MDFlYjdiMTJhNGUxYTQ5N2I4NTk2ODg1YSIsInN1YiI6IjYzOWRiYmM1YmU2ZDg4MDA4Y2FmMzZjOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.bfLqz_pq8HpoBjtImuWfknivvbJx4ReN6kZG7VQX_oI';
  SaveRef(isBright) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool("Bright", isBright);
  }

  GetPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getBool("Bright");
    if (prefs.getBool("Bright") == false) {
      light = false;
    }
    print(light);
  }

  @override
  initState() {
    GetPrefs();

    loadPeople();
  }

  // ThemeStart() async {
  //   final pro = Provider.of<ThemeProvider>(context);

  //   bool preftheme = await pref.getTheme();
  //   pro.changeTheme(preftheme);
  // }

  loadPeople() async {
    TMDB _get_data = TMDB(ApiKeys(_APIKey, _readAccessTokin),
        logConfig: const ConfigLogger(showErrorLogs: true, showLogs: true));
    for (int i = 1; i < 500; i++) {
      Map _people = await _get_data.v3.people.getPopular(page: i);
      // Map _people_details =
      //     await _get_data.v3.people.getDetails(_people[0]['id']);
      setState(() {
        popularToKnow = popularToKnow + _people['results'];
        // details = details + _people_details['biography'];
      });
    }
    print(popularToKnow);
  }

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Popular People"),
        actions: [
          Switch(
              value: light,
              onChanged: (value) {
                setState(() {
                  light = value;
                  SaveRef(value);
                  print(light);
                  pro.changeTheme();
                });
              })
        ],
      ),
      body: ListView.builder(
        itemCount: popularToKnow.length,
        itemBuilder: (BuildContext context, int index) {
          Details det = Details(index: index, people: popularToKnow);
          return InkWell(
            onTap: (() {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return det;
              }));
            }),
            child: ListTile(title: Text(popularToKnow[index]['name'])),
          );
        },
      ),
    );
  }
}
