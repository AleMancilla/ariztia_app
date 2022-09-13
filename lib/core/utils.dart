import 'package:flutter/material.dart';
import 'package:status_alert/status_alert.dart';

void navigateToPage(BuildContext context, Widget page) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (BuildContext context) => page,
    ),
  );
}

void navigateToPageAndRemove(BuildContext context, Widget page) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (BuildContext context) => page,
    ),
  );
}

Future loadingAsyncFunction(
  BuildContext context,
  Function function,
) async {
  showProgressIndicator(context);
  try {
    await function();
  } catch (e) {
    showErrorAlert(context, 'ERROR AL CAPTURAR DATOS', '$e');
  }
  Navigator.pop(context);
}

void showProgressIndicator(BuildContext context) {
// show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const Scaffold(
        backgroundColor: Colors.white12,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    },
  );
}

void showErrorAlert(BuildContext context, String title, String description) {
  StatusAlert.show(
    context,
    duration: const Duration(milliseconds: 3500),
    title: title,
    subtitle: description,
    configuration: const IconConfiguration(icon: Icons.close),
  );
}

void showCorrectAlert(BuildContext context, String title, String description) {
  StatusAlert.show(
    context,
    duration: const Duration(milliseconds: 3500),
    title: title,
    subtitle: description,
    configuration: const IconConfiguration(icon: Icons.check),
  );
}
