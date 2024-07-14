import 'package:flutter/material.dart';
import 'dart:io';

class AutoCloseAlertDialog extends StatefulWidget {
  @override
  _AutoCloseAlertDialogState createState() => _AutoCloseAlertDialogState();
}

class _AutoCloseAlertDialogState extends State<AutoCloseAlertDialog> {
  int _counter = 3;

  @override
  void initState() {
    super.initState();
    // Start the countdown timer
    _startCountdown();
  }

  void _startCountdown() {
    Future.delayed(Duration(seconds: 1), () {
      if (_counter > 1) {
        setState(() {
          _counter--;
        });
        _startCountdown();
      } else {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
          exit(1);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Something's Wrong !!!"),
      content: Text(
          'Error in RFID connection, the aplication will be close automatically in $_counter seconds.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('OK ($_counter)'),
        ),
      ],
    );
  }
}
