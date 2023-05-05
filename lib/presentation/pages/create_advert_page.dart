import 'package:flutter/material.dart';
import 'package:swc_front/presentation/widgets/layout.dart';
import '../forms/advert_form.dart';

class CreateAdvertPage extends StatelessWidget {
  const CreateAdvertPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Layout(
          content: Center(
            child: SizedBox(
              width: constraints.maxWidth * 0.8,
              child: ListView(
                children: [
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 80,
                        width: 80,
                        child: Image.asset('gradient_logo_swc.png'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Nuevo anuncio',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
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
