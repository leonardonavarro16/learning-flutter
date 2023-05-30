import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'base_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PasswordFormField extends StatelessWidget {
  final void Function(String? value, bool valid) onChange;
  final Function? additionalValidator;
  final String? emptyMessage;
  final String? labelText;
  final void Function(String)? onFieldSubmitted;

  const PasswordFormField({
    super.key,
    required this.onChange,
    this.additionalValidator,
    this.emptyMessage,
    this.labelText,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    AppLocalizations? t = AppLocalizations.of(context);
    if (t == null) throw Exception('AppLocalizations not found');
    return BaseTextFormField(
      decoration: InputDecoration(
        suffixIcon: const Icon(Icons.visibility),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelText: labelText ?? t.passwordLinkText,
        filled: true,
        fillColor: Colors.white,
      ),
      obscureText: true,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return emptyMessage ?? t.enterPasswordLinkText;
        }
        if (additionalValidator != null) return additionalValidator!(value);
        return null;
      },
      onChange: (String? value, bool valid) {
        onChange(value, valid);
      },
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
