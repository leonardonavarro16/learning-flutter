import 'package:flutter/material.dart';
import 'package:swc_front/presentation/widgets/utils/text_view.dart';

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
            TextView(text: message),
          ],
        ),
        action: SnackBarAction(
          label: 'close',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
