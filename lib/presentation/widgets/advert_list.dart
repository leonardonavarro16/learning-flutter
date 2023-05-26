import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swc_front/data/models/advert.dart';
import 'package:swc_front/presentation/widgets/utils/custom_button.dart';
import 'package:swc_front/presentation/widgets/utils/text_view.dart';
import 'utils/base_modal.dart';
import 'package:swc_front/presentation/widgets/utils/image_swiper.dart';

class AdverList extends StatelessWidget {
  int colsPerRow = 0;
  double colsWidth = 0;
  int rowsCount = 0;
  BoxConstraints constraints = const BoxConstraints();
  final double spaceBetweenCols;
  final List<Advert> adverts;
  AdverList({
    super.key,
    required this.adverts,
    this.spaceBetweenCols = 10,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      setConstraints(constraints);
      return SizedBox(
        width: constraints.maxWidth,
        child: Table(
          children: generateTableRows(constraints),
        ),
      );
    });
  }

  List<TableRow> generateTableRows(BoxConstraints constraints) {
    List<TableRow> tableRows = [];
    colsPerRow = calculateColsPerRow();
    colsWidth = calculateColsWidth();
    rowsCount = calculateRowsCount();

    for (int rowIndex = 0; rowIndex < rowsCount; rowIndex++) {
      List<Widget> advertPreviews = generateTableRow(rowIndex);
      while (advertPreviews.length < colsPerRow) {
        advertPreviews.add(Container());
      }

      tableRows.add(TableRow(
        children: advertPreviews,
      ));
    }
    return tableRows;
  }

  List<Widget> generateTableRow(int rowIndex) {
    bool lastRow = rowsCount - 1 == rowIndex;
    int endIndex = lastRow ? adverts.length : colsPerRow * (rowIndex + 1);
    List<Advert> rowAdverts =
        adverts.getRange(rowIndex * colsPerRow, endIndex).toList();
    return List<Widget>.of(rowAdverts.map((Advert advert) {
      return _AdvertPreview(width: colsWidth, advert: advert);
    }));
  }

  int calculateColsPerRow() {
    if (constraints.maxWidth <= 300) {
      return 1;
    } else if (constraints.maxWidth <= 600) {
      return 2;
    } else if (constraints.maxWidth <= 800) {
      return 3;
    } else if (constraints.maxWidth <= 1000) {
      return 4;
    } else if (constraints.maxWidth <= 1200) {
      return 5;
    } else {
      return 6;
    }
  }

  int calculateRowsCount() {
    if (colsPerRow == 0) return 0;
    return (adverts.length / colsPerRow).ceil();
  }

  double calculateColsWidth() {
    if (colsPerRow == 0) return 0;
    return (constraints.maxWidth - (2 * colsPerRow * spaceBetweenCols)) /
        colsPerRow;
  }

  void setConstraints(BoxConstraints cons) {
    constraints = cons;
  }
}

class _AdvertPreview extends StatelessWidget {
  final double width;
  final Advert advert;

  const _AdvertPreview({required this.width, required this.advert});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BaseModal.open(context: context, children: [
          _buildModalOpenedContent(context),
        ]);
      },
      child: _buildModalClosedContent(),
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

  Widget _buildModalOpenedContent(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Column(
          children: [
            if (advert.images.length == 1)
              SizedBox(
                height: screenHeight,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Image.memory(advert.images.first, fit: BoxFit.cover),
                  ],
                ),
              ),
            if (advert.images.length > 1)
              FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: ImageSlider(
                    images: advert.images,
                  ),
                ),
              ),
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: screenHeight * 0.33,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
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
                            text: advert.name,
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
                      Row(
                        children: const [
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
                        text: '${advert.age} años',
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
                Container(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 35,
                    right: 35,
                    bottom: 15,
                  ),
                  child: TextView(
                    text: advert.description,
                    fontSize: 12,
                    color: Colors.white,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 15),
                CustomButton(
                  text: formatPhoneNumber(advert.phoneNumber),
                  borderRadius: 15,
                  fontSize: 20,
                  height: 55,
                  width: 250,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildModalClosedContent() {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Center(
        child: SizedBox(
          width: width,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: advert.images.isEmpty
                    ? Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZNQZI9chyqtlvn6KNfid_ACsf4O-NiKn9Cw&usqp=CAU')
                    : Image.memory(advert.images.first),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
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
                          TextView(
                            text: advert.name,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          Row(
                            children: const [
                              TextView(
                                text: '4.5',
                                color: Color.fromARGB(155, 255, 255, 255),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(width: 2.5),
                              Icon(
                                  color: Colors.white,
                                  size: 9,
                                  CupertinoIcons.star_fill),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
