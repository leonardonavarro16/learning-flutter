import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

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
  final void Function(String)? onFieldSubmitted;
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
    final double fontSize = MediaQuery.of(context).size.width * 0.02;
    // final double fontSize = 15;

    return TextFormField(
      style: GoogleFonts.quicksand(),
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      controller: _controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      decoration: widget.decoration == null
          ? InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.width * 0.03,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(
                  width: 1,
                  color: Color(0xFFFF0000),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(
                  width: 1,
                  color: Color(0xFFFF0000),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(
                  width: 1,
                  color: Color(0xFFFF0000),
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(
                  width: 1,
                  color: Color(0xFFFF0000),
                ),
              ),
              errorText: _getErrorText(_controller.text))
          : widget.decoration!.copyWith(
              border: const OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(
                  width: 1,
                  color: Color(0xFFFF0000),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(
                  width: 1,
                  color: Color(0xFFFF0000),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(
                  width: 1,
                  color: Color(0xFFFF0000),
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(
                  width: 1,
                  color: Color(0xFFFF0000),
                ),
              ),
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
}
