import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool light = true;

class SwitchSharedPrefrences extends StatelessWidget {
  const SwitchSharedPrefrences({super.key});
  @override
  void initState() {
    GetPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

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
}
