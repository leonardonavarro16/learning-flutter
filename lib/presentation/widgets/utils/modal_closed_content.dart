import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marquee_text/marquee_text.dart';
import 'package:swc_front/data/models/advert.dart';
import 'package:swc_front/presentation/widgets/utils/text_view.dart';

class ModalClosedContainerContent extends StatelessWidget {
  final Advert advert;

  const ModalClosedContainerContent({super.key, required this.advert});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: MarqueeText(
                  speed: 10,
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    text: advert.name,
                  ),
                ),
              ),
              const Row(
                children: [
                  TextView(
                    text: '4.5',
                    color: Color.fromARGB(155, 255, 255, 255),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(width: 2.5),
                  Icon(color: Colors.white, size: 9, CupertinoIcons.star_fill),
                ],
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const TextView(
                text: 'Barranquilla',
                color: Color.fromARGB(155, 255, 255, 255),
                fontSize: 10,
              ),
              TextView(
                text: '${advert.age} años',
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 10,
              ),
              const TextView(
                text: '24 horas',
                color: Color.fromARGB(155, 255, 255, 255),
                fontSize: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
