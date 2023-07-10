// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:swc_front/data/models/user.dart';
// import 'package:swc_front/presentation/widgets/utils/custom_button.dart';

// import '../../data/models/story.dart';
// import '../../logic/cubits/authentication_cubit.dart';

// class StoryViewPage extends StatefulWidget {
//   // final List<Uint8List> images;
//   final Story story;

//   const StoryViewPage({Key? key, required this.story}) : super(key: key);

//   @override
//   State<StoryViewPage> createState() => _StoryViewPageState();
// }

// class _StoryViewPageState extends State<StoryViewPage> {
//   int currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     User? currentUser = context.watch<AuthenticationCubit>().state.user;
//     return Scaffold(
//       body: Container(
//         child: CustomButton(
//           text: 'presiona para ver tod',
//           onPressed: () => {},
//         ),
//       ),
//     );
//   }
// }


// // GestureDetector(
// //         onTap: () {
// //           if (currentIndex < widget.images.length - 1) {
// //             setState(() {
// //               currentIndex++;
// //             });
// //           } else {
// //             Navigator.pop(context);
// //           }
// //         },
// //         child: Container(
// //           alignment: Alignment.center,
// //           child: Image.memory(
// //             widget.images[currentIndex],
// //             fit: BoxFit.contain,
// //           ),
// //         ),
// //       ),