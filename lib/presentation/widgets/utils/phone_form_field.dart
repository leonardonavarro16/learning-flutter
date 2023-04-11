import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swc_front/presentation/widgets/utils/base_text_form_field.dart';

class PhoneFormField extends StatelessWidget {
  final void Function(String?, bool) onChange;
  final String? initialValue;
  final void Function(String)? onFieldSubmitted;
  const PhoneFormField(
      {super.key,
      required this.onChange,
      this.initialValue,
      this.onFieldSubmitted});

  @override
  Widget build(BuildContext context) {
    return BaseTextFormField(
        fieldValue: initialValue,
        decoration: const InputDecoration(
            prefixIcon: Icon(Icons.phone_android_outlined),
            labelText: '(+57) Ingrese su numero de contacto:',
            filled: true,
            fillColor: Colors.white),
        keyboardType: TextInputType.phone,
        onChange: onChange,
        onFieldSubmitted: onFieldSubmitted,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Ingrese su numero teléfonico';
          }
          final phoneRegex = RegExp(r'[0-9]');
          if (!phoneRegex.hasMatch(value)) {
            return 'Ingresa un número teléfonico válido';
          }
          if (value.length < 10) {
            return 'El número telefónico debe tener al menos 10 dígitos';
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
