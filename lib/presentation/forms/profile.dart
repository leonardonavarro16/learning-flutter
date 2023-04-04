import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swc_front/presentation/widgets/utils/email_form_field.dart';
import 'package:swc_front/presentation/widgets/utils/name_form_field.dart';
import 'package:swc_front/presentation/widgets/utils/phone_form_field.dart';
import '../../data/models/user.dart';
import '../../logic/cubits/authentication_cubit.dart';
import '../../logic/states/authentication.dart';
import '../widgets/utils/age_form_field.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key});

  @override
  State<ProfileForm> createState() => _ProfileForm();
}

class _ProfileForm extends State<ProfileForm> {
  String? name;
  int? age;
  String? phoneNumber;
  String? email;

  @override
  void initState() {
    AuthenticationState state = context.read<AuthenticationCubit>().state;
    if (state.authenticationStatus == AuthenticationStatus.success) {
      name = state.user?.name;
      age = state.user?.age;
      phoneNumber = state.user?.phoneNumber;
      email = state.user?.email;
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
        const SizedBox(height: 25),
        EmailFormField(
          onChange: (String? value, bool valid) {
            setState(() => email = valid ? value : null);
          },
        ),
        if (_canShowSubmitButton()) _buildSubmitButton(),
      ],
    );
  }

  bool _canShowSubmitButton() {
    return name != null && age != null && phoneNumber != null;
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 235, 91, 81),
      ),
      onPressed: () {
        User user = _buildUser();
        BlocProvider.of<AuthenticationCubit>(context).update(user);
      },
      child: const Text('Envíar'),
    );
  }

  User _buildUser() {
    return User(
        name: name!, age: age!, phoneNumber: phoneNumber!, email: email!);
  }
}
