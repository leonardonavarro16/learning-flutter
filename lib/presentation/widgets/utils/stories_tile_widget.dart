import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swc_front/data/models/story.dart';
import 'package:swc_front/data/models/user.dart';
import 'package:swc_front/logic/cubits/authentication_cubit.dart';
import 'package:swc_front/logic/cubits/story_cubit.dart';
import 'package:swc_front/logic/states/stories.dart';
import 'package:swc_front/presentation/router/app_router.dart';
import 'package:swc_front/presentation/widgets/utils/indicator_progress.dart';
import 'package:swc_front/presentation/widgets/utils/snackbar_util.dart';
import 'package:swc_front/presentation/widgets/utils/story_bubble.dart';
import 'package:swc_front/presentation/widgets/utils/text_view.dart';
import 'package:swc_front/presentation/widgets/utils/upload_story_button.dart';

class StoriesTile extends StatefulWidget {
  StoriesTile({
    Key? key,
  }) : super(key: key);

  @override
  State<StoriesTile> createState() => _StoriesTileState();
}

class _StoriesTileState extends State<StoriesTile> {
  Uint8List? imageBytes;
  String? id;

  @override
  Widget build(BuildContext context) {
    User? currentUser = context.watch<AuthenticationCubit>().state.user;
    bool isLogged = context.watch<AuthenticationCubit>().isLogged();
    return Container(
      height: 100,
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10, left: 5),
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: false,
        children: [
          if (isLogged)
            UploadStoryButton(
              onChanged: (Uint8List? bytes) {
                setState(() => imageBytes = bytes);
                if (imageBytes != null) {
                  showDialog(
                      barrierColor: Colors.black,
                      context: context,
                      builder: (context) {
                        return SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.85,
                                width: MediaQuery.of(context).size.height * 0.9,
                                child: Image.memory(
                                  imageBytes!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                onPressed: () => _submitStory(),
                                child: const TextView(text: 'manda HISTORIA'),
                              )
                            ],
                          ),
                        );
                      });
                } else {
                  const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          BlocConsumer<StoryCubit, StoryState>(
              listener: (BuildContext context, StoryState state) {
            if (state.status == StoryStatus.storySuccess) {
              String errorMessage = state.error;
              SnackBarUtil.showSnackBar(
                context,
                backgroundColor: const Color(0xFFFF0000),
                textColor: Colors.black,
                errorMessage,
              );
            } else if (state.status == StoryStatus.failure) {
              SnackBarUtil.showSnackBar(
                  context,
                  backgroundColor: Colors.green,
                  textColor: Colors.black,
                  'Story has been uploaded correctly');
              Navigator.pushReplacementNamed(context, Routes.indexPage);
            }
          }, builder: (BuildContext context, StoryState state) {
            if (state.status == StoryStatus.loading) {
              return const CustomIndicatorProgress();
            } else {
              return StoryBubble(
                profilePicture: MemoryImage(currentUser!.image!),
                username: currentUser.name,
              );
            }
          }),
        ],
      ),
    );
  }

  Story _builStory() {
    return Story(image: imageBytes!, id: id);
  }

  void _submitStory() {
    Story story = _builStory();
    String? token = context.read<AuthenticationCubit>().state.token;
    if (token == null) throw Exception('Token is missing');
    context.read<StoryCubit>().createStory(story, token);
  }
}
