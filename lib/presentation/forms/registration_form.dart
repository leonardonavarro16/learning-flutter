import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swc_front/data/models/user.dart';
import 'package:swc_front/logic/cubits/authentication_cubit.dart';
import 'package:swc_front/presentation/widgets/utils/age_form_field.dart';
import 'package:swc_front/presentation/widgets/utils/email_form_field.dart';
import 'package:swc_front/presentation/widgets/utils/name_form_field.dart';
import 'package:swc_front/presentation/widgets/utils/password_form_field.dart';
import 'package:swc_front/presentation/widgets/utils/phone_form_field.dart';

import '../../logic/states/authentication.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  String? name;
  int? age;
  String? phoneNumber;
  String? email;
  String? password;
  String? confirmPassword;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      const SizedBox(
        height: 15,
      ),
      NameFormField(onChange: (String? value, bool valid) {
        setState(() => name = valid ? value : null);
      }),
      const SizedBox(
        height: 15,
      ),
      AgeFormField(onChange: (int value) {
        setState(() => age = value);
      }),
      const SizedBox(
        height: 15,
      ),
      PhoneFormField(onChange: (String? value, bool valid) {
        setState(() => phoneNumber = valid ? value : null);
      }),
      const SizedBox(
        height: 15,
      ),
      EmailFormField(
        onChange: (String? value, bool valid) {
          setState(() => email = valid ? value : null);
        },
      ),
      const SizedBox(
        height: 15,
      ),
      PasswordFormField(
        onChange: (String? value, bool valid) {
          setState(() => password = valid ? value : null);
        },
      ),
      const SizedBox(
        height: 15,
      ),
      PasswordFormField(
        labelText: 'Confirmar contraseña',
        emptyMessage: 'ingrese su contraseña de confirmacion',
        additionalValidator: (String? value) {
          if (value != password) {
            return 'La contraseña no coincide ';
          }
          return null;
        },
        onChange: (String? value, bool valid) {
          setState(() => confirmPassword = valid ? value : null);
        },
      ),
      const SizedBox(
        height: 12,
      ),
      if (_canBuildSubmitButton()) _buildSubmitButton(),
    ]));
  }

  bool _canBuildSubmitButton() {
    return name != null &&
        age != null &&
        phoneNumber != null &&
        email != null &&
        password != null &&
        confirmPassword != null;
  }

  Widget _buildSubmitButton() {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (BuildContext context, AuthenticationState state) {
        if (state.authenticationStatus == AuthenticationStatus.loading) {
          return const CircularProgressIndicator();
        } else if (state.authenticationStatus == AuthenticationStatus.failure) {
          return Text(state.error ?? 'Error',
              style: const TextStyle(color: Colors.red));
        } else if (state.authenticationStatus == AuthenticationStatus.success) {
          return const Text('done jajaja', style: TextStyle(color: Colors.red));
        } else if (state.authenticationStatus == AuthenticationStatus.initial) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 235, 91, 81),
            ),
            onPressed: () {
              User user = _buildUser();
              print(user);
              context.read<AuthenticationCubit>().create(user, password!);
            },
            child: const Text('Submit'),
          );
        } else {
          throw Exception('Unknown authentication status');
        }
      },
    );
  }

  _buildUser() {
    return User(
      name: name!,
      age: age!,
      phoneNumber: phoneNumber!,
      email: email!,
      // password: confirmPassword!
    );
  }
}
