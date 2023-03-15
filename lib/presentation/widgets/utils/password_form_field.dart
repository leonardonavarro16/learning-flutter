import 'package:flutter/material.dart';

class PasswordFormField extends StatelessWidget {
  final Function onChanged;
  final Function? additionalValidator;
  final String? emptyMessage;
  final String? labelText;

  const PasswordFormField({
    super.key,
    required this.onChanged,
    this.additionalValidator,
    this.emptyMessage,
    this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
      onChanged: (String value) {
        onChanged(value);
      },
    );
  }
}
