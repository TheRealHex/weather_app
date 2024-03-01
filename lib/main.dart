import 'package:flutter/material.dart';
import 'package:weather_app/screens/more_info.dart';

import 'screens/home.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData.dark(),
      themeAnimationStyle: AnimationStyle.noAnimation,
      routes: {
        '/': (context) => Home(),
        '/more': (context) => MoreInfo(),
      },
    );
  }
}
