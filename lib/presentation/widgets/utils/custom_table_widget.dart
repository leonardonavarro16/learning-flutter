import 'package:flutter/material.dart';
import 'package:swc_front/presentation/widgets/utils/offers_plan_container.dart';

class CustomTableWidget extends StatelessWidget {
  final List<Widget> widgets; // Lista de funciones que generan los widgets
  int colsPerRow = 0;
  double colsWidth = 0;
  int rowsCount = 0;
  final double spaceBetweenCols;
  final int itemsPerPage;
  BoxConstraints constraints = const BoxConstraints();
  int currentPage = 0;

  CustomTableWidget({
    Key? key,
    required this.widgets,
    this.spaceBetweenCols = 10,
    this.itemsPerPage = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        setConstraints(constraints);
        return Column(
          children: [
            SizedBox(
              width: constraints.maxWidth,
              child: Table(
                children: generateTableRows(constraints),
              ),
            ),
          ],
        );
      },
    );
  }

  List<TableRow> generateTableRows(BoxConstraints constraints) {
    List<TableRow> tableRows = [];
    colsPerRow = calculateColsPerRow();
    colsWidth = calculateColsWidth();
    rowsCount = calculateRowsCount();

    int startIndex = currentPage * itemsPerPage;
    int endIndex = (currentPage + 1) * itemsPerPage;
    endIndex = endIndex > widgets.length ? widgets.length : endIndex;

    for (int rowIndex = startIndex ~/ colsPerRow;
        rowIndex < (endIndex - 1) ~/ colsPerRow + 1;
        rowIndex++) {
      List<Widget> widgetPreviews = generateTableRow(rowIndex);
      while (widgetPreviews.length < colsPerRow) {
        widgetPreviews.add(Container());
      }

      tableRows.add(TableRow(
        children: widgetPreviews,
      ));
    }
    return tableRows;
  }

  List<Widget> generateTableRow(int rowIndex) {
    bool lastRow = rowsCount - 1 == rowIndex;
    int endIndex = lastRow ? widgets.length : colsPerRow * (rowIndex + 1);
    List<Widget> rowWidgets =
        widgets.getRange(rowIndex * colsPerRow, endIndex).map((widgetBuilder) {
      return OfferPlanPreview(
        width: colsWidth,
        widgetBuilder: widgetBuilder,
      );
    }).toList();
    return rowWidgets;
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
    return (widgets.length / colsPerRow).ceil();
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

class OfferPlanPreview extends StatelessWidget {
  final double width;
  final Widget widgetBuilder;

  const OfferPlanPreview({
    Key? key,
    required this.width,
    required this.widgetBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Center(
        child: SizedBox(
          width: width,
          child: widgetBuilder,
        ),
      ),
    );
  }
}
