import 'package:flutter/material.dart';

import 'base_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PasswordFormField extends StatefulWidget {
  final void Function(String? value, bool valid) onChange;
  final Function? additionalValidator;
  final String? emptyMessage;
  final String? labelText;
  final void Function(String)? onFieldSubmitted;

  const PasswordFormField({
    Key? key,
    required this.onChange,
    this.additionalValidator,
    this.emptyMessage,
    this.labelText,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  _PasswordFormFieldState createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    AppLocalizations? t = AppLocalizations.of(context);
    if (t == null) throw Exception('AppLocalizations not found');
    return BaseTextFormField(
      decoration: InputDecoration(
        prefixIcon: InkWell(
          onTap: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          child: Icon(
              color: Colors.red,
              obscureText ? Icons.visibility : Icons.visibility_off),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelText: widget.labelText ?? t.passwordLinkText,
        filled: true,
        fillColor: Colors.white,
      ),
      obscureText: obscureText,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return widget.emptyMessage ?? t.enterPasswordLinkText;
        }
        if (widget.additionalValidator != null) {
          return widget.additionalValidator!(value);
        }
        return null;
      },
      onChange: (String? value, bool valid) {
        widget.onChange(value, valid);
      },
      onFieldSubmitted: widget.onFieldSubmitted,
    );
  }
}
