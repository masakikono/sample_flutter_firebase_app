import 'package:flutter/material.dart';

class ShowDialog {
  static Future<int?> displayConfirmDialog(context, message) {
    return showDialog<int>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(message),
            actions: <Widget>[
              OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop(1);
                  },
                  child: const Text('OK'))
            ],
          );
        });
  }
}
