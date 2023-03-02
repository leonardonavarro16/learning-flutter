import 'package:flutter/material.dart';

class BaseModal extends StatelessWidget {
  static Future<void> open({ required BuildContext context, required List<Widget> children, Widget? title }) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return BaseModal(title: title, children: children);
      },
    );
  }

  final Widget? title;
  final List<Widget> children;
  const BaseModal({super.key, this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: title,
      children: children,
    );
  }
}