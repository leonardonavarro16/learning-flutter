import 'package:flutter/material.dart';
import 'package:swc_front/widgets/utils/email_form_field.dart';
import 'package:swc_front/widgets/utils/password_form_field.dart';
import 'package:swc_front/widgets/utils/submit_button.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              EmailFormField(
                onChanged: (String value) {
                  _formKey.currentState!.validate();
                  email = value;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              PasswordFormField(
                onChanged: (String value) {
                  _formKey.currentState!.validate();
                  password = value;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              PasswordFormField(
                labelText: 'Confirmar contraseña',
                emptyMessage: 'ingrese su contraseña de confirmacion',
                additionalValidator: (String? value) {
                  if (value != password) {
                    return 'La contraseña no coincide ';
                  }
                  return null;
                },
                onChanged: (String value) {
                  _formKey.currentState!.validate();
                  confirmPassword = value;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Registrar'),
              ),
            ],
          ),
        ));
  }
}
