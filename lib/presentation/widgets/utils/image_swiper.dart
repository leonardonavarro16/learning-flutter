import 'dart:typed_data';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  final List<Uint8List> images;

  ImageSlider({required this.images});

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: false,
                enlargeCenterPage: true,
                aspectRatio: 9 / 16,
                viewportFraction: 1,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                onPageChanged: (index, _) {
                  setState(() {
                    _currentImageIndex = index;
                  });
                },
              ),
              items: widget.images
                  .map(
                    (image) => Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Image.memory(image, fit: BoxFit.cover),
                    ),
                  )
                  .toList(),
            ),
            Positioned(
              bottom: 150,
              left: 0.0,
              right: 0.0,
              child: DotsIndicator(
                dotsCount: widget.images.length,
                position: _currentImageIndex,
                decorator: DotsDecorator(
                  activeColor: Colors.white,
                  activeSize: const Size(8, 8),
                  color: Colors.grey[400]!,
                  size: const Size(4, 4),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
