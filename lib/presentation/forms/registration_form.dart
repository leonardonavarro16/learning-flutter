import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swc_front/data/models/user.dart';
import 'package:swc_front/logic/cubits/user.dart';
import 'package:swc_front/logic/states/user.dart';
import 'package:swc_front/presentation/router/app_router.dart';
import 'package:swc_front/presentation/widgets/utils/custom_button.dart';
import 'package:swc_front/presentation/widgets/utils/date_picker.dart';
import 'package:swc_front/presentation/widgets/utils/email_form_field.dart';
import 'package:swc_front/presentation/widgets/utils/indicator_progress.dart';
import 'package:swc_front/presentation/widgets/utils/name_form_field.dart';
import 'package:swc_front/presentation/widgets/utils/password_form_field.dart';
import 'package:swc_front/presentation/widgets/utils/phone_form_field.dart';
import 'package:swc_front/presentation/widgets/utils/snackbar_util.dart';
import '../../logic/cubits/authentication_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  int? age;
  String? phoneNumber;
  String? email;
  String? password;
  String? confirmPassword;
  DateTime? birthdate;
  Uint8List? image;

  @override
  Widget build(BuildContext context) {
    AppLocalizations? t = AppLocalizations.of(context);
    if (t == null) throw Exception('AppLocalizations not found');
    return BlocListener<UserCubit, UserState>(
      listener: (BuildContext context, UserState state) {
        if (state.userStatus == UserStatus.createSuccess) {
          context.read<AuthenticationCubit>().login(email!, password!);
          Navigator.pushReplacementNamed(context, Routes.indexPage);
        } else if (state.userStatus == UserStatus.createFailure) {
          String errorMessage =
              state.error ?? 'Ocurrió un error. Por favor inténtalo de nuevo.';

          SnackBarUtil.showSnackBar(
            context,
            icon: const Icon(Icons.error_outline),
            backgroundColor: const Color(0xFFFF0000),
            errorMessage,
          );
        }
      },
      child: Column(
        children: [
          SizedBox(
            height: 175,
            width: 175,
            child: SvgPicture.asset(
              'assets/Logo blanco.svg',
            ),
          ),
          Form(
            key: _formKey,
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  NameFormField(
                    onFieldSubmitted: (_) => _submitForm(),
                    onChange: (String? value, bool valid) {
                      setState(() => name = valid ? value : null);
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  EmailFormField(
                    onFieldSubmitted: (_) => _submitForm(),
                    onChange: (String? value, bool valid) {
                      setState(() => email = valid ? value : null);
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  PhoneFormField(
                    onFieldSubmitted: (_) => _submitForm(),
                    onChange: (String? value, bool valid) {
                      setState(() => phoneNumber = valid ? value : null);
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  DatePickerField(
                    onChange: (int value, DateTime selectedBirthdate) {
                      _setAge(value);
                      _setBirthdate(selectedBirthdate);
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  PasswordFormField(
                    onFieldSubmitted: (_) => _submitForm(),
                    onChange: (String? value, bool valid) {
                      setState(() => password = valid ? value : null);
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  PasswordFormField(
                    onFieldSubmitted: (_) => _submitForm(),
                    labelText: t.confirmPasswordLinkText,
                    emptyMessage: t.enterConfirmPasswordLinkText,
                    additionalValidator: (String? value) {
                      if (value != password) {
                        return t.passwordDoesNotMatchLinkText;
                      }
                      return null;
                    },
                    onChange: (String? value, bool valid) {
                      setState(() => confirmPassword = valid ? value : null);
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  if (_canBuildSubmitButton()) _buildSubmitButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _canBuildSubmitButton() {
    return name != null &&
        birthdate != null &&
        phoneNumber != null &&
        password != null &&
        confirmPassword != null &&
        email != null;
  }

  void _setAge(int value) {
    setState(() => age = value);
  }

  void _setBirthdate(DateTime selectedBirthdate) {
    setState(() => birthdate = selectedBirthdate);
  }

  Widget _buildSubmitButton() {
    AppLocalizations? t = AppLocalizations.of(context);
    if (t == null) throw Exception('AppLocalizations not found');
    return BlocBuilder<UserCubit, UserState>(
      builder: (BuildContext context, UserState state) {
        if (state.userStatus == UserStatus.loading) {
          return const CustomIndicatorProgress();
        } else {
          return CustomButton(
              text: t.createUserButtonLinkText, onPressed: _submitForm);
        }
      },
    );
  }

  User _buildUser() {
    return User(
      name: name!,
      phoneNumber: phoneNumber!,
      email: email!,
      birthdate: birthdate!,
      image: image!,
    );
  }

  void _setDefaultImage() async {
    ByteData byteData = await rootBundle.load('assets/user_default1.jpg');
    setState(() {
      image = byteData.buffer.asUint8List();
    });
  }

  void _submitForm() {
    _setDefaultImage();
    User user = _buildUser();

    context.read<UserCubit>().create(user, password!);
  }
}
