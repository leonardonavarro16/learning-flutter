import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swc_front/data/models/advert.dart';
import 'package:swc_front/presentation/widgets/utils/alert_dialog_custom.dart';
import 'package:swc_front/presentation/widgets/utils/custom_button.dart';
import 'package:swc_front/presentation/widgets/utils/text_view.dart';

class ModalOpenedContainerContent extends StatefulWidget {
  final Advert advert;
  final String location;
  final String availability;
  final String rate;

  const ModalOpenedContainerContent({
    Key? key,
    required this.advert,
    this.location = 'Medellin',
    this.availability = '24 horas',
    this.rate = '4.5',
  }) : super(key: key);

  @override
  State<ModalOpenedContainerContent> createState() =>
      _ModalOpenedContainerContentState();
}

class _ModalOpenedContainerContentState
    extends State<ModalOpenedContainerContent> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double desktopScreen = screenWidth * 0.3;
    double mobileScreen = screenWidth * 0.8;
    double desiredWidth = screenWidth > 800 ? desktopScreen : mobileScreen;

    return Container(
      height: screenHeight * 0.38,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 22, 0, 0),
            Color(0xFFFF0000),
          ],
          begin: Alignment.center,
          end: Alignment.bottomCenter,
        ),
      ),
      child: content(context),
    );
  }

  content(context) => SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextView(
                        text: widget.advert.name,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      const TextView(
                        text: 'Barranquilla',
                        color: Color.fromARGB(155, 255, 255, 255),
                        fontSize: 10,
                      ),
                    ],
                  ),
                  const Row(
                    children: [
                      TextView(
                        text: '4.5',
                        color: Color.fromARGB(155, 255, 255, 255),
                        fontSize: 12,
                      ),
                      SizedBox(width: 2.5),
                      Icon(
                        color: Colors.yellow,
                        size: 10,
                        CupertinoIcons.star_fill,
                      ),
                    ],
                  ),
                  TextView(
                    text: '${widget.advert.age} años',
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(155, 255, 255, 255),
                    fontSize: 10,
                  ),
                  const TextView(
                    text: '24 horas',
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ],
              ),
            ),
            const Divider(
              color: Color.fromARGB(155, 255, 255, 255),
              height: 10,
              thickness: 1,
              indent: 35,
              endIndent: 25,
            ),
            Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                if (widget.advert.ad_tags != null &&
                    widget.advert.ad_tags!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: widget.advert.ad_tags!.map((tag) {
                        return Chip(
                          backgroundColor: const Color(0xFFFF0000),
                          label: TextView(
                            text: tag,
                            color: Colors.white,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                Container(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 35,
                    right: 35,
                    bottom: 15,
                  ),
                  child: TextView(
                    text: widget.advert.description,
                    fontSize: 14,
                    color: Colors.white,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            CustomButton(
              text: formatPhoneNumber(widget.advert.phoneNumber),
              borderRadius: 15,
              fontSize: 20,
              height: 55,
              width: 250,
              onPressed: () {
                Clipboard.setData(
                  ClipboardData(
                    text: formatPhoneNumber(widget.advert.phoneNumber),
                  ),
                );
                showDialog(
                  context: context,
                  builder: (context) {
                    Future.delayed(const Duration(milliseconds: 1200), () {
                      Navigator.of(context).pop();
                    });

                    return StatefulBuilder(
                      builder: (context, setState) {
                        return const CustomAlertDialog(
                          header: TextView(
                            text: 'Número de teléfono copiado',
                            textAlign: TextAlign.center,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFF0000),
                          ),
                          content: TextView(
                            fontSize: 13.5,
                            text:
                                'El número de teléfono se ha copiado al portapapeles.',
                            color: Colors.white,
                          ),
                          hasButton: false,
                        );
                      },
                    );
                  },
                );
              },
            ),
            if (widget.advert.ad_tags != null &&
                widget.advert.ad_tags!.length > 3)
              const SizedBox(
                height: 20,
              ),
            if (widget.advert.ad_tags != null &&
                widget.advert.ad_tags!.length > 6)
              const SizedBox(
                height: 25,
              ),
            if (widget.advert.ad_tags != null &&
                widget.advert.ad_tags!.length > 9)
              const SizedBox(
                height: 30,
              ),
          ],
        ),
      );

  String formatPhoneNumber(String phoneNumber) {
    final regex = RegExp(r'^(\d{3})(\d{3})(\d{4})$');
    final match = regex.firstMatch(phoneNumber);

    if (match != null) {
      final group1 = match.group(1);
      final group2 = match.group(2);
      final group3 = match.group(3);

      return '$group1 $group2 $group3';
    } else {
      return phoneNumber;
    }
  }
}
