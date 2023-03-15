import 'package:flutter/material.dart';
import 'package:swc_front/presentation/widgets/layout.dart';
import 'package:swc_front/forms/registration_form.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Layout(content: RegistrationForm());
  }
}
