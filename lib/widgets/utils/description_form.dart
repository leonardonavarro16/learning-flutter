import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DescriptionInput extends StatelessWidget {
  final Function onChanged;
  const DescriptionInput({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 5,
      minLines: 1,
      decoration: const InputDecoration(
          prefixIcon: Icon(Icons.person_add_alt_outlined),
          border: OutlineInputBorder(),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          //contentPadding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
          //contentPadding: EdgeInsets.symmetric(vertical: 100),
          filled: true,
          fillColor: Colors.white,
          labelText: 'Ingrese una descripción: (max. 100 caracteres)'),
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(1000)
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ingrese su descripción';
        }
        return null;
      },
      onChanged: (String value) {
        onChanged(value);
      },
    );
  }
}
