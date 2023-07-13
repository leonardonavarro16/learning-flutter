import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swc_front/logic/cubits/user.dart';
import 'package:swc_front/logic/states/user.dart';
import 'package:swc_front/presentation/widgets/utils/text_view.dart';

class StoryBubble extends StatelessWidget {
  final Uint8List? profilePicture;
  final String? username;
  const StoryBubble(
      {super.key, required this.profilePicture, required this.username});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(width: 3),
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 76, 5, 0),
                Color(0xFFFF0000),
              ],
              stops: [
                0.1,
                1,
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(2),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.memory(
                profilePicture!,
                fit: BoxFit.cover,
                height: 65,
                width: 65,
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        TextView(
          text: username!.split(' ')[0],
          fontSize: 12,
          color: Colors.white,
        )
      ],
    );
  }
}
