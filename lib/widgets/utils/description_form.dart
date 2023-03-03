import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DescriptionInput extends StatefulWidget {
  const DescriptionInput({super.key});

  @override
  State<StatefulWidget> createState() => _DescriptionInputState();
}

class _DescriptionInputState extends State<DescriptionInput> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: TextFormField(
        maxLines: 5,
        minLines: 1,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
            //contentPadding: EdgeInsets.symmetric(vertical: 100),
            filled: true,
            fillColor: Colors.white,
            labelText: 'Ingrese una descripción: (max. 100 caracteres)'),
        inputFormatters: <TextInputFormatter>[
          LengthLimitingTextInputFormatter(1000)
        ],
      ),
    );
  }
}
