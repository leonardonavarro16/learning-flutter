import 'package:flutter/material.dart';
import 'package:swc_front/widgets/utils/email_form_field.dart';
import 'package:swc_front/widgets/utils/password_form_field.dart';
import 'package:swc_front/widgets/utils/submit_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String email = '';
  String password = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
          children: [
        const SizedBox(
          height: 25,
        ),
        EmailFormField(onChanged: (String value) {
          _formKey.currentState!.validate();
          setState(() => email = value);
        }),
        const SizedBox(
          height: 25,
        ),
        PasswordFormField(onChanged: (String value) {
          _formKey.currentState!.validate();
          setState(() => password = value);
        }),
        const SizedBox(
          height: 25,
        ),
        buildSubmitButton(),
      ].whereType<Widget>().toList()),
    );
  }

  Widget? buildSubmitButton() {
    bool showButton = _formKey.currentState == null
        ? false
        : _formKey.currentState!.validate();
    if (showButton) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 235, 91, 81),
        ),
        onPressed: () {},
        child: const Text('Enviar'),
      );
    } else {
      return null;
    }
  }
}
