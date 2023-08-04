import 'package:flutter/material.dart';
import 'package:marquee_text/marquee_text.dart';
import 'package:swc_front/presentation/widgets/utils/text_view.dart';

class SnackBarUtil {
  static showSnackBar(BuildContext context, String message,
      {Icon? icon, Color? backgroundColor, Color? textColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
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
