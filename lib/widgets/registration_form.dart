import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final EmailRegistration = TextEditingController();
  final PasswordRegistration = TextEditingController();
  final ConfirmPassword = TextEditingController();

  void EnviarForm() {
    if (_formKey.currentState!.validate()) {
      final email = EmailRegistration.text;

      final password = PasswordRegistration.text;
      final confirmPassword = ConfirmPassword.text;

      debugPrint('Email: $email');
      debugPrint('Password: $password');
      debugPrint('Confirm password: $confirmPassword');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: EmailRegistration,
            decoration: const InputDecoration(
              labelText: 'correo electronico de registro',
              filled: true,
              fillColor: Colors.white,
            ),
            keyboardType: TextInputType.emailAddress,
            validator: ((value) {
              if (value == null || value.isEmpty) {
                return 'porfavor, introduce tu correo electronico';
              }
              return null;
            }),
          ),
          TextFormField(
            controller: PasswordRegistration,
            decoration: const InputDecoration(
              labelText: 'contraseña ',
              filled: true,
              fillColor: Colors.white,
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'porfavor ingrese su contraseña';
              }
              return null;
            },
          ),
          TextFormField(
            controller: ConfirmPassword,
            decoration: const InputDecoration(
              labelText: 'repita su contraseña',
              filled: true,
              fillColor: Colors.white,
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'porfavor repita su contraseña';
              } else if (value != PasswordRegistration.text) {
                return 'La contraseña no coincide ';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: EnviarForm,
            child: const Text('Registrar'),
          ),
        ],
      ),
    );
  }
}
