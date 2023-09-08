import 'package:flutter/material.dart';
import 'package:swc_front/presentation/forms/add_payment_method.dart';
import 'package:swc_front/presentation/widgets/layout.dart';
import 'package:swc_front/presentation/widgets/utils/alert_dialog_custom.dart';
import 'package:swc_front/presentation/widgets/utils/text_view.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double desktopScreen = screenWidth * 0.3;
    double mobileScreen = screenWidth * 0.8;
    bool isLargeScreen = screenWidth > 800;
    double desiredWidth = isLargeScreen ? desktopScreen : mobileScreen;

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Layout(
        content: Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: desiredWidth,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'My Wallets',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Payment methods',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Credit or Debit card',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Column(
                    children: [
                      InkWell(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color: Colors.grey[200],
                          child: const ListTile(
                            leading: Icon(
                              Icons.payment,
                              size: 30,
                              color: Colors.black,
                            ),
                            title: Text('**** **** **** 8938'),
                          ),
                        ),
                        onTap: () => showDialog(
                          context: context,
                          builder: (_) {
                            if (!isLargeScreen) {
                              return Scaffold(
                                  appBar: AppBar(
                                    backgroundColor: Colors.black,
                                    title: const TextView(
                                        text: 'Add payment method'),
                                  ),
                                  body: const Center(child: AddPaymentForm()));
                            } else {
                              return const CustomAlertDialog(
                                  header: Center(
                                    child: TextView(
                                      color: Colors.white,
                                      text: 'Añadir método de pago',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  hasButton: false,
                                  content: AddPaymentForm());
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Spacer(),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF0000),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) {
                                if (!isLargeScreen) {
                                  return Scaffold(
                                      appBar: AppBar(
                                        backgroundColor: Colors.black,
                                        title: const TextView(
                                            text: 'Add payment method'),
                                      ),
                                      body: const Center(
                                          child: AddPaymentForm()));
                                } else {
                                  return const CustomAlertDialog(
                                      header: Center(
                                        child: TextView(
                                          color: Colors.white,
                                          text: 'Añadir método de pago',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      hasButton: false,
                                      content: AddPaymentForm());
                                }
                              },
                            );
                          },
                          child: const Text(
                            'Add Payment Method',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  // Widget _buildPaymentMethod(context) => InkWell(
  //       child: Card(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(10.0),
  //         ),
  //         color: Colors.grey[200],
  //         child: const ListTile(
  //           leading: Icon(
  //             Icons.payment,
  //             size: 30,
  //             color: Colors.black,
  //           ),
  //           title: Text('**** **** **** 8938'),
  //         ),
  //       ),
  //       onTap: () => showDialog(
  //         context: context,
  //         builder: (_) {
  //           return Scaffold(
  //               appBar: AppBar(
  //                 backgroundColor: Colors.black,
  //                 title: TextView(text: 'Add payment method'),
  //               ),
  //               body: Center(child: AddPaymentForm()));
  //         },
  //       ),
  //     );

  // Widget _buildAddPaymentButton(context) => Container(
  //       width: MediaQuery.of(context).size.width,
  //       height: 60,
  //       decoration: BoxDecoration(
  //         color: Color(0xFFFF0000),
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //       child: ElevatedButton(
  //         style: ElevatedButton.styleFrom(
  //           backgroundColor: Colors.transparent,
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(10),
  //           ),
  //         ),
  //         onPressed: () {
  //           showDialog(
  //             context: context,
  //             builder: (_) {
  //               return const CustomAlertDialog(
  //                 header: Center(
  //                   child: TextView(
  //                     color: Colors.white,
  //                     text: 'Añadir método de pago',
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //                 hasButton: false,
  //                 content: AddPaymentForm(),
  //               );
  //             },
  //           );
  //         },
  //         child: const Text(
  //           'Add Payment Method',
  //           style: TextStyle(
  //             color: Colors.white,
  //             fontSize: 22,
  //           ),
  //         ),
  //       ),
  //     );
}
