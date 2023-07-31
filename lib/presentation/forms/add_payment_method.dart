import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:swc_front/logic/cubits/navigation.dart';
import 'package:swc_front/presentation/widgets/layout.dart';

class AddPaymentForm extends StatefulWidget {
  final InputDecoration? decoration;
  const AddPaymentForm({Key? key, this.decoration});

  @override
  _AddPaymentFormState createState() => _AddPaymentFormState();
}

class _AddPaymentFormState extends State<AddPaymentForm> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final OutlineInputBorder defaultOutlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: const BorderSide(
      width: 1,
      color: Color(0xFFFF0000),
    ),
  );
  final TextStyle defaultLabelSTyle = const TextStyle(
      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black);

  @override
  Widget build(context) {
    return Material(
      child: Center(
        child: Container(
          color: Colors.black,
          width: MediaQuery.of(context).size.width * 0.4,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'My Wallets',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              CreditCardWidget(
                height: 325,
                width: 600,
                chipColor: Colors.amber,
                cardBgColor: const Color.fromARGB(255, 161, 38, 30),
                // cardBgColor: const Color.fromARGB(255, 0, 27, 81),
                isHolderNameVisible: true,
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
                obscureCardNumber: true,
                obscureCardCvv: true,
                onCreditCardWidgetChange: (CreditCardBrand) {},
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CreditCardForm(
                        cardNumber: cardNumber,
                        expiryDate: expiryDate,
                        cardHolderName: cardHolderName,
                        cvvCode: cvvCode,
                        onCreditCardModelChange: onCreditCardModelChange,
                        themeColor: const Color.fromARGB(255, 243, 33, 33),
                        formKey: formKey,
                        cardNumberDecoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          fillColor: Colors.white,
                          filled: true,
                          errorBorder: defaultOutlineInputBorder,
                          border: defaultOutlineInputBorder,
                          enabledBorder: defaultOutlineInputBorder,
                          disabledBorder: defaultOutlineInputBorder,
                          focusedErrorBorder: defaultOutlineInputBorder,
                          focusedBorder: defaultOutlineInputBorder,
                          labelStyle: defaultLabelSTyle,
                          labelText: 'Card Number',
                          hintText: 'xxxx xxxx xxxx xxxx',
                        ),
                        expiryDateDecoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          fillColor: Colors.white,
                          filled: true,
                          errorBorder: defaultOutlineInputBorder,
                          border: defaultOutlineInputBorder,
                          enabledBorder: defaultOutlineInputBorder,
                          disabledBorder: defaultOutlineInputBorder,
                          focusedErrorBorder: defaultOutlineInputBorder,
                          focusedBorder: defaultOutlineInputBorder,
                          labelStyle: defaultLabelSTyle,
                          labelText: 'Expiration Date',
                          hintText: 'xx/xx',
                        ),
                        cvvCodeDecoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          fillColor: Colors.white,
                          filled: true,
                          errorBorder: defaultOutlineInputBorder,
                          border: defaultOutlineInputBorder,
                          enabledBorder: defaultOutlineInputBorder,
                          disabledBorder: defaultOutlineInputBorder,
                          focusedErrorBorder: defaultOutlineInputBorder,
                          focusedBorder: defaultOutlineInputBorder,
                          labelStyle: defaultLabelSTyle,
                          labelText: 'CVV',
                          hintText: 'xxx',
                        ),
                        cardHolderDecoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          fillColor: Colors.white,
                          filled: true,
                          errorBorder: defaultOutlineInputBorder,
                          border: defaultOutlineInputBorder,
                          enabledBorder: defaultOutlineInputBorder,
                          disabledBorder: defaultOutlineInputBorder,
                          focusedErrorBorder: defaultOutlineInputBorder,
                          focusedBorder: defaultOutlineInputBorder,
                          labelStyle: defaultLabelSTyle,
                          labelText: 'Card Holder',
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      _buildAddPaymentButton(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _buildDefaultDecoration() {
    OutlineInputBorder defaultBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(
        width: 1,
        color: Color(0xFFFF0000),
      ),
    );

    return InputDecoration(
        border: defaultBorder,
        enabledBorder: defaultBorder,
        focusedBorder: defaultBorder,
        errorBorder: defaultBorder,
        focusedErrorBorder: defaultBorder);
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  Widget _buildAddPaymentButton(context) => Container(
        width: kIsWeb
            ? MediaQuery.of(context).size.width * .9
            : MediaQuery.of(context).size.width * .3,
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
            elevation: 0.0,
          ),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              print('valid');
            } else {
              print('inValid');
            }
          },
          child: const Text(
            'Add this Payment Method',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ),
      );
}
