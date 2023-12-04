import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String message;
  final List<Widget> actions;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.message,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    AlertDialog alert = AlertDialog.adaptive(
      title: Text(title),
      content: Text(message),
      actions: actions,
    );

    return alert;
  }
}
