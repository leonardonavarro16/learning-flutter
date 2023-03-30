import 'package:flutter/material.dart';

import 'base_text_form_field.dart';

class PasswordFormField extends StatelessWidget {
  final void Function(String? value, bool valid) onChange;
  final Function? additionalValidator;
  final String? emptyMessage;
  final String? labelText;

  const PasswordFormField({
    super.key,
    required this.onChange,
    this.additionalValidator,
    this.emptyMessage,
    this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return BaseTextFormField(
      decoration: InputDecoration(
        labelText: labelText ?? 'Contraseña',
        filled: true,
        fillColor: Colors.white,
      ),
      obscureText: true,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return emptyMessage ?? 'ingrese su contraseña';
        }
        if (additionalValidator != null) return additionalValidator!(value);
        return null;
      },
      onChange: (String? value, bool valid) {
        onChange(value, valid);
      },
    );
  }
}
