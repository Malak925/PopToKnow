import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../screens/details.dart';

final String apiKey = 'ac4dda401eb7b12a4e1a497b8596885a';
final String readAccessTokin =
    'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhYzRkZGE0MDFlYjdiMTJhNGUxYTQ5N2I4NTk2ODg1YSIsInN1YiI6IjYzOWRiYmM1YmU2ZDg4MDA4Y2FmMzZjOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.bfLqz_pq8HpoBjtImuWfknivvbJx4ReN6kZG7VQX_oI';
List populartoknow = [];

class TMDBbuilder extends StatefulWidget {
  const TMDBbuilder({super.key});

  @override
  State<TMDBbuilder> createState() => _TMDBbuilderState();
}

class _TMDBbuilderState extends State<TMDBbuilder> {
  loadPeople() async {
    TMDB _get_data = TMDB(ApiKeys(apiKey, readAccessTokin),
        logConfig: const ConfigLogger(showErrorLogs: true, showLogs: true));
    for (int i = 1; i < 500; i++) {
      Map _people = await _get_data.v3.people.getPopular(page: i);

      setState(() {
        populartoknow = populartoknow + _people['results'];
      });
    }
    print(populartoknow);
  }

  @override
  void initState() {
    loadPeople();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: populartoknow.length,
      itemBuilder: (BuildContext context, int index) {
        Details det = Details(index: index, people: populartoknow);
        return InkWell(
          onTap: (() {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return det;
            }));
          }),
          child: ListTile(title: Text(populartoknow[index]['name'])),
        );
      },
    );
  }
}
