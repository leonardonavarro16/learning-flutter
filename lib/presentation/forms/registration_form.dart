import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swc_front/data/models/user.dart';
import 'package:swc_front/logic/cubits/user.dart';
import 'package:swc_front/logic/states/user.dart';
import 'package:swc_front/presentation/router/app_router.dart';
import 'package:swc_front/presentation/widgets/utils/age_form_field.dart';
import 'package:swc_front/presentation/widgets/utils/custom_button.dart';
import 'package:swc_front/presentation/widgets/utils/date_picker.dart';
import 'package:swc_front/presentation/widgets/utils/email_form_field.dart';
import 'package:swc_front/presentation/widgets/utils/indicator_progress.dart';
import 'package:swc_front/presentation/widgets/utils/name_form_field.dart';
import 'package:swc_front/presentation/widgets/utils/password_form_field.dart';
import 'package:swc_front/presentation/widgets/utils/phone_form_field.dart';
import 'package:swc_front/presentation/widgets/utils/snackbar_util.dart';
import '../../logic/cubits/authentication_cubit.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

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

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (BuildContext context, UserState state) {
        if (state.userStatus == UserStatus.success) {
          context
              .read<AuthenticationCubit>()
              .login(state.user!.email, password!);
          Navigator.pushReplacementNamed(context, Routes.indexPage);
        } else if (state.userStatus == UserStatus.failure) {
          String errorMessage =
              state.error ?? 'Ocurrió un error. Por favor inténtalo de nuevo.';

          SnackBarUtil.showSnackBar(
              context,
              icon: const Icon(Icons.error_outline),
              backgroundColor: Colors.red,
              errorMessage);
        }
      },
      child: Column(
        children: [
          SizedBox(
            height: 175,
            width: 175,
            child: Image.asset('white_logo_swc.png'),
          ),
          Form(
              key: _formKey,
              child: Center(
                  child: Column(children: [
                const SizedBox(
                  height: 15,
                ),
                NameFormField(
                    onFieldSubmitted: (_) => _submitForm(),
                    onChange: (String? value, bool valid) {
                      setState(() => name = valid ? value : null);
                    }),
                const SizedBox(
                  height: 15,
                ),

                const DatePickerField(),
                const SizedBox(height: 30),
                AgeFormField(onChange: (int value) {
                  setState(() => age = value);
                }),
                const SizedBox(
                  height: 15,
                ),
                PhoneFormField(
                    onFieldSubmitted: (_) => _submitForm(),
                    onChange: (String? value, bool valid) {
                      setState(() => phoneNumber = valid ? value : null);
                    }),
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
                  height: 15,
                ),
                // if (_canBuildSubmitButton())
                _buildSubmitButton(),
              ]))),
        ],
      ),
    );
  }

  // bool _canBuildSubmitButton() {
  //   return name != null &&
  //       age != null &&
  //       phoneNumber != null &&
  //       email != null &&
  //       password != null &&
  //       confirmPassword != null;
  // }

  Widget _buildSubmitButton() {
    return BlocBuilder<UserCubit, UserState>(
      builder: (BuildContext context, UserState state) {
        if (state.userStatus == UserStatus.loading) {
          return const CustomIndicatorProgress();
        } else {
          return CustomButton(text: 'Registrate', onPressed: _submitForm);
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

  void _submitForm() {
    User user = _buildUser();
    context.read<UserCubit>().create(user, password!);
  }
}
