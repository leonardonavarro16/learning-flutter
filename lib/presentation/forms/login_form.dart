import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swc_front/logic/cubits/authentication_cubit.dart';
import 'package:swc_front/logic/states/authentication.dart';
import 'package:swc_front/presentation/widgets/utils/custom_button.dart';
import 'package:swc_front/presentation/widgets/utils/email_form_field.dart';
import 'package:swc_front/presentation/widgets/utils/indicator_progress.dart';
import 'package:swc_front/presentation/widgets/utils/password_form_field.dart';
import 'package:swc_front/presentation/widgets/utils/snackbar_util.dart';

import '../router/app_router.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (BuildContext context, AuthenticationState state) {
        if (state.authenticationStatus == AuthenticationStatus.successLogin) {
          Navigator.pushReplacementNamed(context, Routes.indexPage);
        } else if (state.authenticationStatus ==
            AuthenticationStatus.failureLogin) {
          String errorMessage =
              state.error ?? 'Ocurrió un error. Por favor inténtalo de nuevo.';
          SnackBarUtil.showSnackBar(
              context,
              icon: const Icon(Icons.error_outline),
              backgroundColor: Colors.red,
              errorMessage);
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 15),
            EmailFormField(
              onChange: (String? value, bool valid) {
                if (valid) setState(() => email = value);
              },
              onFieldSubmitted: (_) => _submitForm(),
            ),
            const SizedBox(
              height: 15,
            ),
            PasswordFormField(
                onFieldSubmitted: (_) => _submitForm(),
                onChange: (String? value, bool valid) {
                  if (valid) setState(() => password = value);
                }),
            const SizedBox(
              height: 25,
            ),
            if (_canBuildSubmitButton()) _buildSubmitButton(),
            const SizedBox(height: 15)
          ],
        ),
      ),
    );
  }

  bool _canBuildSubmitButton() {
    return email != null && password != null;
  }

  Widget _buildSubmitButton() {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (BuildContext context, AuthenticationState state) {
        if (state.authenticationStatus == AuthenticationStatus.loading) {
          return const CustomIndicatorProgress();
        } else {
          return CustomButton(text: 'Ingresar', onPressed: _submitForm);
        }
      },
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context.read<AuthenticationCubit>().login(email!, password!);
    }
  }
}
