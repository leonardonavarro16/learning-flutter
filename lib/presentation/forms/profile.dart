import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swc_front/presentation/router/app_router.dart';
import 'package:swc_front/presentation/widgets/utils/alert_dialog_custom.dart';
import 'package:swc_front/presentation/widgets/utils/custom_button.dart';
import 'package:swc_front/presentation/widgets/utils/date_picker.dart';
import 'package:swc_front/presentation/widgets/utils/email_form_field.dart';
import 'package:swc_front/presentation/widgets/utils/image_picker_button.dart';
import 'package:swc_front/presentation/widgets/utils/indicator_progress.dart';
import 'package:swc_front/presentation/widgets/utils/name_form_field.dart';
import 'package:swc_front/presentation/widgets/utils/phone_form_field.dart';
import 'package:swc_front/presentation/widgets/utils/snackbar_util.dart';
import 'package:swc_front/presentation/widgets/utils/text_view.dart';
import '../../data/models/user.dart';
import '../../logic/cubits/authentication_cubit.dart';
import '../../logic/states/authentication.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key});

  @override
  State<ProfileForm> createState() => _ProfileForm();
}

class _ProfileForm extends State<ProfileForm> {
  String? id;
  String? name;
  String? phoneNumber;
  String? email;
  DateTime? birthdate;
  Uint8List? image;

  @override
  void initState() {
    AuthenticationState state = context.read<AuthenticationCubit>().state;
    if (state.isLoggedIn()) {
      id = state.user?.id;
      name = state.user?.name;
      phoneNumber = state.user?.phoneNumber;
      email = state.user?.email;
      birthdate = state.user?.birthdate;
      image = state.user?.image;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isLogged = context.watch<AuthenticationCubit>().isLogged();
    User? currentUser = context.watch<AuthenticationCubit>().state.user;
    Uint8List? userImage = currentUser?.image;

    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (BuildContext context, AuthenticationState state) {
        if (state.authenticationStatus == AuthenticationStatus.updateSuccess) {
          Navigator.pushReplacementNamed(context, Routes.indexPage);
        } else if (state.authenticationStatus ==
            AuthenticationStatus.updateFailure) {
          String errorMessage =
              state.error ?? 'Ocurrió un error al actualizar el usuario';
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
          ImagePickerButton(
            initialValue: image ?? userImage,
            onChanged: (Uint8List? bytes) {
              setState(() => image = bytes);
            },
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
          DatePickerField(
            initialValue: birthdate,
            onChange: (int value, DateTime selectedBirthdate) {
              setState(() => birthdate = selectedBirthdate);
            },
          ),
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
          const SizedBox(height: 10),
          Align(alignment: Alignment.centerRight, child: _buildLogoutButton()),
        ],
      ),
    );
  }

  // bool _canShowSubmitButton() {
  //   return name != null && age != null && phoneNumber != null;
  // }

  Widget _buildSubmitButton() {
    AppLocalizations? t = AppLocalizations.of(context);
    if (t == null) throw Exception('AppLocalizations not found');

    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (BuildContext context, AuthenticationState state) {
      if (state.authenticationStatus == AuthenticationStatus.loading) {
        return const CustomIndicatorProgress();
      } else {
        return CustomButton(
          text: t.editButtonLinkText,
          onPressed: () {
            User user = _buildUser();
            BlocProvider.of<AuthenticationCubit>(context).update(user);
          },
        );
      }
    });
  }

  User _buildUser() {
    return User(
      id: id,
      name: name!,
      phoneNumber: phoneNumber!,
      email: email!,
      birthdate: birthdate!,
      image: image!,
    );
  }

  Widget _buildLogoutButton() {
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          const Color(0xFFFF0000),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      icon: const Icon(Icons.logout_rounded),
      label: const TextView(
        text: 'Logout',
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      onPressed: () {
        showDialog(
            context: context,
            builder: (_) {
              return CustomAlertDialog(
                hasButton: false,
                header: const Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    TextView(
                      text: 'Are you sure to Log out?',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 15,
                    )
                  ],
                ),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton(
                      height: 40,
                      width: 100,
                      text: 'Cancel',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    CustomButton(
                      height: 40,
                      width: 100,
                      text: 'Logout',
                      onPressed: () {
                        BlocProvider.of<AuthenticationCubit>(context).logout();
                        Navigator.pushReplacementNamed(
                            context, Routes.indexPage);
                      },
                    ),
                  ],
                ),
              );
            });
      },
    );
  }
}
