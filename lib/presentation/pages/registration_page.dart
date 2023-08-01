import 'package:flutter/material.dart';
import 'package:swc_front/presentation/widgets/layout.dart';
import 'package:swc_front/presentation/forms/registration_form.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double desktopScreen = screenWidth * 0.3;
    double mobileScreen = screenWidth * 0.8;
    double desiredWidth = screenWidth > 800 ? desktopScreen : mobileScreen;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Layout(
        content: Center(
          child: SizedBox(
            width: desiredWidth,
            child: const SingleChildScrollView(
              child: Column(
                children: [
                  RegistrationForm(),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
