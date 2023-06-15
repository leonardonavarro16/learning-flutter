import 'package:flutter/material.dart';
import 'package:swc_front/presentation/widgets/utils/text_view.dart';

class PaginationRow extends StatelessWidget {
  final int currentPageIndex;
  final int decreasedCurrentPageIndex;
  final int increasedCurrentPageIndex;
  final Function() onPreviousPage;
  final Function() onNextPage;

  const PaginationRow({
    required this.currentPageIndex,
    required this.decreasedCurrentPageIndex,
    required this.increasedCurrentPageIndex,
    required this.onPreviousPage,
    required this.onNextPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: onPreviousPage,
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 18, 18, 18),
              borderRadius: BorderRadius.circular(10),
            ),
            height: 40,
            width: 40,
            child: const Icon(
              size: 20,
              color: Colors.white,
              Icons.arrow_back_ios_rounded,
            ),
          ),
        ),
        const SizedBox(width: 10),
        if (decreasedCurrentPageIndex > 0)
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 18, 18, 18),
              borderRadius: BorderRadius.circular(10),
            ),
            height: 40,
            width: 40,
            child: Align(
              alignment: Alignment.center,
              child: TextView(
                fontWeight: FontWeight.bold,
                text: '$decreasedCurrentPageIndex',
                color: Colors.white,
              ),
            ),
          ),
        const SizedBox(width: 10),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFFF0000), width: 2),
            color: const Color.fromARGB(255, 18, 18, 18),
            borderRadius: BorderRadius.circular(10),
          ),
          height: 40,
          width: 40,
          child: Align(
            alignment: Alignment.center,
            child: TextView(
              fontWeight: FontWeight.bold,
              text: '$currentPageIndex ',
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 10),
        if (increasedCurrentPageIndex > 0)
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 18, 18, 18),
              borderRadius: BorderRadius.circular(10),
            ),
            height: 40,
            width: 40,
            child: Align(
              alignment: Alignment.center,
              child: TextView(
                fontWeight: FontWeight.bold,
                text: '$increasedCurrentPageIndex',
                color: Colors.white,
              ),
            ),
          ),
        const SizedBox(width: 10),
        InkWell(
          onTap: onNextPage,
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 18, 18, 18),
              borderRadius: BorderRadius.circular(10),
            ),
            height: 40,
            width: 40,
            child: const Icon(
              size: 20,
              color: Colors.white,
              Icons.arrow_forward_ios_rounded,
            ),
          ),
        ),
      ],
    );
  }
}
