import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swc_front/presentation/widgets/layout.dart';
import 'package:swc_front/presentation/widgets/utils/text_view.dart';
import '../forms/advert_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateAdvertPage extends StatelessWidget {
  const CreateAdvertPage({Key? key});

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
              child: ListView(
                children: [
                  const SizedBox(height: 50.0),
                  TextView(
                    text: t.newAdvertTitleLinkText,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 15),
                  const AdvertForm(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
