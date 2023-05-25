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
        return BaseModal(title: title, children: children);
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
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: AlertDialog(
            title: title,
            // todo: change this propertie in order to dont allow to be scrolleable!
            content: SingleChildScrollView(
              child: ListBody(children: children),
            ),
            contentPadding: EdgeInsets.zero,
            insetPadding: const EdgeInsets.all(0),
            actionsPadding: const EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
        Positioned(
          top: 16,
          right: 16,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              CupertinoIcons.xmark_square_fill,
              shadows: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 2), blurRadius: 5.0)
              ],
              size: 45,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
