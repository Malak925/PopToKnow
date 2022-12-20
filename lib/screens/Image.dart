import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class ImageView extends StatelessWidget {
  final NetworkImage pic;
  const ImageView({super.key, required this.pic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            child: Image(image: pic),
          ),
          IconButton(
              onPressed: () async {
                // var response = await http.get(Uri.parse(pic.url));
                // Directory? documentDirectory =
                //     await getApplicationDocumentsDirectory();
                // File file = new File(
                //     path.join(documentDirectory!.path, path.basename(pic.url)));
                // await file.writeAsBytes(response.bodyBytes);
                // showDialog(
                //     context: context,
                //     builder: (BuildContext context) {
                //       return AlertDialog(
                //         content: Image.file(file),
                //       );
                //     });

                // print(file);
                GallerySaver.saveImage(pic.url);
              },
              icon: Icon(Icons.download))
        ],
      ),
    );
  }
}
