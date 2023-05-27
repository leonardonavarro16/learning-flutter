import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swc_front/presentation/widgets/utils/base_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DescriptionFormField extends StatelessWidget {
  final void Function(String?, bool) onChange;
  final int? maxLength;
  final int maxLines;
  final int? minLines;
  final void Function(String)? onFieldSubmitted;

  const DescriptionFormField(
      {super.key,
      required this.onChange,
      this.onFieldSubmitted,
      this.maxLength,
      this.maxLines = 1,
      this.minLines});

  @override
  Widget build(BuildContext context) {
    AppLocalizations? t = AppLocalizations.of(context);
    if (t == null) throw Exception('AppLocalizations not found');
    return BaseTextFormField(
      maxLines: maxLines,
      minLines: maxLines,
      decoration: InputDecoration(
          // prefixIcon: Icon(Icons.person_add_alt_outlined),
          border: const OutlineInputBorder(),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          filled: true,
          fillColor: Colors.white,
          labelText: t.descriptionLabelLinkText),
      inputFormatters: maxLength == null
          ? null
          : <TextInputFormatter>[LengthLimitingTextInputFormatter(maxLength)],
      onChange: (String? value, bool valid) {
        onChange(value, valid);
      },
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
