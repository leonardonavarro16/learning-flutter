import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swc_front/widgets/utils/base_text_form_field.dart';

class DescriptionInput extends StatelessWidget {
  final Function onChanged;
  final int? maxLength;
  const DescriptionInput({super.key, required this.onChanged, this.maxLength});

  @override
  Widget build(BuildContext context) {
    return BaseTextFormField(
      maxLines: 5,
      minLines: 1,
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
      onChange: (String value) {
        onChanged(value);
      },
    );
  }
}
