import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swc_front/logic/cubits/authentication_cubit.dart';
import 'package:swc_front/logic/states/authentication.dart';
import 'package:swc_front/presentation/widgets/utils/email_form_field.dart';
import 'package:swc_front/presentation/widgets/utils/password_form_field.dart';

import '../router/app_router.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});
  @override
  State<LoginForm> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (BuildContext context, AuthenticationState state) {
        if (state.authenticationStatus == AuthenticationStatus.success) {
          Navigator.pushNamed(context, Routes.indexPage);
        }
      },
      child: Form(
        key: _formKey,
        child: Column(children: [
          const SizedBox(
            height: 25,
          ),
          EmailFormField(
            onChange: (String? value, bool valid) {
              if (valid) setState(() => email = value);
            },
            onFieldSubmitted: (_) => _submitForm(),
          ),
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
        ]),
      ),
    );
  }

  bool _canBuildSubmitButton() {
    return email != null && password != null;
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 235, 91, 81),
      ),
      onPressed: _submitForm,
      child: const Text('Enviar'),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context.read<AuthenticationCubit>().login(email!, password!);
    }
  }
}
