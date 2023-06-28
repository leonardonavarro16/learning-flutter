import 'package:flutter/cupertino.dart';

class AdvertSearchField extends StatefulWidget {
  final Function(String, bool) onChange;
  final String? searchText;

  const AdvertSearchField({
    Key? key,
    required this.onChange,
    this.searchText,
  }) : super(key: key);

  @override
  _AdvertSearchFieldState createState() => _AdvertSearchFieldState();
}

class _AdvertSearchFieldState extends State<AdvertSearchField> {
  late TextEditingController _textEditingController;

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
      controller: _textEditingController,
      style: const TextStyle(
        fontFamily: 'SanFrancisco',
        color: Color.fromARGB(207, 255, 255, 255),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color.fromARGB(255, 20, 20, 20),
      ),
      onChanged: (value) {
        if (widget.onChange != null) {
          widget.onChange(value, true);
        }
      },
    );
  }
}
