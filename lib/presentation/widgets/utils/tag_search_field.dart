import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swc_front/presentation/widgets/utils/base_text_form_field.dart';

class TagSearchField extends StatelessWidget {
  final List<String>? tags;
  final Function(String)? onSearch;
  final int minLength;

  const TagSearchField({
    Key? key,
    this.tags,
    this.onSearch,
    this.minLength = 3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseTextFormField(
      decoration: const InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        prefixIcon: Icon(
          CupertinoIcons.search,
          color: Colors.grey,
        ),
        filled: true,
        fillColor: Colors.white,
        labelText: 'Search tags: (3 characters minimum)',
      ),
      onChange: (value, isvalid) {
        if (value!.length >= minLength) {
          onSearch?.call(value);
        } else {
          onSearch?.call('');
        }
      },
    );
  }
}
