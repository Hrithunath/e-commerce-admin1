import 'package:flutter/material.dart';

void showAlertDialog(BuildContext context, String title, String content, Future<void> Function() onConfirm) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          
          TextButton(
            child: const Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop(); 
            },
          ),
          // OK Button
          TextButton(
            child: const Text("OK"),
            onPressed: () async {
              await onConfirm(); 
              Navigator.of(context).pop(); 
            },
          ),
        ],
      );
    },
  );
}
