import 'package:flutter/material.dart';

import 'base_text_form_field.dart';

class EmailFormField extends StatelessWidget {
  final void Function(String?, bool) onChange;
  const EmailFormField({super.key, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return BaseTextFormField(
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
        onChange: (String? value, bool isValid) {
          onChange(value, isValid);
        });
  }
}
