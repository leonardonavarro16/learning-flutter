import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swc_front/logic/cubits/user.dart';
import 'package:swc_front/logic/states/user.dart';
import 'package:swc_front/presentation/router/app_router.dart';
import 'package:swc_front/presentation/widgets/utils/custom_button.dart';
import 'package:swc_front/presentation/widgets/utils/email_form_field.dart';
import 'package:swc_front/presentation/widgets/utils/indicator_progress.dart';
import 'package:swc_front/presentation/widgets/utils/name_form_field.dart';
import 'package:swc_front/presentation/widgets/utils/phone_form_field.dart';
import 'package:swc_front/presentation/widgets/utils/snackbar_util.dart';
import 'package:swc_front/presentation/widgets/utils/text_view.dart';
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
    bool isLogged = context.watch<AuthenticationCubit>().isLogged();
    return BlocListener<UserCubit, UserState>(
        listener: (BuildContext context, UserState state) {
          if (state.userStatus == UserStatus.success) {
            context.read<AuthenticationCubit>().setUser(state.user!);
            Navigator.pushReplacementNamed(context, Routes.indexPage);
          } else if (state.userStatus == UserStatus.failure) {
            String errorMessage =
                state.error ?? 'Ocurrió un error al actualizar el usuario';
            SnackBarUtil.showSnackBar(
                context,
                icon: const Icon(Icons.error_outline),
                backgroundColor: Colors.red,
                errorMessage);
          }
        },
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            if (isLogged)
              TextView(
                text: '$name',
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            const SizedBox(
              height: 25,
            ),
            const CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage('avatar_preview_two.jpg'),
            ),
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
              height: 15,
            ),
            AgeFormField(
                ageToShow: '$age años',
                initialValue: age,
                onChange: (int value) {
                  setState(() => age = value);
                }),
            const SizedBox(
              height: 15,
            ),
            PhoneFormField(
              initialValue: phoneNumber,
              onChange: (String? value, bool valid) {
                setState(() => phoneNumber = valid ? value : null);
              },
            ),
            const SizedBox(
              height: 15,
            ),
            EmailFormField(
              initialValue: email,
              onChange: (String? value, bool valid) {
                setState(() => email = valid ? value : null);
              },
            ),
            const SizedBox(
              height: 15,
            ),
            // if (_canShowSubmitButton())
            _buildSubmitButton(),
          ],
        ));
  }

  // bool _canShowSubmitButton() {
  //   return name != null && age != null && phoneNumber != null;
  // }

  Widget _buildSubmitButton() {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (BuildContext context, AuthenticationState state) {
      if (state.authenticationStatus == AuthenticationStatus.loading) {
        return const CustomIndicatorProgress();
      } else {
        return CustomButton(
          text: 'Editar',
          onPressed: () {
            User user = _buildUser();
            String token =
                BlocProvider.of<AuthenticationCubit>(context).state.token!;

            user.id =
                BlocProvider.of<AuthenticationCubit>(context).state.user!.id;
            BlocProvider.of<UserCubit>(context).update(user, token);
          },
        );
      }
    });
  }

  User _buildUser() {
    return User(
      name: name!,
      age: age!,
      phoneNumber: phoneNumber!,
      email: email!,
    );
  }
}
