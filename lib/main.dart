import 'package:flutter/material.dart';
import 'package:poptoknow/Shared/SwitchSharedPrefrences.dart';
import 'package:poptoknow/providers/DarkThemeProvider.dart';
import 'package:provider/provider.dart';
import 'Components/ListOfPeople.dart';

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
  SwitchSharedPrefrences state = SwitchSharedPrefrences();
  TMDBbuilder _apiBuilder = TMDBbuilder();
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
                  state.SaveRef(value);
                  print(state.GetPrefs());
                  pro.changeTheme();
                });
              })
        ],
      ),
      body: const TMDBbuilder(),
    );
  }
}
