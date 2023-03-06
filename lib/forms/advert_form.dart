import 'dart:typed_data';
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
  String? name;
  String? age;
  String? phoneNumber;
  String? description;
  Uint8List? imageBytes;

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
            onChange: (String value, bool valid) {
              setState(() => name = valid ? value : null);
            },
          ),
          const SizedBox(
            height: 25,
          ),
          // pasar onchange
          AgeFormField(onChanged: (String value, bool valid) {
            setState(() => age = valid ? value : null);
          }),
          const SizedBox(
            height: 25,
          ),
          PhoneNumberInput(
            onChange: (String value, bool valid) {
              setState(() => phoneNumber = valid ? value : null);
            },
          ),
          const SizedBox(
            height: 25,
          ),
          DescriptionInput(
            maxLength: 1000,
            onChanged: (String value, bool valid) {
              setState(() => description = valid ? value : null);
            },
          ),
          const SizedBox(
            height: 25,
          ),
          FilePickerField(onChanged: (Uint8List bytes) {
            setState(() => imageBytes = bytes);
          }),
          const SizedBox(height: 25),
          buildSubmitButton()
        ].whereType<Widget>().toList(),
      ),
    );
  }

  Widget? buildSubmitButton() {
    bool showButton = name != null &&
        age != null &&
        description != null &&
        imageBytes != null;
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
