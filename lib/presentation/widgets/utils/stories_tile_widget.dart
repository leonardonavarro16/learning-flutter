import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swc_front/presentation/widgets/utils/text_view.dart';
import 'package:swc_front/presentation/widgets/utils/upload_story_button.dart';

class StoriesTile extends StatefulWidget {
  final String? child;
  final String? username;

  final ImageProvider<Object>? backgroundImage;

  StoriesTile({
    Key? key,
    this.child,
    this.username,
    this.backgroundImage,
  }) : super(key: key);

  @override
  State<StoriesTile> createState() => _StoriesTileState();
}

class _StoriesTileState extends State<StoriesTile> {
  Uint8List? image;
  @override
  Widget build(BuildContext context) {
    final firstName = widget.username?.split(' ')[0];
    return Container(
      height: 100,
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10, left: 5),
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: false,
        children: [
          UploadStoryButton(
            onChanged: (Uint8List? bytes) {
              setState(() => image = bytes);
            },
          ),
          _createStory(),
          _createStory(),
          _createStory(),
          _createStory(),
          _createStory(),
          _createStory(),
          _createStory(),
          _createStory(),
        ],
      ),
    );
  }

  _createStory() => Column(
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
                child: Image(
                  image: widget.backgroundImage!,
                  height: 65,
                  width: 65,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          TextView(
            text: widget.username?.split(' ')[0],
            fontSize: 13,
            color: Colors.white,
          )
        ],
      );
}
