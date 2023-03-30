import 'package:flutter/material.dart';
import 'package:swc_front/presentation/widgets/utils/email_form_field.dart';
import 'package:swc_front/presentation/widgets/utils/password_form_field.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  String? email;
  String? password;
  String? confirmPassword;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      const SizedBox(
        height: 15,
      ),
      EmailFormField(
        onChange: (String? value, bool valid) {
          setState(() => email = valid ? value : null);
        },
      ),
      const SizedBox(
        height: 15,
      ),
      PasswordFormField(
        onChange: (String? value, bool valid) {
          setState(() => password = valid ? value : null);
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
        onChange: (String? value, bool valid) {
          setState(() => confirmPassword = valid ? value : null);
        },
      ),
      const SizedBox(
        height: 12,
      ),
      if (_canBuildSubmitButton()) _buildSubmitButton(),
    ]));
  }

  bool _canBuildSubmitButton() {
    return email != null && password != null && confirmPassword != null;
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 235, 91, 81),
      ),
      onPressed: () {
        // context.read<AuthenticationCubit>().(email!, password!, );
      },
      child: const Text('Registrar'),
    );
  }
}
