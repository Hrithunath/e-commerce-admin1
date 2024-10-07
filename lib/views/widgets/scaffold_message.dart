
import 'package:flutter/material.dart';

void showSnackBarMessage(BuildContext context, String message, {Color backgroundColor = Colors.black}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
    ),
  );
}

