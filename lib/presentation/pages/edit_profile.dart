import 'package:flutter/material.dart';
import 'package:swc_front/presentation/widgets/layout.dart';
import '../forms/profile.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Layout(
        content: Center(
          child: SizedBox(
            width: constraints.maxWidth * 0.5,
            child: Column(children: const [
              SizedBox(
                height: 25,
              ),
              Text(
                'Edita los datos de tu perfil',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white),
              ),
              ProfileForm(),
            ]),
          ),
        ),
      );
    });
  }
}
