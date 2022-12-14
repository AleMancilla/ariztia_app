//@dart=2.9 --no-sound-null-safety

import 'package:ariztia_app/menu/presentation/bloc/business_bloc/business_bloc.dart';
import 'package:ariztia_app/menu/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:ariztia_app/menu/presentation/bloc/products_bloc/products_bloc.dart';
import 'package:ariztia_app/menu/presentation/bloc/shop_bloc/shop_bloc.dart';
import 'package:ariztia_app/menu/presentation/pages/menu_screen.dart';
import 'package:ariztia_app/menu/presentation/pages/selected_bussiness_screen.dart';
import 'package:ariztia_app/splash_screen/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // configuracion firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      child: const MyApp(),
      providers: [
        BlocProvider<CategoryBloc>(create: (_) => CategoryBloc()),
        BlocProvider<ProductsBloc>(create: (_) => ProductsBloc()),
        BlocProvider<ShopBloc>(create: (_) => ShopBloc()),
        BlocProvider<BusinessBloc>(create: (_) => BusinessBloc()),
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
        'splash': (context) => const SplashScreen(),
        'menu_screen': (context) => const MenuScreen(),
        'selected_business': (context) => const SelectedBusinessScreen(),
      },
      initialRoute: 'splash',
    );
  }
}
