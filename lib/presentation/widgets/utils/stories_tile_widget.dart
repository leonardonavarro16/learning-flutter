import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:swc_front/data/models/story.dart';
import 'package:swc_front/data/models/user.dart';
import 'package:swc_front/logic/cubits/authentication_cubit.dart';
import 'package:swc_front/logic/cubits/story_cubit.dart';
import 'package:swc_front/presentation/router/app_router.dart';
import 'package:swc_front/presentation/widgets/utils/custom_button.dart';
import 'package:swc_front/presentation/widgets/utils/text_view.dart';
import 'package:swc_front/presentation/widgets/utils/upload_story_button.dart';

class StoriesTile extends StatefulWidget {
  // final List<Story> stories;
  // Uint8List profilePic;
  StoriesTile({
    Key? key,
    // required this.profilePic,
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
                          child: Stack(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.85,
                                    width: MediaQuery.of(context).size.height *
                                        0.9,
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
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              const Color.fromARGB(
                                                  255, 43, 43, 43)),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                      ),
                                    ),
                                    icon: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 10, left: 16),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                              width: 1.2, color: Colors.white),
                                        ),
                                        child: Container(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: Container(),

                                            // Image.memory(
                                            //   widget.profilePic,
                                            //   height: 25,
                                            //   width: 25,
                                            //   fit: BoxFit.cover,
                                            // ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      _submitStory();
                                      // Navigator.pushReplacementNamed(
                                      //     context, Routes.indexPage);
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
                                      color:
                                          const Color.fromARGB(255, 60, 60, 60),
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
                } else {
                  const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: CustomButton(
              text: 'show stories',
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, Routes.storyPage),
            ),
          ),
          // BlocConsumer<StoryCubit, StoryState>(
          //     listener: (BuildContext context, StoryState state) {
          //   if (state.status == StoryStatus.failure) {
          //     String errorMessage = state.error;
          //     SnackBarUtil.showSnackBar(
          //       context,
          //       backgroundColor: const Color(0xFFFF0000),
          //       textColor: Colors.black,
          //       errorMessage,
          //     );
          //     Navigator.pushReplacementNamed(context, Routes.indexPage);
          //   } else if (state.status == StoryStatus.storySuccess) {
          //     SnackBarUtil.showSnackBar(
          //         context,
          //         backgroundColor: Colors.green,
          //         textColor: Colors.black,
          //         'Story has been uploaded correctly');
          //     Navigator.pushReplacementNamed(context, Routes.indexPage);
          //   }
          // }, builder: (BuildContext context, StoryState state) {
          //   if (state.status == StoryStatus.loading) {
          //     return const CustomIndicatorProgress();
          //   } else {
          //     return Container();
          //   }
          // }),
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
