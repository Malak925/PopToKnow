import 'package:flutter/material.dart';
import 'package:poptoknow/screens/Image.dart';

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
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          // ignore: sort_child_properties_last
          children: [
            Image(
                //       // ignore: prefer_interpolation_to_compose_strings
                image: NetworkImage(
                    "https://image.tmdb.org/t/p/original${people[index]['profile_path']}")),
            Text(people[index]['gender'] == 2
                ? "Gender: Male"
                : "Gender: Female"),
            Text("Popularity: ${people[index]['popularity']}"),
            Text(
              "Popular Movies",
              style: TextStyle(fontSize: 30),
            ),
            Text(
              knownFor[0]["original_title"] != null
                  ? knownFor[0]["original_title"]
                  : "Text NOT Found",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              knownFor[0]['overview'],
            ),
            Text(
              knownFor[1]["original_title"] != null
                  ? knownFor[1]["original_title"]
                  : "Text NOT Found",
              style: TextStyle(fontSize: 20),
            ),

            Container(
              color: Colors.blue,
              child: Text(
                knownFor[1]['overview'],
              ),
            ),

            Text(
              knownFor[2]["original_title"] != null
                  ? knownFor[2]["original_title"]
                  : "Text NOT Found",
              style: TextStyle(fontSize: 20),
            ),
            Container(
              color: Colors.red,
              child: Text(
                knownFor[2]['overview'],
              ),
            ),
            // Container(
            //   child: Image(
            // image: NetworkImage("https://image.tmdb.org/t/p/w500" +
            //     knownFor[1]['backdrop_path'])),
            // )

            Container(
              height: 200,
              width: 200,
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 5),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    NetworkImage picV = NetworkImage(
                        "https://image.tmdb.org/t/p/w500" +
                            knownFor[index]['poster_path']);
                    return InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: ((context) {
                            return ImageView(pic: picV);
                          })));
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: picV),
                          ),
                        ));
                  }),
            )
          ],
        ),
      ),
    );
  }
}
