import 'package:flutter/material.dart';

class StoryBubble extends StatelessWidget {
  final String? child;

  StoryBubble({this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: CircleAvatar(
        backgroundColor: const Color(0xFFFF0000),
        radius: 31.5,
        child: Container(
          width: 57.5,
          height: 57.5,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.orange, Colors.red],
            ),
          ),
          child: const CircleAvatar(
            radius: 17.5,
            backgroundImage: AssetImage('avatar_preview_two.jpg'),
          ),
        ),
      ),
    );
  }
}
