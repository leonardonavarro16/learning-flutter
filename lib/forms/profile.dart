import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swc_front/widgets/utils/name_form_field.dart';
import 'package:swc_front/widgets/utils/phone_form_field.dart';
import '../models/user.dart';
import '../models/current_user.dart';
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
  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Column(
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
        AgeFormField(onChanged: (int value) {
          setState(() => age = value);
        }),
        const SizedBox(
          height: 25,
        ),
        PhoneNumberInput(
          onChange: (String value, bool valid) {
            setState(() => phoneNumber = valid ? value : null);
          },
        ),
        const SizedBox(height: 25),
        buildSubmitButton()
      ].whereType<Widget>().toList(),
    );
  }

  Widget? buildSubmitButton() {
    bool showButton = name != null && age != null && phoneNumber != null;
    if (showButton) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 235, 91, 81),
        ),
        onPressed: () {
          User user = _buildUser();
          _context.read<CurrentUser>().update(user);
        },
        child: const Text('Envíar'),
      );
    } else {
      return null;
    }
  }

  User _buildUser() {
    return User(
      name: name!,
      desiredAge: age!,
      phoneNumber: phoneNumber!,
      description: '',
    );
  }
}
