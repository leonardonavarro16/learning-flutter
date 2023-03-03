import 'package:flutter/material.dart';
import 'package:swc_front/widgets/layout.dart';
import '../forms/advert_form.dart';

class AdvertFormPage extends StatelessWidget {
  const AdvertFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Layout(
        content: Center(
          child: SizedBox(
            width: constraints.maxWidth * 0.5,
            child: Column(children: const [
              SizedBox(height: 25),
              Text(
                'Rellena el fórmulario para listar tu anuncio',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white),
              ),
              AdvertForm(),
            ]),
          ),
        ),
      );
    });
  }
}
