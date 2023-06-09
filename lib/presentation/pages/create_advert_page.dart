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
    AppLocalizations? t = AppLocalizations.of(context);
    if (t == null) throw Exception('AppLocalizations not found');
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Layout(
          content: Center(
            child: SizedBox(
              width: constraints.maxWidth * 0.8,
              child: ListView(
                children: [
                  const SizedBox(height: 15.0),
                  Container(
                    alignment: Alignment.topRight,
                    padding: const EdgeInsets.only(top: 3, right: 20),
                    child: SvgPicture.asset(
                      'assets/Logo rojo.svg',
                      height: 55,
                    ),
                  ),
                  const SizedBox(height: 8),
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
