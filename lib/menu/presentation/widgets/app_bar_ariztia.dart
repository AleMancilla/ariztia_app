import 'package:ariztia_app/core/function_utils.dart';
import 'package:flutter/material.dart';

class AppBarAriztia extends StatelessWidget {
  const AppBarAriztia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = getSizeByContext(context);
    return SizedBox(
      height: 70,
      // color: Colors.red,
      child: Center(
        child: Image.asset(
          'assets/images/ariztia_logo.png',
          width: size.width * 0.7,
        ),
      ),
    );
  }
}
