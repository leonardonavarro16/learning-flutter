import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swc_front/data/models/story.dart';
import 'package:swc_front/data/models/user.dart';
import 'package:swc_front/logic/cubits/authentication_cubit.dart';
import 'package:swc_front/logic/cubits/story_cubit.dart';
import 'package:swc_front/logic/states/stories.dart';
import 'package:swc_front/presentation/router/app_router.dart';
import 'package:swc_front/presentation/widgets/utils/story_bubble.dart';
import 'package:swc_front/presentation/widgets/utils/text_view.dart';
import 'package:swc_front/presentation/widgets/utils/upload_story_button.dart';

class StoriesView extends StatefulWidget {
  final List<Story>? stories;

  StoriesView({
    Key? key,
    required this.stories,
  }) : super(key: key);

  @override
  State<StoriesView> createState() => _StoriesViewState();
}

class _StoriesViewState extends State<StoriesView> {
  Uint8List? imageBytes;
  String? id;

  @override
  Widget build(BuildContext context) {
    User? currentUser = context.watch<AuthenticationCubit>().state.user;
    bool isLogged = context.watch<AuthenticationCubit>().isLogged();
    StoryState state = context.watch<StoryCubit>().state;

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
                _buildPreviewStory(currentUser!.image!);
              },
            ),
          InkWell(
            child: StoryBubble(
                profilePicture: currentUser!.image, username: currentUser.name),
            onTap: () =>
                Navigator.pushReplacementNamed(context, Routes.storyPage),
          ),
        ],
      ),
    );
  }

  Story _buildStory() {
    return Story(image: imageBytes!, id: id);
  }

  void _submitStory() {
    Story story = _buildStory();
    String? token = context.read<AuthenticationCubit>().state.token;
    if (token == null) throw Exception('Token is missing');
    context.read<StoryCubit>().createStory(story, token);
  }

  // void _buildStoriesDialog(context) => showDialog(
  //     context: context,
  //     builder: (context) {
  //       StoryState state = context.watch<StoryCubit>().state;

  //       return ListView.builder(
  //         scrollDirection: Axis.horizontal,
  //         shrinkWrap: true,
  //         itemCount: state.stories.length,
  //         itemBuilder: (context, index) {
  //           Story story = state.stories[index];

  //           return Container(
  //             width: 70,
  //             height: 70,
  //             margin: const EdgeInsets.symmetric(horizontal: 5),
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(10),
  //               image: DecorationImage(
  //                 image: MemoryImage(story.image!),
  //                 fit: BoxFit.cover,
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     });

  void _buildPreviewStory(Uint8List? userImage) => showDialog(
      barrierColor: Colors.black,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.85,
                    width: MediaQuery.of(context).size.height * 0.9,
                    child: Image.memory(
                      imageBytes!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 43, 43, 43)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    icon: Padding(
                      padding:
                          const EdgeInsets.only(top: 10, bottom: 10, left: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(width: 1.2, color: Colors.white),
                        ),
                        child: Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.memory(
                              userImage!,
                              height: 25,
                              width: 25,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {
                      _submitStory();
                      Navigator.pushReplacementNamed(context, Routes.indexPage);
                    },
                    label: const Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: TextView(
                        text: ' Add Story',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 20,
                left: 8,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: const Color.fromARGB(255, 60, 60, 60),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 27.5,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      });
}
