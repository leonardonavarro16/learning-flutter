import 'package:flutter/material.dart';

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
      onChanged: (String value) {
        onChanged(value);
      },
    );
  }
}
