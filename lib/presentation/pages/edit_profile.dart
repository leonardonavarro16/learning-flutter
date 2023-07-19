import 'package:flutter/material.dart';
import 'package:swc_front/presentation/widgets/layout.dart';
import 'package:swc_front/presentation/widgets/utils/text_view.dart';
import '../forms/profile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double desktopScreen = screenWidth * 0.3;
    double mobileScreen = screenWidth * 0.8;
    double desiredWidth = screenWidth > 800 ? desktopScreen : mobileScreen;
    AppLocalizations? t = AppLocalizations.of(context);
    if (t == null) throw Exception('AppLocalizations not found');
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Layout(
        content: Center(
          child: SizedBox(
            width: desiredWidth,
            child: Column(children: [
              const SizedBox(
                height: 35,
              ),
              TextView(
                  text: t.myProfileTitleLinkText,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: Colors.white),
              const ProfileForm(),
            ]),
          ),
        ),
      );
    });
  }
}
