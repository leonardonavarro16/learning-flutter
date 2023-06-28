// import 'package:flutter/material.dart';
// import 'package:swc_front/presentation/widgets/utils/text_view.dart';

// class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
//   const SearchAppBar({Key? key}) : super(key: key);

//   @override
//   _SearchAppBarState createState() => _SearchAppBarState();

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }

// class _SearchAppBarState extends State<SearchAppBar> {
//   bool _isExpanded = false;
//   late FocusNode _focusNode;
//   late TextEditingController _textEditingController;

//   @override
//   void initState() {
//     super.initState();
//     _focusNode = FocusNode();
//     _textEditingController = TextEditingController();
//   }

//   @override
//   void dispose() {
//     _focusNode.dispose();
//     _textEditingController.dispose();
//     super.dispose();
//   }

//   void _toggleSearchBar() {
//     setState(() {
//       _isExpanded = !_isExpanded;
//     });

//     if (_isExpanded) {
//       _focusNode.requestFocus();
//     } else {
//       _focusNode.unfocus();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       title: _isExpanded ? null : const TextView(text: 'My app'),
//       leading: IconButton(
//         icon: const Icon(Icons.search),
//         onPressed: _toggleSearchBar,
//       ),
//       actions: [
//         if (_isExpanded)
//           IconButton(
//             icon: const Icon(Icons.close),
//             onPressed: _toggleSearchBar,
//           ),
//       ],
//       bottom: _isExpanded
//           ? PreferredSize(
//               preferredSize: const Size.fromHeight(50),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8),
//                 child: TextField(
//                   controller: _textEditingController,
//                   focusNode: _focusNode,
//                   decoration: const InputDecoration(
//                     hintText: 'Search...',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//               ),
//             )
//           : null,
//     );
//   }
// }
