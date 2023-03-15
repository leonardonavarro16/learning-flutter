import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swc_front/presentation/widgets/utils/base_text_form_field.dart';

class DescriptionFormField extends StatelessWidget {
  final Function onChange;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  const DescriptionFormField(
      {super.key,
      required this.onChange,
      this.maxLength,
      this.maxLines,
      this.minLines});

  @override
  Widget build(BuildContext context) {
    return BaseTextFormField(
      maxLines: maxLines,
      minLines: maxLines,
      decoration: const InputDecoration(
          prefixIcon: Icon(Icons.person_add_alt_outlined),
          border: OutlineInputBorder(),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          filled: true,
          fillColor: Colors.white,
          labelText: 'Ingrese una descripción: (max. 100 caracteres)'),
      inputFormatters: maxLength == null
          ? null
          : <TextInputFormatter>[LengthLimitingTextInputFormatter(maxLength)],
      onChange: (String value, bool valid) {
        onChange(value);
      },
    );
  }
}