import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swc_front/logic/cubits/story_cubit.dart';
import 'package:swc_front/logic/states/stories.dart';
import 'package:swc_front/presentation/router/app_router.dart';

class StoryPage extends StatefulWidget {
  const StoryPage();

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPageIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StoryState state = context.watch<StoryCubit>().state;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    if (_pageController.page! <
                        state.stories[state.user_id]!.length - 1) {
                      _pageController.previousPage(
                          duration: const Duration(milliseconds: 1),
                          curve: Curves.easeInOut);
                    }
                  },
                  child: const Icon(
                      size: 70,
                      color: Colors.white,
                      Icons.arrow_back_ios_rounded),
                ),
                Column(
                  children: [
                    Center(
                      child: Container(
                        width: screenWidth * 0.8,
                        height: screenHeight,
                        child: PageView.builder(
                          controller: _pageController,
                          onPageChanged: (index) {
                            setState(() {
                              _currentPageIndex = index;
                            });
                          },
                          scrollDirection: Axis.horizontal,
                          itemCount: state.stories[state.user_id]!.length,
                          itemBuilder: (context, index) {
                            final story = state.stories[state.user_id]![index];
                            return Image.memory(
                              story.image!,
                              fit: BoxFit.contain,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                InkWell(
                  child: const Icon(
                      size: 70,
                      color: Colors.white,
                      Icons.arrow_forward_ios_rounded),
                  onTap: () {
                    if (_pageController.page! <
                        state.stories[state.user_id]!.length - 1) {
                      _pageController.nextPage(
                          duration: const Duration(milliseconds: 1),
                          curve: Curves.easeInOut);
                    }
                  },
                ),
              ],
            ),
            Positioned(
              top: 20,
              left: 30,
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
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: state.stories[state.user_id]!.isNotEmpty
                  ? DotsIndicator(
                      position: _currentPageIndex,
                      dotsCount: state.stories[state.user_id]!.length,
                      decorator: DotsDecorator(
                        activeColor: Colors.white,
                        activeSize: const Size(7, 7),
                        color: Colors.grey[400]!,
                        size: const Size(4, 4),
                      ),
                    )
                  : Container(),
            )
          ],
        ),
      ),
    );
  }
}
