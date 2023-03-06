import 'package:flutter/material.dart';

class NameFormField extends StatelessWidget {
  final Function onChanged;
  const NameFormField({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
          prefixIcon: Icon(Icons.person),
          filled: true,
          fillColor: Colors.white,
          labelText: 'Ingrese su nombre:'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ingrese su nombre completo';
        }
        final nameRegExp =
            RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
        if (!nameRegExp.hasMatch(value)) {
          return 'Ingrese un nombre válido';
        }
        return null;
      },
      onChanged: (String value) {
        onChanged(value);
      },
    );
  }
}
