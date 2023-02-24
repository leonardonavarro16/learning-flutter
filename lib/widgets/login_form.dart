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
            }),
            const SizedBox(
              height: 25,
            ),
            PasswordFormField(onChanged: (String value) {
              _formKey.currentState!.validate();
            }),
            const SizedBox(
              height: 25,
            ),
            const SubmitButton(),
          ],
        ));
  }
}
