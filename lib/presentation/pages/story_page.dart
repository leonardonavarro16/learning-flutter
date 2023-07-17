import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swc_front/logic/cubits/authentication_cubit.dart';
import 'package:swc_front/logic/cubits/story_cubit.dart';
import 'package:swc_front/logic/states/stories.dart';
import 'package:swc_front/presentation/router/app_router.dart';

class StoryPage extends StatelessWidget {
  const StoryPage();

  @override
  Widget build(BuildContext context) {
    bool isLogged = context.watch<AuthenticationCubit>().isLogged();
    StoryState state = context.watch<StoryCubit>().state;
    print(
        'Número de usuarios con historias en StoryPage: ${state.stories.length}');
    print('objeto de historias: en StoryPage ${state.stories}');
    print('${state.stories[state.user_id]}');
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: screenHeight,
                  width: screenWidth,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.stories[state.user_id]!.length,
                    itemBuilder: (context, index) {
                      final story = state.stories[state.user_id]![index];
                      return Image.memory(
                        story.image!,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ],
            ),
            Positioned(
              top: 20,
              left: 8,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, Routes.indexPage);
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
      ),
    );
  }
}
