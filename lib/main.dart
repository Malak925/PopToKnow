import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:poptoknow/screens/details.dart';

import 'package:tmdb_api/tmdb_api.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
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
  final String _APIKey = 'ac4dda401eb7b12a4e1a497b8596885a';
  final String _readAccessTokin =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhYzRkZGE0MDFlYjdiMTJhNGUxYTQ5N2I4NTk2ODg1YSIsInN1YiI6IjYzOWRiYmM1YmU2ZDg4MDA4Y2FmMzZjOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.bfLqz_pq8HpoBjtImuWfknivvbJx4ReN6kZG7VQX_oI';

  @override
  void initState() {
    loadPeople();
    super.initState();
  }

  loadPeople() async {
    TMDB _get_data = TMDB(ApiKeys(_APIKey, _readAccessTokin),
        logConfig: const ConfigLogger(showErrorLogs: true, showLogs: true));
    for (int i = 1; i < 500; i++) {
      Map _people = await _get_data.v3.people.getPopular(page: i);
      setState(() {
        popularToKnow = popularToKnow + _people['results'];
      });
    }
    print(popularToKnow);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Popular People")),
      body: ListView.builder(
        itemCount: popularToKnow.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: (() {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Details(index: index, people: popularToKnow);
              }));
            }),
            child: ListTile(title: Text(popularToKnow[index]['name'])),
          );
        },
      ),
    );
  }
}
