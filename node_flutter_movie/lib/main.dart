import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:node_flutter_movie/auth/logIn.dart';
import 'package:node_flutter_movie/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'song',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreen(
        splash: Image.network(
            "https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Anime_film_icon.svg/1200px-Anime_film_icon.svg.png",),
        duration: 2500,
        splashTransition: SplashTransition.fadeTransition,
        animationDuration: const Duration(seconds: 2),
        backgroundColor: Color(0xFFE6E6E6),
        // nextScreen: const MyHomePage()),
        nextScreen: logInPage(),
      ),
    );
  }
}
