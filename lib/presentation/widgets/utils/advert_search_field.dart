import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdvertSearchField extends StatefulWidget {
  final Function(String, bool)? onChange;
  final String? searchText;
  final int debounce;

  const AdvertSearchField({
    Key? key,
    this.onChange,
    this.searchText,
    this.debounce = 1000,
  }) : super(key: key);

  @override
  State<AdvertSearchField> createState() => _AdvertSearchFieldState();
}

class _AdvertSearchFieldState extends State<AdvertSearchField> {
  late TextEditingController _textEditingController;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.searchText);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoSearchTextField(
      itemColor: Colors.white,
      controller: _textEditingController,
      style: const TextStyle(
        fontFamily: 'SanFrancisco',
        color: Color.fromARGB(207, 255, 255, 255),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color.fromARGB(255, 41, 41, 41),
      ),
      onChanged: (value) {
        if (widget.onChange == null) return;
        if (_timer != null && _timer!.isActive) _timer!.cancel();
        _timer = Timer(
          Duration(milliseconds: widget.debounce),
          () => widget.onChange!(value, true),
        );
      },
    );
  }
}
