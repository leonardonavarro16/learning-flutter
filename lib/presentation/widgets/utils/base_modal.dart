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
    return Align(
      alignment: Alignment.bottomCenter,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.92,
          child: AlertDialog(
            title: title,
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
      ),
    );
  }
}
