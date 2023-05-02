import 'package:flutter/material.dart';

import 'base_text_form_field.dart';

class EmailFormField extends StatelessWidget {
  final void Function(String?, bool) onChange;
  final void Function(String)? onFieldSubmitted;
  final String? initialValue;

  const EmailFormField({
    super.key,
    this.initialValue,
    this.onFieldSubmitted,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return BaseTextFormField(
      fieldValue: initialValue,
      decoration: const InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: 'Correo electrónico',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Correo electrónico';
        }
        final emailRegex = RegExp(r'^[\w-zñ\.]+@([\w-zñ]+\.)+[\w-z]{2,4}$');
        if (!emailRegex.hasMatch(value)) {
          return 'Ingrese un correo electrónico válido';
        }
        return null;
      },
      onChange: (String? value, bool isValid) {
        // Javi, esto es lo que convierte en minusculas antes de registrar en el backend
        onChange(value?.toLowerCase(), isValid);
      },
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
