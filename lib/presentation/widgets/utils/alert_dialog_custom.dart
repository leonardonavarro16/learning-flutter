import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swc_front/presentation/widgets/utils/text_view.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black.withOpacity(0.8),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      title: const TextView(
        fontWeight: FontWeight.bold,
        color: Color(0xFFFF0000),
        text: 'Número de teléfono copiado',
      ),
      content: const TextView(
        color: Colors.white,
        text: 'El número de teléfono se ha copiado al portapapeles.',
      ),
      // actions: [
      //   CustomButton(
      //     borderRadius: 15,
      //     text: 'Aceptar',
      //     onPressed: () {
      //       Navigator.of(context).pop();
      //     },
      //   ),
      // ],
    );
  }
}
