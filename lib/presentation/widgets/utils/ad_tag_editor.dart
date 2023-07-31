import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swc_front/presentation/widgets/utils/alert_dialog_custom.dart';
import 'package:swc_front/presentation/widgets/utils/base_text_form_field.dart';
import 'package:swc_front/presentation/widgets/utils/custom_button.dart';
import 'package:swc_front/presentation/widgets/utils/text_view.dart';

import 'package:flutter/services.dart';

class AdTagEditor extends StatefulWidget {
  final void Function(String)? onFieldSubmitted;
  final List<String>? tags;
  final Function(List<String>)? onTagsChanged;

  const AdTagEditor(
      {Key? key, this.tags, this.onTagsChanged, this.onFieldSubmitted})
      : super(key: key);

  @override
  _TagEditorWidgetState createState() => _TagEditorWidgetState();
}

class _TagEditorWidgetState extends State<AdTagEditor> {
  List<String> _tags = [];

  @override
  void initState() {
    super.initState();
    _tags = widget.tags ?? [];
  }

  void _addTag(String tag) {
    setState(() {
      _tags.add(tag);
    });
    _notifyTagsChanged();
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
    _notifyTagsChanged();
  }

  void _notifyTagsChanged() {
    if (widget.onTagsChanged != null) {
      widget.onTagsChanged!(_tags);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (_tags.isNotEmpty)
          const TextView(
            color: Colors.white,
            text: 'Tags:',
          ),
        SizedBox(
          height: _tags.isNotEmpty ? 15 : 0,
        ),
        Wrap(
          spacing: 8,
          runSpacing: 2,
          children: _tags.map((tag) {
            return Chip(
              backgroundColor: const Color(0xFFFF0000),
              label: TextView(
                text: tag,
                color: Colors.white,
              ),
              deleteIcon: const Icon(
                CupertinoIcons.xmark,
                color: Colors.white,
                size: 10,
              ),
              onDeleted: () {
                _removeTag(tag);
              },
            );
          }).toList(),
        ),
        SizedBox(
          height: _tags.isNotEmpty ? 15 : 0,
        ),
        Center(
          child: CustomButton(
            onPressed: () {
              _showAddTagDialog(context);
            },
            text: 'Agregar Tag',
          ),
        ),
      ],
    );
  }

  void _showAddTagDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        String newTag = '';
        return CustomAlertDialog(
          header: const TextView(
            text: 'Agregar Tag',
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          content: BaseTextFormField(
            onChange: (value, _) {
              newTag = value!;
            },
            decoration: const InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                prefixIcon: Icon(
                  CupertinoIcons.tag_circle,
                  color: Colors.grey,
                ),
                filled: true,
                fillColor: Colors.white,
                labelText: '# type a tag'),
          ),
          actions: [
            CustomButton(
              onPressed: () {
                Navigator.pop(context);
              },
              text: 'Cancelar',
            ),
            const SizedBox(
              width: 3.5,
            ),
            CustomButton(
              onPressed: () {
                if (newTag.isNotEmpty) {
                  _addTag(newTag);
                }
                Navigator.pop(context);
              },
              text: 'Agregar',
            ),
          ],
        );
      },
    );
  }
}
