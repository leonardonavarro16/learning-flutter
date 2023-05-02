import 'package:flutter/material.dart';
import 'package:swc_front/presentation/widgets/layout.dart';
import 'package:swc_front/presentation/forms/registration_form.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Layout(
        content: Center(
          child: SizedBox(
            width: constraints.maxWidth * 0.8,
            child: Column(
              children: const [
                RegistrationForm(),
              ],
            ),
          ),
        ),
      );
    });
  }
}
