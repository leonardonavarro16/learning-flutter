import 'package:flutter/material.dart';
import 'package:swc_front/presentation/widgets/utils/text_view.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? height;
  final double? width;

  const CustomButton({
    Key? key,
    this.height,
    this.width,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 140,
      height: height ?? 50,
      decoration: BoxDecoration(
        // gradient: const LinearGradient(
        color:
            // [
            // Color.fromARGB(255, 0, 0, 0),
            const Color(0xFFFF0000),
        // ],
        // begin: Alignment.centerRight,
        // end: Alignment.centerLeft,
        // ),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          elevation: 0.0,
        ),
        onPressed: onPressed,
        child: TextView(text: text, fontWeight: FontWeight.bold),
      ),
    );
  }
}
