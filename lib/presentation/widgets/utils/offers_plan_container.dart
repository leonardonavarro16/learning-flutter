// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:swc_front/presentation/widgets/utils/text_view.dart';

// class OfferContentWidget extends StatefulWidget {
//   final String? timeText;
//   final String? offerText;
//   final bool isSelected;
//   final VoidCallback onTap;

//   OfferContentWidget({
//     Key? key,
//     this.timeText,
//     this.offerText,
//     required this.isSelected,
//     required this.onTap,
//   }) : super(key: key);

//   @override
//   State<OfferContentWidget> createState() => _OfferContentWidgetState();
// }

// class _OfferContentWidgetState extends State<OfferContentWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: widget.onTap,
//       child: Padding(
//         padding: const EdgeInsets.only(left: 12.5, right: 12.5),
//         child: SizedBox(
//           child: Card(
//             color: widget.isSelected
//                 ? Color.fromARGB(255, 138, 0, 0)
//                 : const Color.fromARGB(255, 57, 57, 57),
//             shape: RoundedRectangleBorder(
//               side: BorderSide(
//                 color: widget.isSelected ? Colors.amber : Colors.transparent,
//                 width: 2.0,
//               ),width
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextView(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.amber,
//                   text: widget.timeText ?? '12 MONTHS MEMBERSHIP',
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextView(
//                   text: widget.offerText ?? '9.99 /MONTH',
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 const Center(
//                   child: CircleAvatar(
//                     backgroundColor: Colors.amber,
//                     child: Icon(
//                       CupertinoIcons.cart_fill,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
