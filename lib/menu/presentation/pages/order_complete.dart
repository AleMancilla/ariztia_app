import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderComplete extends StatelessWidget {
  const OrderComplete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 0, bottom: 25, left: 25, right: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buttonBack(context),
            const SizedBox(height: 40),
            Image.asset('assets/images/endscreenimage.png'),
            const SizedBox(height: 40),
            _textOrderRecived(),
            _description(),
            const SizedBox(height: 40),
            _atencionAlCliente(),
            const SizedBox(height: 40),
            _ayudanosAMejorar()
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

  InkWell _ayudanosAMejorar() {
    return InkWell(
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
    );
  }

  InkWell _atencionAlCliente() {
    return InkWell(
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
    );
  }

  Container _description() {
    return Container(
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
    );
  }

  Text _textOrderRecived() {
    return const Text(
      'Orden Recibida',
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w800,
        fontSize: 24,
      ),
    );
  }

  InkWell _buttonBack(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Row(
        children: [
          Icon(
            Icons.chevron_left_rounded,
            color: Colors.red[900],
            size: 60,
          ),
          Text(
            'Realizar otra compra',
            style: TextStyle(
              color: Colors.red[900],
              fontSize: 16,
            ),
          )
        ],
      ),
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
