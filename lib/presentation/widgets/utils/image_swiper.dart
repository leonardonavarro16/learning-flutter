import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageSlider extends StatelessWidget {
  final List<Uint8List> images;

  ImageSlider({required this.images});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: false,
        enlargeCenterPage: true,
        aspectRatio: 9 / 16,
        // viewportFraction: 1.0,
      ),
      items: images
          .map((image) => Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.75,
                child: Image.memory(image, fit: BoxFit.cover),
              ))
          .toList(),
    );
  }
}
