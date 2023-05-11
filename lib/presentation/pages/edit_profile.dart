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
            width: constraints.maxWidth * 0.8,
            child: Column(children: const [
              SizedBox(
                height: 35,
              ),
              Text(
                'Mi perfil',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
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
