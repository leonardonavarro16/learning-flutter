import 'package:flutter/material.dart';
import 'package:swc_front/presentation/pages/registration_page.dart';
import 'package:swc_front/presentation/forms/login_form.dart';
import '../router/app_router.dart';
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
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.registrationPage);
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Registrate',
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
