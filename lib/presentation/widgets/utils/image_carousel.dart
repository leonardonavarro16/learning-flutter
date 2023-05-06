import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImageCarousel extends StatefulWidget {
  final List<Uint8List> images;
  final void Function(int)? onChange;
  const ImageCarousel({
    super.key,
    required this.images,
    this.onChange,
  });

  @override
  State<StatefulWidget> createState() => _ImageCarousel();
}

class _ImageCarousel extends State<ImageCarousel> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => _incrementIndex(-1),
          child: const Text('Prev'),
        ),
        SizedBox(
          height: 100,
          width: 100,
          child: Image.memory(widget.images[index]),
        ),
        ElevatedButton(
          onPressed: () => _incrementIndex(1),
          child: const Text('Next'),
        )
      ],
    );
  }

  void _incrementIndex(int increment) {
    setState(() => index = (index + increment) % widget.images.length);
    if (widget.onChange != null) widget.onChange!(index);
  }
}
