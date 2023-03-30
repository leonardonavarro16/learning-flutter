import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swc_front/logic/cubits/authentication_cubit.dart';
import 'package:swc_front/presentation/widgets/utils/email_form_field.dart';
import 'package:swc_front/presentation/widgets/utils/password_form_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});
  @override
  State<LoginForm> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(
        height: 25,
      ),
      EmailFormField(onChange: (String? value, bool valid) {
        if (valid) setState(() => email = value);
      }),
      const SizedBox(
        height: 25,
      ),
      PasswordFormField(onChange: (String? value, bool valid) {
        if (valid) setState(() => password = value);
      }),
      const SizedBox(
        height: 25,
      ),
      if (_canBuildSubmitButton()) _buildSubmitButton(),
    ]);
  }

  bool _canBuildSubmitButton() {
    return email != null && password != null;
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 235, 91, 81),
      ),
      onPressed: () {
        context.read<AuthenticationCubit>().login(email!, password!);
      },
      child: const Text('Enviar'),
    );
  }
}
