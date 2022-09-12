import 'package:ariztia_app/core/function_utils.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 3500), () {
      Navigator.pushReplacementNamed(context, 'menu_screen');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = getSizeByContext(context);
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/ariztia_logo.png',
          width: size.width * 0.85,
        ),
      ),
    );
  }
}
