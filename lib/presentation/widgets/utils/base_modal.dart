import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseModal extends StatelessWidget {
  static Future<void> open(
      {required BuildContext context,
      required List<Widget> children,
      Widget? title}) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return BaseModal(
          title: title,
          children: children,
        );
      },
    );
  }

  final Widget? title;
  final List<Widget> children;

  const BaseModal({Key? key, this.title, required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AlertDialog(
            title: title,
            content: SingleChildScrollView(
              child: ListBody(children: children),
            ),
            contentPadding: EdgeInsets.zero,
            insetPadding: const EdgeInsets.all(0),
            backgroundColor: Colors.transparent,
          ),
        ),
        Positioned(
          top: 20,
          right: 30,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              CupertinoIcons.xmark_square_fill,
              size: 50,
              shadows: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 2), blurRadius: 5.0)
              ],
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
