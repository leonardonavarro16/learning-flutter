import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swc_front/widgets/utils/base_text_form_field.dart';

class PhoneNumberInput extends StatelessWidget {
  final Function onChange;
  const PhoneNumberInput({super.key, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return BaseTextFormField(
        decoration: const InputDecoration(
            prefixIcon: Icon(Icons.phone_android_outlined),
            labelText: '(+57) Ingrese su numero de contacto:',
            filled: true,
            fillColor: Colors.white),
        keyboardType: TextInputType.phone,
        onChange: onChange,
        getErrorText: (value) {
          if (value == null || value.isEmpty) {
            return 'Ingrese su numero teléfonico';
          }
          final phoneRegex = RegExp(r'[0-9]');
          if (!phoneRegex.hasMatch(value)) {
            return 'Ingresa un número teléfonico válido';
          }
          return null;
        },
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(10)
        ]);
  }
}
