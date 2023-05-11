import 'package:flutter/material.dart';
import 'package:swc_front/presentation/widgets/utils/text_view.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
            const Color.fromARGB(255, 235, 91, 81)),
      ),
      child: const TextView(text: 'Enviar'),
    );
  }
}
