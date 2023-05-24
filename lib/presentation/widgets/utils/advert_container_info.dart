import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swc_front/data/models/advert.dart';
import 'package:swc_front/presentation/widgets/utils/custom_button.dart';
import 'package:swc_front/presentation/widgets/utils/text_view.dart';

class AdvertContentInfo extends StatelessWidget {
  final Advert advert;
  final String location;
  final String availability;
  final String rate;
  const AdvertContentInfo(
      {super.key,
      required this.advert,
      this.location = 'Barranquilla',
      this.availability = '24 horas',
      this.rate = '4.5'});

  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          gradient: LinearGradient(
            colors: [
              Colors.black,
              Color(0xFFFF0000),
            ],
            begin: Alignment.center,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                        text: advert.name,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    TextView(
                      text: location,
                      color: const Color.fromARGB(155, 255, 255, 255),
                      fontSize: 10,
                    ),
                  ],
                ),
                Row(
                  children: [
                    TextView(
                      text: rate,
                      color: const Color.fromARGB(155, 255, 255, 255),
                      fontSize: 12,
                    ),
                    const SizedBox(width: 2.5),
                    const Icon(
                        color: Colors.yellow,
                        size: 10,
                        CupertinoIcons.star_fill),
                  ],
                ),
                TextView(
                  text: '${advert.age} años',
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(155, 255, 255, 255),
                  fontSize: 10,
                ),
                TextView(
                  text: availability,
                  color: Colors.white,
                  fontSize: 10,
                ),
              ],
            ),
            const Divider(
              color: Color.fromARGB(155, 255, 255, 255), //color of divider
              height: 10,
              thickness: 1,
              indent: 35,
              endIndent: 25,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextView(
                  text: advert.description,
                  fontSize: 10.5,
                  color: Colors.white,
                  textAlign: TextAlign.center),
            ),
            const SizedBox(height: 15),
            CustomButton(
              height: 60,
              width: 170,
              text: formatPhoneNumber(advert.phoneNumber),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

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
