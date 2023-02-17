import 'package:flutter/material.dart';
import 'package:swc_front/widgets/login_form.dart';
import '../widgets/layout.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Layout(
          content: Center(
        child: SizedBox(
            width: constraints.maxWidth * 0.8, child: const LoginForm()),
      ));
    });
  }
}


//  content: Center(child: SizedBox(width: contrains.maxwidht, child: LoginForm())),
