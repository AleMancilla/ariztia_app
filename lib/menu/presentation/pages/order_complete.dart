import 'package:flutter/material.dart';

class OrderComplete extends StatelessWidget {
  const OrderComplete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: Image.asset('assets/images/Screen.png', fit: BoxFit.cover),
      ),
    );
  }
}
