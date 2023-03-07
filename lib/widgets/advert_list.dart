import 'package:flutter/material.dart';
import 'package:swc_front/models/advert.dart';

import 'utils/base_modal.dart';

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
          // border: TableBorder.all(
          //   color: Colors.green,
          // ),
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
        BaseModal.open(
            context: context,
            title: Text(advert.user.name, textAlign: TextAlign.center),
            children: [
              _buildModalOpenedContent(),
            ]);
      },
      child: _buildModalClosedContent(),
    );
  }

  Widget _buildModalOpenedContent() {
    return Center(
      child: SizedBox(
        width: width,
        child: Column(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: advert.image,
          ),
          Text(advert.user.description, textAlign: TextAlign.center),
          const SizedBox(height: 10),
          Text(advert.user.phoneNumber)
        ]),
      ),
    );
  }

  Widget _buildModalClosedContent() {
    return Center(
        child: SizedBox(
            width: width,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: advert.image,
                ),
                Text(advert.user.name,
                    style: const TextStyle(color: Colors.white)),
                Text(advert.user.desiredAge.toString(),
                    style: const TextStyle(color: Colors.white)),
              ],
            )));
  }
}
