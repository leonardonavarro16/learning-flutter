import 'package:flutter/material.dart';

class AgeFormField extends StatefulWidget {
  const AgeFormField({super.key});

  @override
  State<StatefulWidget> createState() => _SliderInputState();
}

class _SliderInputState extends State<AgeFormField> {
  double sliderValue = 18;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Selecciona tu edad:',
          style: TextStyle(color: Colors.white),
        ),
        Slider(
          value: sliderValue,
          min: 18,
          max: 65,
          divisions: 47,
          label: sliderValue.toString(),
          onChanged: (double value) {
            setState(() {
              sliderValue = value;
            });
          },
        )
      ],
    );
  }
}
