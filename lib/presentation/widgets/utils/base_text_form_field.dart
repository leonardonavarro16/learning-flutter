import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseTextFormField extends StatefulWidget {
  final Function(String?, bool) onChange;
  final Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final InputDecoration? decoration;
  final int maxLines;
  final int? minLines;
  final String? fieldValue;
  final bool obscureText;
  final TextAlign? textAlign;
  final void Function(String)? onFieldSubmitted;
  final bool readOnly;
  const BaseTextFormField({
    super.key,
    required this.onChange,
    this.validator,
    this.inputFormatters,
    this.keyboardType,
    this.decoration,
    this.maxLines = 1,
    this.minLines,
    this.fieldValue,
    this.obscureText = false,
    this.onFieldSubmitted,
    this.readOnly = false,
    this.textAlign,
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
    InputDecoration defaultDecoration = _buildDefaultDecoration();

    return TextFormField(
      textAlign: widget.textAlign ?? TextAlign.start,
      readOnly: widget.readOnly,
      // style: GoogleFonts.quicksand(),
      style: const TextStyle(fontFamily: 'SanFrancisco'),
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      controller: _controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      decoration: widget.decoration == null
          ? defaultDecoration
          : widget.decoration!.copyWith(
              border: widget.decoration?.border ?? defaultDecoration.border,
              enabledBorder: widget.decoration?.enabledBorder ??
                  defaultDecoration.enabledBorder,
              focusedBorder: widget.decoration?.focusedBorder ??
                  defaultDecoration.focusedBorder,
              errorBorder: widget.decoration?.errorBorder ??
                  defaultDecoration.errorBorder,
              focusedErrorBorder: widget.decoration?.focusedErrorBorder ??
                  defaultDecoration.focusedErrorBorder,
              errorText: _getErrorText(_controller.text),
            ),
      validator: _getErrorText,
      inputFormatters: widget.inputFormatters,
      onFieldSubmitted: widget.onFieldSubmitted,
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
    if (widget.validator == null) {
      return null;
    } else {
      return widget.validator!(value);
    }
  }

  InputDecoration _buildDefaultDecoration() {
    OutlineInputBorder defaultBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(
        width: 1,
        color: Color(0xFFFF0000),
      ),
    );

    return InputDecoration(
      border: defaultBorder,
      enabledBorder: defaultBorder,
      focusedBorder: defaultBorder,
      errorBorder: defaultBorder,
      focusedErrorBorder: defaultBorder,
      errorText: _getErrorText(_controller.text),
    );
  }
}
