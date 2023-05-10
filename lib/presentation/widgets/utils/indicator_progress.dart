import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomIndicatorProgress extends StatelessWidget {
  const CustomIndicatorProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoActivityIndicator(
      color: Colors.white,
      radius: 14,
    );
  }
}
