import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swc_front/data/models/story.dart';
import 'package:swc_front/logic/cubits/authentication_cubit.dart';
import 'package:swc_front/logic/cubits/story_cubit.dart';
import 'package:swc_front/presentation/widgets/utils/alert_dialog_custom.dart';
import 'package:swc_front/presentation/widgets/utils/text_view.dart';
import 'package:swc_front/presentation/widgets/utils/upload_story_button.dart';

import 'custom_button.dart';

class StoriesTile extends StatefulWidget {
  final String? username;
  final ImageProvider<Object>? backgroundImage;

  StoriesTile({
    Key? key,
    this.username,
    this.backgroundImage,
  }) : super(key: key);

  @override
  State<StoriesTile> createState() => _StoriesTileState();
}

class _StoriesTileState extends State<StoriesTile> {
  Uint8List? image;
  String? id;

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
              if (image != null) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Column(
                        children: [
                          CustomAlertDialog(
                            hasButton: false,
                            header: TextView(
                              text: 'Preview Story',
                              color: Colors.white,
                            ),
                            content: Image.memory(
                              image!,
                              fit: BoxFit.cover,
                            ),
                          ),
                          CustomButton(
                            text: 'Upload',
                            onPressed: () => _submitStory(),
                          ),
                        ],
                      );
                    });
              }
            },
          ),
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

  Story _builStory() {
    return Story(image: image!, id: id);
  }

  void _submitStory() {
    Story story = _builStory();
    String? token = context.read<AuthenticationCubit>().state.token;
    if (token == null) throw Exception('Token is missing');
    context.read<StoryCubit>().createStory(story, token);
  }
}
