import 'package:flutter/material.dart';

class SnackBarUtil {
  static showSnackBar(BuildContext context, String message,
      {Icon? icon, Color? backgroundColor, Color? textColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor:
            backgroundColor ?? const Color.fromARGB(255, 235, 91, 81),
        content: Row(
          children: [
            icon ?? const Icon(Icons.error_outline),
            const SizedBox(width: 10),
            Text(message),
          ],
        ),
        action: SnackBarAction(
          label: 'Cerrar',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
