import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swc_front/models/current_user.dart';
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
  String? name;
  int? age;
  String? phoneNumber;
  String? description;
  Uint8List? imageBytes;
  bool initialized = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Container(
        //   color: Theme.of(context).primaryColor,
        //   height: 25,
        // ),
        const SizedBox(
          height: 25,
        ),
        NameFormField(
          fieldValue: context.watch<CurrentUser>().user?.name,
          onChange: (String value, bool valid) {
            setState(() => name = valid ? value : null);
          },
        ),
        const SizedBox(
          height: 25,
        ),
        AgeFormField(
            initialValue: context.watch<CurrentUser>().user?.desiredAge,
            onChanged: (int value) {
              setState(() => age = value);
            }),
        const SizedBox(
          height: 25,
        ),
        PhoneNumberInput(
          fieldValue: context.watch<CurrentUser>().user?.phoneNumber,
          onChange: (String value, bool valid) {
            setState(() => phoneNumber = valid ? value : null);
          },
        ),
        const SizedBox(
          height: 25,
        ),
        DescriptionInput(
          maxLength: 1000,
          onChange: (String value) {
            setState(() => description = value);
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
    );
  }

  Widget? buildSubmitButton() {
    bool showButton = name != null &&
        age != null &&
        phoneNumber != null &&
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
