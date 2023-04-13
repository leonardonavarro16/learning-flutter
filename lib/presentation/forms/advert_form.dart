import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swc_front/logic/cubits/authentication_cubit.dart';
import 'package:swc_front/logic/states/adverts.dart';
import 'package:swc_front/logic/states/authentication.dart';
import 'package:swc_front/presentation/widgets/utils/description_form.dart';
import 'package:swc_front/presentation/widgets/utils/name_form_field.dart';
import 'package:swc_front/presentation/widgets/utils/phone_form_field.dart';
import 'package:swc_front/presentation/widgets/utils/snackbarUtil.dart';
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
  final _formKey = GlobalKey<FormState>();
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
    return BlocListener<AdvertsCubit, AdvertsState>(
        listener: (BuildContext context, AdvertsState state) {
          if (state.status == AdvertsStatus.failure) {
            String errorMessage = state.error;
            SnackBarUtil.showSnackBar(
                context,
                icon: const Icon(Icons.error_outline),
                backgroundColor: Colors.red,
                textColor: Colors.black,
                errorMessage);
          }
        },
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                NameFormField(
                  onFieldSubmitted: (_) => _submitForm(),
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
                  onFieldSubmitted: (_) => _submitForm(),
                  initialValue: phoneNumber,
                  onChange: (String? value, bool valid) {
                    setState(() => phoneNumber = valid ? value : null);
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                DescriptionFormField(
                  onFieldSubmitted: (_) => _submitForm(),
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
            )));
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
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZNQZI9chyqtlvn6KNfid_ACsf4O-NiKn9Cw&usqp=CAU');
  }

  void _submitForm() {
    if (_canShowSubmitButton()) {
      Advert advert = _buildAdvert();
      String? token = context.read<AuthenticationCubit>().state.token;
      if (token == null) throw Exception('Token is missing');
      context.read<AdvertsCubit>().createAdvert(advert, token);
    }
  }
}
