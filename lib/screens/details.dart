import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  final List people;
  final int index;
// poster_path
  const Details({super.key, required this.index, required this.people});

  @override
  Widget build(BuildContext context) {
    List knownFor = people[index]['known_for'];

    return Scaffold(
      appBar: AppBar(
        title: Text(people[index]['name']),
      ),
      body: ListView(
        // ignore: sort_child_properties_last
        children: <Widget>[
          Image(
              //       // ignore: prefer_interpolation_to_compose_strings
              image: NetworkImage(
                  "https://image.tmdb.org/t/p/original${people[index]['profile_path']}")),
          Text("Popular Movies"),
          // Text(knownFor[0]["original_title"]),
          Text(knownFor[0]['overview']),
          // Text(knownFor[0]["original_title"]),
          // if (knownFor[0]['poster_path'] != null)

          Container(
            color: Colors.blue,
            child: Text(knownFor[0]['overview']),
          ),

          // Text(knownFor[0]["original_title"]),
          Container(
            color: Colors.red,
            child: Text(knownFor[0]['overview']),
          ),
          // Container(
          //   child: Image(
          //       image: NetworkImage("https://image.tmdb.org/t/p/w500" +
          //           knownFor[1]['backdrop_path'])),
          // )
        ],
        scrollDirection: Axis.vertical,
      ),
    );
  }
}
