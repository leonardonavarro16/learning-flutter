import 'package:flutter/material.dart';

class AdverList extends StatelessWidget {
  final int colsPerRow;
  final double spaceBetweenCols;
  const AdverList({super.key, this.colsPerRow = 6, this.spaceBetweenCols = 10});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      double colsWidth =
          (constraints.maxWidth - (2 * colsPerRow * spaceBetweenCols)) /
              colsPerRow;
      return SizedBox(
        width: constraints.maxWidth,
        child: Table(
          // border: TableBorder.all(
          //   color: Colors.green,
          // ),
          children: <TableRow>[
            TableRow(
              children: [
                _AccountPreview(width: colsWidth),
                _AccountPreview(width: colsWidth),
                _AccountPreview(width: colsWidth),
                _AccountPreview(width: colsWidth),
                _AccountPreview(width: colsWidth),
                _AccountPreview(width: colsWidth),
              ],
            ),
          ],
        ),
      );
    });
  }
}

class _AccountPreview extends StatelessWidget {
  final double width;

  const _AccountPreview({required this.width});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            decoration: BoxDecoration(
                color: Colors.purple, borderRadius: BorderRadius.circular(10)),
            width: width,
            child: Column(
              children: [
                Image.network(
                  'https://cdni.pornpics.de/460/7/518/39935848/39935848_050_0044.jpg',
                ),
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text('I´m tintiwinky '),
                ),
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text('i have 23 years old '),
                ),
              ],
            )));
  }
}
