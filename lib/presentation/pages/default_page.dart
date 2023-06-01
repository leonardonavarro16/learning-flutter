import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swc_front/presentation/widgets/layout.dart';
import 'package:swc_front/presentation/widgets/utils/text_view.dart';
import 'package:swc_front/presentation/router/app_router.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Layout(
      content: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, Routes.indexPage);
              },
              child: SvgPicture.asset(
                'assets/Logo blanco.svg',
                height: 130,
                width: 130,
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            const TextView(
              fontWeight: FontWeight.bold,
              fontSize: 35,
              color: Colors.white,
              text: 'Error 404: not found',
            ),
            const SizedBox(
              height: 35,
            ),
            const TextView(
              color: Colors.white,
              text: 'Oops! The page you are looking for does not exist.',
            ),
            const SizedBox(
              height: 35,
            ),
          ],
        ),
      ),
    );
  }
}
