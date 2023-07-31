import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swc_front/logic/cubits/navigation.dart';
import 'package:swc_front/presentation/forms/add_payment_method.dart';
import 'package:swc_front/presentation/widgets/layout.dart';
import 'package:swc_front/presentation/widgets/utils/alert_dialog_custom.dart';
import 'package:swc_front/presentation/widgets/utils/text_view.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<NavigationCubit>(context);
    return Layout(
      content: LayoutBuilder(builder: (context, constraints) {
        return Center(
          child: Container(
            height: constraints.maxHeight * .8,
            width: constraints.maxWidth * .5,
            child: Column(
              children: [
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
                  child: Container(
                    width: constraints.maxWidth * .3,
                    child: Column(
                      children: [
                        _buildPaymentMethod(context),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildPaymentMethod(context),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildPaymentMethod(context),
                        const Spacer(),
                        _buildAddPaymentButton(context),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildPaymentMethod(context) => InkWell(
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
          builder: (context) {
            return const CustomAlertDialog(
                header: Center(
                  child: TextView(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    text: 'Añadir método de pago',
                  ),
                ),
                hasButton: false,
                content: AddPaymentForm());
          },
        ),
      );

  Widget _buildAddPaymentButton(context) => Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        decoration: BoxDecoration(
          color: Color(0xFFFF0000),
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
              builder: (context) {
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
      );
}
