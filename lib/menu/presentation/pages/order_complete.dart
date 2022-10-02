import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderComplete extends StatelessWidget {
  const OrderComplete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/endscreenimage.png'),
            SizedBox(height: 40),
            Text(
              'Order Recibida',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontSize: 24,
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Aguarda 15 minutos para recibir tu compra',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 40),
            InkWell(
              onTap: () {
                _launchInBrowser(
                    'https://api.whatsapp.com/send?phone=59163152623&text=Hola');
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(-2, 3),
                    )
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/whatsapp.png',
                      width: 40,
                      height: 40,
                    ),
                    Text(
                      'Atención al cliente',
                      style: TextStyle(
                        color: Colors.red[800],
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              ),
            ),
            SizedBox(height: 40),
            InkWell(
              onTap: () {
                _launchUrl(
                    'https://docs.google.com/forms/d/e/1FAIpQLSeNhBPSSNx9BBtGagi_644q2qeWIA6egp4eeWYzpDO5fOY6hA/viewform?usp=sf_link');
              },
              child: Text(
                'Ayúdanos a mejorar',
                style: TextStyle(
                    color: Colors.red[800],
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                    decoration: TextDecoration.underline),
              ),
            )
          ],
        ),
      ),
      // body: Container(
      //   width: size.width,
      //   height: size.height,
      //   child: Image.asset('assets/images/Screen.png', fit: BoxFit.cover),
      // ),
    );
  }

  Future<void> _launchUrl(String link) async {
    if (!await launchUrl(Uri.parse(link))) {
      throw 'Could not launch $link';
    }
  }

  Future<void> _launchInBrowser(String link) async {
    if (!await launchUrl(
      Uri.parse(link),
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $link';
    }
  }
}
