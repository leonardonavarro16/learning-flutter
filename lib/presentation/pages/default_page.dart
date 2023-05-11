import 'package:flutter/material.dart';
import 'package:swc_front/presentation/widgets/utils/text_view.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextView(text: 'Error 404: Page not found'),
      ),
      body: const Center(
        child: TextView(
            text: 'Oops! The page you are looking for does not exist.'),
      ),
    );
  }
}
