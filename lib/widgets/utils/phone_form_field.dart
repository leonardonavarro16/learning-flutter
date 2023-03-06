import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneNumberInput extends StatelessWidget {
  final Function onChanged;
  const PhoneNumberInput({super.key, required this.onChanged});

  //@override
  //State<StatefulWidget> createState() => _PhoneNumberInputState();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
          prefixIcon: Icon(Icons.phone_android_outlined),
          labelText: '(+57) Ingrese su numero de contacto:',
          filled: true,
          fillColor: Colors.white),
      keyboardType: TextInputType.phone,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10)
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ingrese su numero teléfonico';
        }
        final phoneRegex = RegExp(r'[0-9]');
        if (!phoneRegex.hasMatch(value)) {
          return 'Ingresa un número teléfonico válido';
        }
        return null;
      },
      onChanged: (String value) {
        onChanged(value);
      },
    );
  }
}
