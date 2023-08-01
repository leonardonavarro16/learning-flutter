// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import 'package:swc_front/presentation/widgets/layout.dart';
// import 'package:swc_front/presentation/widgets/utils/alert_dialog_custom.dart';
// import 'package:swc_front/presentation/widgets/utils/custom_button.dart';
// import 'package:swc_front/presentation/widgets/utils/pricing_view.dart';
// import 'package:swc_front/presentation/widgets/utils/text_view.dart';

// import 'package:flutter/material.dart';

// class TestingPage extends StatefulWidget {
//   const TestingPage({Key? key});

//   @override
//   State<TestingPage> createState() => _TestingPageState();
// }

// class _TestingPageState extends State<TestingPage> {
//   int selectedCardIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double desktopScreen = screenWidth * 0.385;
//     double mobileScreen = screenWidth * 0.8;
//     double desiredWidth = screenWidth > 800 ? desktopScreen : mobileScreen;
//     return Scaffold(
//       body: Layout(
//         content: Container(
//           child: CustomButton(
//             text: 'Show Dialog',
//             onPressed: () => showDialog(
//               context: context,
//               builder: (context) => CustomAlertDialog(
//                 hasButton: false,
//                 header: const Center(
//                   child: TextView(
//                     text: 'Choose your membership type',
//                     color: Color(0xFFFF0000),
//                     fontSize: 25,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 content: SizedBox(
//                   width: screenWidth * 0.5,
//                   child: PricingView(
//                     onTap: () {},
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   _buildPricingView() => showDialog(
//         context: context,
//         builder: (context) => CustomAlertDialog(
//           hasButton: false,
//           header: const Center(
//             child: TextView(
//               text: 'Choose your membership type',
//               color: Color(0xFFFF0000),
//               fontSize: 25,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           content: PricingView(
//             onTap: () {},
//           ),
//         ),
//       );
// }
