import 'package:flutter/material.dart';
import 'package:poptoknow/Components/Image.dart';

class MoviesView extends StatelessWidget {
  final List known_for;
  const MoviesView({super.key, required this.known_for});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, mainAxisSpacing: 0, crossAxisSpacing: 5),
          itemCount: 3,
          itemBuilder: (context, index) {
            NetworkImage picV = NetworkImage("https://image.tmdb.org/t/p/w500" +
                        known_for[index]['poster_path'] !=
                    null
                ? "https://image.tmdb.org/t/p/w500" +
                    known_for[index]['poster_path']
                : "https://www.shutterstock.com/image-vector/design-no-more-message-260nw-1672159018.jpg");
            return InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) {
                    return ImageView(
                        pic: picV != null
                            ? picV
                            : NetworkImage(
                                "https://www.shutterstock.com/image-vector/design-no-more-message-260nw-1672159018.jpg"));
                  })));
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: picV == null
                            ? NetworkImage(
                                "https://www.shutterstock.com/image-vector/design-no-more-message-260nw-1672159018.jpg")
                            : picV),
                  ),
                ));
          }),
    );
  }
}
