import 'package:ariztia_app/menu/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:ariztia_app/menu/presentation/pages/menu_screen.dart';
import 'package:ariztia_app/splash_screen/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      child: const MyApp(),
      providers: [
        BlocProvider<CategoryBloc>(create: (_) => CategoryBloc()),
      ],
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
