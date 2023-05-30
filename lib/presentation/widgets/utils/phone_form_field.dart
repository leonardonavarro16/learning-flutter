import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swc_front/presentation/widgets/utils/base_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    AppLocalizations? t = AppLocalizations.of(context);
    if (t == null) throw Exception('AppLocalizations not found');
    return BaseTextFormField(
        fieldValue: initialValue,
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            // prefixIcon: Icon(Icons.phone_android_outlined),
            labelText: t.phonLinkText,
            filled: true,
            fillColor: Colors.white),
        keyboardType: TextInputType.phone,
        onChange: onChange,
        onFieldSubmitted: onFieldSubmitted,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return t.phoneLabelLinkText;
          }
          final phoneRegex = RegExp(r'[0-9]');
          if (!phoneRegex.hasMatch(value)) {
            return t.phoneValidNumberLinkText;
          }
          if (value.length < 10) {
            return t.phoneValidDigitsLinkText;
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
