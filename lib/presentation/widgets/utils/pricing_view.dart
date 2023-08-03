import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swc_front/presentation/widgets/utils/text_view.dart';

class PricingView extends StatefulWidget {
  const PricingView({
    super.key,
  });

  @override
  State<PricingView> createState() => _PricingViewState();
}

class _PricingViewState extends State<PricingView> {
  int selectedCardIndex = 0;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double desktopScreen = screenWidth * 0.32;
    double mobileScreen = screenWidth * 0.6;
    double desiredWidth = screenWidth > 800 ? desktopScreen : mobileScreen;
    bool isLargeScreen = screenWidth > 800;
    return SingleChildScrollView(
      child: Column(
        children: [
          const Center(
            child: TextView(
              text: 'Choose your membership type',
              color: Color(0xFFFF0000),
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.40,
            // width: desiredWidth,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1,
                mainAxisExtent: 180,
                // mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                crossAxisCount: 2,
              ),
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return OfferContentWidget(
                    timeText: '',
                    offerText: 'FREE',
                    onTap: () {
                      setState(() {
                        selectedCardIndex = index;
                      });
                    },
                    isSelected: selectedCardIndex == index,
                  );
                }
                return OfferContentWidget(
                  timeText: '12 MONTHS MEMBERSHIP',
                  offerText: '9.99 /MONTH',
                  isSelected: selectedCardIndex == index,
                  onTap: () {
                    setState(() {
                      selectedCardIndex = index;
                    });
                  },
                );
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          if (selectedCardIndex == 0)
            // const Center(
            //   child: TextView(
            //     text:
            //         'Opción FREE seleccionada: El dicho sabio es una urna de masculinidad, y el importante caído es un posadero. El vehículo, el rostro con cuello o, menos urgente, es desagradable, y la virtud del faro debe ser odiada por mi esposo. Un lago y la plaza pueden haber perdido el momento de beber. ',
            //     color: Colors.white,
            //   ),
            // ),
            if (selectedCardIndex != 0)
              Center(
                child: TextView(
                  text:
                      'Opción $selectedCardIndex seleccionado: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed dictum sapien eu urna malesuada, quis volutpat elit posuere. Quisque vehicula, eros at tristique dignissim, justo urna fermentum nisl, vel pharetra velit odio eu metus. Aenean eu urna et velit tristique interdum. Nulla facilisi. Etiam vestibulum ligula ut nulla fermentum, nec varius metus dictum. Nam cursus dapibus erat, non tincidunt mi fermentum in.',
                  color: Colors.white,
                ),
              ),
        ],
      ),
    );
  }
}

class OfferContentWidget extends StatefulWidget {
  final String? timeText;
  final String? offerText;
  final bool isSelected;
  final VoidCallback onTap;

  OfferContentWidget({
    Key? key,
    this.timeText,
    this.offerText,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  State<OfferContentWidget> createState() => _OfferContentWidgetState();
}

class _OfferContentWidgetState extends State<OfferContentWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 12.5, right: 12.5),
        child: Container(
          child: Card(
            color: widget.isSelected
                ? const Color.fromARGB(255, 138, 0, 0)
                : Color.fromARGB(255, 35, 35, 35),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(
                color: widget.isSelected ? Colors.amber : Colors.transparent,
                width: 2.0,
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                TextView(
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                  text: widget.timeText ?? '12 MONTHS MEMBERSHIP',
                ),
                const SizedBox(
                  height: 10,
                ),
                TextView(
                  fontSize: 30,
                  text: widget.offerText ?? '9.99 /MONTH',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.amber,
                    child: Icon(
                      CupertinoIcons.cart_fill,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
