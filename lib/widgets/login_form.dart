import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  // _formKey.currentState.validate()

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            EmailFormField(onChanged: () {
              _formKey.currentState!.validate();
            }),
            const SizedBox(
              height: 25,
            ),
            PasswordFormField(onChanged: () {
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

class EmailFormField extends StatelessWidget {
  final Function onChanged;
  const EmailFormField({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: 'Correo electrónico',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ingrese su correo electrónico';
        }
        final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
        if (!emailRegex.hasMatch(value)) {
          return 'Ingrese un correo electrónico válido';
        }
        return null;
      },
      onChanged: (value) {
        onChanged();
      },
    );
  }
}

class PasswordFormField extends StatelessWidget {
  final Function onChanged;

  const PasswordFormField({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Contraseña',
        filled: true,
        fillColor: Colors.white,
      ),
      obscureText: true,
      validator: ((value) {
        if (value == null || value.isEmpty) {
          return 'ingrese su contraseña';
        }
        return null;
      }),
      onChanged: (String value) {
        onChanged();
      },
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(Color.fromARGB(255, 235, 91, 81)),
      ),
      child: const Text('Enviar'),
    );
  }
}
