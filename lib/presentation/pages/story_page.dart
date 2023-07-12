// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:swc_front/data/models/story.dart';
// import 'package:swc_front/logic/cubits/authentication_cubit.dart';
// import 'package:swc_front/logic/cubits/story_cubit.dart';
// import 'package:swc_front/logic/states/stories.dart';
// import 'package:swc_front/presentation/widgets/layout.dart';
// import 'package:swc_front/presentation/widgets/utils/snackbar_util.dart';
// import 'package:swc_front/presentation/widgets/utils/text_view.dart';

// class StoryPage extends StatelessWidget {
//   final List<Story>? stories;

//   const StoryPage({this.stories});

//   @override
//   Widget build(BuildContext context) {
//     bool isLogged = context.watch<AuthenticationCubit>().isLogged();
//     StoryState state = context.watch<StoryCubit>().state;
//     print('Número de stories en StoryPage: ${state.stories.length}');

//     return Layout(
//       content: Scaffold(
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               const TextView(text: 'stories'),
//               SizedBox(
//                 height: 350,
//                 width: 350,
//                 child: ListView.builder(
//                   itemCount: state.stories.length,
//                   itemBuilder: (context, index) {
//                     final story = state.stories[index];
//                     return Image.memory(story.image!);
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
