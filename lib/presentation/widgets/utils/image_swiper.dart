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
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double desktopScreen = screenWidth * 0.3;
    double mobileScreen = screenWidth;
    double desiredWidth = screenWidth > 800 ? desktopScreen : mobileScreen;
    bool isLargeScreen = screenWidth > 800;
    return Stack(
      children: [
        SizedBox(
          height: screenHeight,
          width: desiredWidth,
          child: CarouselSlider(
            options: CarouselOptions(
              autoPlay: false,
              enlargeCenterPage: true,
              aspectRatio: 0.1,
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
                  (image) => Image.memory(image, fit: BoxFit.cover),
                )
                .toList(),
          ),
        ),
        if (widget.images.isNotEmpty)
          Positioned(
            bottom: 75,
            left: 0.0,
            right: 0.0,
            child: DotsIndicator(
              key: UniqueKey(),
              dotsCount: widget.images.length,
              position: _currentImageIndex < widget.images.length
                  ? _currentImageIndex
                  : 0,
              decorator: DotsDecorator(
                activeColor: Colors.white,
                activeSize: const Size(8, 8),
                color: Colors.grey[400]!,
                size: const Size(4, 4),
              ),
            ),
          ),
      ],
    );
  }
}
