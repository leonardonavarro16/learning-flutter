import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:swc_front/presentation/router/app_router.dart';
import 'package:swc_front/logic/states/current_user.dart';
import 'package:swc_front/presentation/widgets/utils/description_form.dart';
import 'package:swc_front/presentation/widgets/utils/name_form_field.dart';
import 'package:swc_front/presentation/widgets/utils/phone_form_field.dart';
import '../../data/models/advert.dart';
import '../../data/models/user.dart';
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
    if (!initialized) _initFields();
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
          initialValue: context.watch<CurrentUserState>().user?.name,
          onChange: (String value, bool valid) {
            setState(() => name = valid ? value : null);
          },
        ),
        const SizedBox(
          height: 25,
        ),
        AgeFormField(
            initialValue: context.watch<CurrentUserState>().user?.desiredAge,
            onChanged: (int value) {
              setState(() => age = value);
            }),
        const SizedBox(
          height: 25,
        ),
        PhoneFormField(
          initialValue: context.watch<CurrentUserState>().user?.phoneNumber,
          onChange: (String value, bool valid) {
            setState(() => phoneNumber = valid ? value : null);
          },
        ),
        const SizedBox(
          height: 25,
        ),
        DescriptionFormField(
          maxLines: 5,
          minLines: 1,
          maxLength: 1000,
          onChange: (String value) {
            setState(() => description = value);
          },
        ),
        const SizedBox(
          height: 25,
        ),
        FilePickerField(onChanged: (Uint8List? bytes) {
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
        description != '' &&
        imageBytes != null;
    if (showButton) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 235, 91, 81),
        ),
        onPressed: () {
          Advert advert = _buildAdvert();
          //todo: llamar a context.read<AdvertsCubit>().createAdvert(advert);
          Navigator.pushNamed(context, Routes.indexPage);
        },
        child: const Text('Envíar'),
      );
    } else {
      return null;
    }
  }

  void _initFields() {
    setState(() {
      initialized = true;
      name = context.watch<CurrentUserState>().user?.name;
      age = context.watch<CurrentUserState>().user?.desiredAge ?? 18;
      phoneNumber = context.watch<CurrentUserState>().user?.phoneNumber;
    });
  }

  Advert _buildAdvert() {
    User user = _buildUser();
    return Advert(
      image: Image.memory(imageBytes!),
      user: user,
      description: description!,
    );
  }

  User _buildUser() {
    return User(name: name!, desiredAge: age!, phoneNumber: phoneNumber!);
  }
}
