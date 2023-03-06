import 'package:flutter/material.dart';
import 'package:swc_front/widgets/utils/description_form.dart';
import 'package:swc_front/widgets/utils/name_form_field.dart';
import 'package:swc_front/widgets/utils/phone_form_field.dart';

import '../widgets/utils/age_form_field.dart';
import '../widgets/utils/file_picker_form_field.dart';

class AdvertForm extends StatefulWidget {
  const AdvertForm({super.key});

  @override
  State<AdvertForm> createState() => _AdvertForm();
}

class _AdvertForm extends State<AdvertForm> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String age = '';
  String phoneNumber = '';
  String description = '';
  String image = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          NameFormField(
            onChanged: (String value) {
              _formKey.currentState!.validate();
              setState(() => name = value);
            },
          ),
          const SizedBox(
            height: 25,
          ),
          const AgeFormField(),
          const SizedBox(
            height: 25,
          ),
          PhoneNumberInput(
            onChanged: (String value) {
              _formKey.currentState!.validate();
              setState(() => phoneNumber = value);
            },
          ),
          const SizedBox(
            height: 25,
          ),
          DescriptionInput(
            onChanged: (String value) {
              _formKey.currentState!.validate();
              setState(() => description = value);
            },
          ),
          const SizedBox(
            height: 25,
          ),
          const FilePickerField(),
          const SizedBox(height: 25),
          buildSubmitButton()
        ].whereType<Widget>().toList(),
      ),
    );
  }

  Widget? buildSubmitButton() {
    bool showButton = _formKey.currentState == null
        ? false
        : _formKey.currentState!.validate();
    if (showButton) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 235, 91, 81),
        ),
        onPressed: () {},
        child: const Text('Envíar'),
      );
    } else {
      return null;
    }
  }
}
