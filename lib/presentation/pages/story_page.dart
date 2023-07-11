import 'package:flutter/material.dart';
import 'package:swc_front/data/models/story.dart';
import 'package:swc_front/presentation/widgets/layout.dart';
import 'package:swc_front/presentation/widgets/utils/text_view.dart';

class StoryPage extends StatelessWidget {
  final List<Story> stories;

  const StoryPage({required this.stories});

  @override
  Widget build(BuildContext context) {
    print(stories.length);
    return Layout(
      content: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const TextView(text: 'stories'),
              SizedBox(
                height: 500,
                width: 500,
                child: ListView.builder(
                  itemCount: stories.length,
                  itemBuilder: (context, index) {
                    final story = stories[index];
                    return Image.memory(story.image!);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
