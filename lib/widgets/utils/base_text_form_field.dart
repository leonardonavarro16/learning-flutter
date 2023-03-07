import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swc_front/widgets/utils/description_form.dart';

class BaseTextFormField extends StatefulWidget {
  final Function onChange;
  final Function(String?)? getErrorText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final InputDecoration? decoration;
  final int? maxLines;
  final int? minLines;
  final String? fieldValue;
  const BaseTextFormField({
    super.key,
    required this.onChange,
    this.getErrorText,
    this.inputFormatters,
    this.keyboardType,
    this.decoration,
    this.maxLines,
    this.minLines,
    this.fieldValue,
  });

  @override
  State<BaseTextFormField> createState() => _BaseTextFormField();
}

class _BaseTextFormField extends State<BaseTextFormField> {
  final TextEditingController _controller = TextEditingController();
  bool _touched = false;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.fieldValue ?? '';
    _controller.addListener(_onChange);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      controller: _controller,
      keyboardType: widget.keyboardType,
      decoration: widget.decoration == null
          ? InputDecoration(errorText: _getErrorText(_controller.text))
          : widget.decoration!.copyWith(
              errorText: _getErrorText(_controller.text),
            ),
      validator: _getErrorText,
      inputFormatters: widget.inputFormatters,
    );
  }

  void _onChange() {
    setState(() {
      _touched = true;
      String value = _controller.text;
      widget.onChange(value, _isValid());
    });
  }

  bool _isValid() => null == _getErrorText(_controller.text);

  String? _getErrorText(String? value) {
    if (!_touched) return null;
    if (widget.getErrorText == null) {
      return null;
    } else {
      return widget.getErrorText!(value);
    }
  }
}
