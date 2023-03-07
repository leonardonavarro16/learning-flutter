import 'package:flutter/material.dart';
import 'package:swc_front/widgets/layout.dart';
import '../forms/profile.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Layout(
        content: Center(
          child: SizedBox(
            width: constraints.maxWidth * 0.5,
            child: Column(children: const [
              ProfileForm(),
            ]),
          ),
        ),
      );
    });
  }
}
