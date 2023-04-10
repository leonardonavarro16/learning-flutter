import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swc_front/logic/cubits/authentication_cubit.dart';
import 'package:swc_front/logic/states/adverts.dart';
import 'package:swc_front/logic/states/authentication.dart';
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
    AuthenticationState state = context.read<AuthenticationCubit>().state;
    if (state.authenticationStatus == AuthenticationStatus.success) {
      name = state.user?.name;
      age = state.user?.age;
      phoneNumber = state.user?.phoneNumber;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 25,
        ),
        NameFormField(
          initialValue: name,
          onChange: (String? value, bool valid) {
            setState(() => name = valid ? value : null);
          },
        ),
        const SizedBox(
          height: 25,
        ),
        AgeFormField(
            initialValue: age,
            onChange: (int value) {
              setState(() => age = value);
            }),
        const SizedBox(
          height: 25,
        ),
        PhoneFormField(
          initialValue: phoneNumber,
          onChange: (String? value, bool valid) {
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
          onChange: (String? value, bool valid) {
            setState(() => description = valid ? value : null);
          },
        ),
        const SizedBox(
          height: 25,
        ),
        FilePickerField(onChanged: (Uint8List? bytes) {
          setState(() => imageBytes = bytes);
        }),
        const SizedBox(height: 25),
        if (_canShowSubmitButton())
          BlocConsumer<AdvertsCubit, AdvertsState>(
              listener: (BuildContext context, AdvertsState state) {
            if (state.status == AdvertsStatus.success) {
              if (state.nextRoute != null) {
                Navigator.pushNamed(context, state.nextRoute!);
              }
            }
          }, builder: (BuildContext context, AdvertsState state) {
            if (state.status == AdvertsStatus.loading) {
              return const CircularProgressIndicator();
            } else {
              return _buildSubmitButton();
            }
          }),
      ],
    );
  }

  bool _canShowSubmitButton() {
    return name != null &&
        age != null &&
        phoneNumber != null &&
        description != null &&
        description != '' &&
        imageBytes != null;
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 235, 91, 81),
      ),
      onPressed: () {
        Advert advert = _buildAdvert();
        String? token = context.read<AuthenticationCubit>().state.token;
        if (token == null) throw Exception('Token is missing');
        context.read<AdvertsCubit>().createAdvert(advert, token);
      },
      child: const Text('Envíar'),
    );
  }

  Advert _buildAdvert() {
    return Advert(
        description: description!,
        age: age!,
        name: name!,
        phoneNumber: phoneNumber!,
        imageUrl:
            'https://images.unsplash.com/photo-1525609004556-c46c7d6cf023?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=452&q=80');
  }
}
