import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'base_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    AppLocalizations? t = AppLocalizations.of(context);
    if (t == null) throw Exception('AppLocalizations not found');
    return BaseTextFormField(
      fieldValue: initialValue,
      decoration: InputDecoration(
          suffixIcon: const Icon(CupertinoIcons.envelope),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          filled: true,
          fillColor: Colors.white,
          labelText: t.emailLinkText),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return t.emailLinkText;
        }
        final emailRegex = RegExp(r'^[\w-zñ\.]+@([\w-zñ]+\.)+[\w-z]{2,4}$');
        if (!emailRegex.hasMatch(value)) {
          return t.emailLabelLinkText;
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
