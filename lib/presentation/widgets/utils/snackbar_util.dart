import 'package:flutter/material.dart';
import 'package:marquee_text/marquee_text.dart';

class SnackBarUtil {
  static showSnackBar(BuildContext context, String message,
      {Icon? icon, Color? backgroundColor, Color? textColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        backgroundColor:
            backgroundColor ?? const Color.fromARGB(255, 235, 91, 81),
        content: Row(
          children: [
            Expanded(
              child: MarqueeText(
                speed: 10,
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  text: message,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
