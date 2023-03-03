import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:swc_front/widgets/utils/description_form.dart';
import 'package:swc_front/widgets/utils/name_form_field.dart';
import 'package:swc_front/widgets/utils/phone_form_field.dart';

import '../widgets/utils/age_form_field.dart';
import '../widgets/utils/file2_picker_field.dart';
import '../widgets/utils/file_picker_field.dart';

class AdvertForm extends StatefulWidget {
  const AdvertForm({super.key});
  @override
  _AdvertFormState createState() => _AdvertFormState();
}

class _AdvertFormState extends State<AdvertForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: const [
        SizedBox(
          height: 25,
        ),
        NameFormField(),
        SizedBox(
          height: 25,
        ),
        AgeFormField(),
        SizedBox(
          height: 25,
        ),
        PhoneNumberInput(),
        SizedBox(
          height: 25,
        ),
        DescriptionInput(),
        SizedBox(
          height: 25,
        ),
        FilePickerFieldTwo(),
      ]),
    );
  }
}
