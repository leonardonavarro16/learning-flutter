import 'package:flutter/material.dart';

class AgeFormField extends StatefulWidget {
  final int minAge;
  final int maxAge;
  final Function onChanged;
  final String label;
  final int? initialValue;

  const AgeFormField(
      {super.key,
      required this.onChanged,
      this.minAge = 18,
      this.maxAge = 65,
      this.label = 'Selecciona tu edad:',
      this.initialValue});

  @override
  State<StatefulWidget> createState() => _SliderInputState();
}

class _SliderInputState extends State<AgeFormField> {
  late int sliderValue;

  @override
  void initState() {
    bool inRange = widget.initialValue == null
        ? false
        : widget.initialValue! >= widget.minAge &&
            widget.initialValue! <= widget.maxAge;
    if (inRange) {
      sliderValue = widget.initialValue!;
    } else {
      sliderValue = widget.minAge;
    }
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
          onChanged: _onChange,
        )
      ],
    );
  }

  void _onChange(double value) {
    int val = value.toInt();
    setState(() {
      sliderValue = val;
      widget.onChanged(val);
    });
  }
}
