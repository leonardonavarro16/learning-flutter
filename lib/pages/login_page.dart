import 'package:flutter/material.dart';
import 'package:swc_front/pages/registration_page.dart';
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
            width: constraints.maxWidth * 0.8,
            child: Column(
              children: [
                const LoginForm(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegistrationPage()),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Registrate aqui',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ));
    });
  }
}


//  content: Center(child: SizedBox(width: contrains.maxwidht, child: LoginForm())),
