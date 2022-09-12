import 'package:ariztia_app/menu/presentation/pages/menu_screen.dart';
import 'package:ariztia_app/splash_screen/pages/splash_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ariztia',
      routes: {
        'splash': (context) => SplashScreen(),
        'menu_screen': (context) => MenuScreen(),
      },
      initialRoute: 'splash',
    );
  }
}
