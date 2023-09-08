import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marquee_text/marquee_text.dart';
import 'package:swc_front/data/models/advert.dart';
import 'package:swc_front/presentation/widgets/utils/alert_dialog_custom.dart';
import 'package:swc_front/presentation/widgets/utils/custom_button.dart';
import 'package:swc_front/presentation/widgets/utils/text_view.dart';
import 'package:url_launcher/url_launcher.dart';

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
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isLargeScreen = screenWidth > 800;

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 0, 0, 0),
            Color(0xFFFF0000),
          ],
          begin: Alignment.center,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            const Divider(
              indent: 225,
              endIndent: 225,
              color: Colors.white,
              thickness: 2.5,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              child: ExpansionPanelList(
                expandIconColor: Colors.white,
                expansionCallback: (int panelIndex, bool isExpanded) {
                  setState(() {
                    _isExpanded = !isExpanded;
                  });
                },
                children: [
                  ExpansionPanel(
                    backgroundColor: Colors.transparent,
                    headerBuilder: (BuildContext context, bool isExpanded) =>
                        Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MarqueeText(
                                    text: TextSpan(
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      text: widget.advert.name,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const TextView(
                                      text: 'Barranquilla',
                                      color: Color.fromARGB(155, 255, 255, 255),
                                      fontSize: 12),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Row(
                                  children: [
                                    TextView(
                                        text: '4.5',
                                        color:
                                            Color.fromARGB(155, 255, 255, 255),
                                        fontSize: 14),
                                    SizedBox(width: 2.5),
                                    Icon(
                                        color: Colors.yellow,
                                        size: 12,
                                        CupertinoIcons.star_fill),
                                  ],
                                ),
                              ),
                              TextView(
                                  text: '${widget.advert.age} años',
                                  fontWeight: FontWeight.bold,
                                  color:
                                      const Color.fromARGB(155, 255, 255, 255),
                                  fontSize: 12),
                              const TextView(
                                  text: '24 horas',
                                  color: Colors.white,
                                  fontSize: 12),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Divider(
                          indent: 50,
                          color: Color.fromARGB(185, 255, 255, 255),
                          thickness: 0.7,
                        ),
                      ],
                    ),
                    isExpanded: _isExpanded,
                    body: Column(
                      children: [
                        if (widget.advert.adTags != null &&
                            widget.advert.adTags!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Wrap(
                              spacing: 8,
                              runSpacing: isLargeScreen ? 8 : -2.5,
                              children: widget.advert.adTags!.map((tag) {
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
                              top: 15, left: 35, right: 35, bottom: 15),
                          child: TextView(
                            text: widget.advert.description,
                            fontSize: 16,
                            color: Colors.white,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            CustomButton(
              text: formatPhoneNumber(widget.advert.phoneNumber),
              borderRadius: 15,
              fontSize: 20,
              height: 55,
              width: 250,
              onPressed: () async {
                if (!kIsWeb) {
                  final Uri url = Uri(
                      scheme: 'tel',
                      path: formatPhoneNumber(widget.advert.phoneNumber));
                  if (await canLaunchUrl(url)) {
                    launchUrl(url);
                  } else {
                    const Center(
                        child: TextView(
                      text: ' cannot launch assigned value ',
                      color: Colors.white,
                    ));
                  }
                } else {
                  Clipboard.setData(ClipboardData(
                      text: formatPhoneNumber(widget.advert.phoneNumber)));
                  showCopiedNumber(context);
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  showCopiedNumber(context) => showDialog(
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
                  text: 'El número de teléfono se ha copiado al portapapeles.',
                  color: Colors.white,
                ),
                hasButton: false,
              );
            },
          );
        },
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
