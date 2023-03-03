import 'package:flutter/material.dart';

class AgeFormField extends StatefulWidget {
  final int minAge;
  final int maxAge;
  final String label;
  const AgeFormField({super.key, this.minAge=18, this.maxAge=65, this.label='Selecciona tu edad:'});

  @override
  State<StatefulWidget> createState() => _SliderInputState();
}

class _SliderInputState extends State<AgeFormField> {
  late int sliderValue;

  @override
  void initState() {
    sliderValue = widget.minAge;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.label,
          style: const TextStyle(color: Colors.white),
        ),
        Slider(
          value: sliderValue.toDouble(),
          min: widget.minAge.toDouble(),
          max: widget.maxAge.toDouble(),
          divisions: widget.maxAge - widget.minAge,
          label: sliderValue.toString(),
          onChanged: (double value) {
            setState(() {
              sliderValue = value.toInt();
            });
          },
        )
      ],
    );
  }
}
