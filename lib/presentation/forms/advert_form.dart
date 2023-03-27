import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swc_front/logic/cubits/authentication_cubit.dart';
import 'package:swc_front/logic/states/current_user.dart';
import 'package:swc_front/presentation/router/app_router.dart';
import 'package:swc_front/presentation/widgets/utils/description_form.dart';
import 'package:swc_front/presentation/widgets/utils/name_form_field.dart';
import 'package:swc_front/presentation/widgets/utils/phone_form_field.dart';
import '../../data/models/advert.dart';
import '../../logic/cubits/adverts.dart';
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
  void initState() {
    UserState state = context.read<AuthenticationCubit>().state;
    if (state.userStatus == UserStatus.success) {
      name = state.user.name;
      age = state.user.desiredAge;
      phoneNumber = state.user.phoneNumber;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // if (!initialized) _initFields(); Feature: CurrentUser
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
          initialValue: name,
          onChange: (String value, bool valid) {
            setState(() => name = valid ? value : null);
          },
        ),
        const SizedBox(
          height: 25,
        ),
        AgeFormField(
            initialValue: age,
            onChanged: (int value) {
              setState(() => age = value);
            }),
        const SizedBox(
          height: 25,
        ),
        PhoneFormField(
          initialValue: phoneNumber,
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
          context.read<AdvertsCubit>().createAdvert(advert);
          Navigator.pushNamed(context, Routes.indexPage);
        },
        child: const Text('Envíar'),
      );
    } else {
      return null;
    }
  }

  // void _initFields() { Feature: CurrentUser
  //   setState(() {
  //     initialized = true;
  //     name = context.watch<CurrentUserState>().user?.name;
  //     age = context.watch<CurrentUserState>().user?.desiredAge ?? 18;
  //     phoneNumber = context.watch<CurrentUserState>().user?.phoneNumber;
  //   });
  // }

  Advert _buildAdvert() {
    return Advert(
        description: description!,
        desiredAge: age!,
        name: name!,
        phoneNumber: phoneNumber!,
        imageUrl:
            'https://images.unsplash.com/photo-1525609004556-c46c7d6cf023?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=452&q=80');
  }
}
