import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swc_front/presentation/widgets/utils/base_text_form_field.dart';
import 'package:swc_front/presentation/widgets/utils/tag_search_field.dart';
import 'package:swc_front/presentation/widgets/utils/text_view.dart';

class TagSelectorField extends StatefulWidget {
  final List<String> adTags;
  final void Function(String?, bool) onChange;

  const TagSelectorField(
      {Key? key, required this.adTags, required this.onChange});

  @override
  State<TagSelectorField> createState() => _TagSelectorFieldState();
}

class _TagSelectorFieldState extends State<TagSelectorField> {
  String? selectedTagsText;
  List<String> selectedChips = [];
  List<String>? tagsFilter;
  String? searchQuery;

  Widget build(BuildContext context) {
    return Column(
      children: [
        BaseTextFormField(
          maxLines: 5,
          decoration: InputDecoration(
            counter: TextView(
              text: ' # selected: ${selectedChips.length.toString()}',
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            hintText: selectedChips.isNotEmpty
                ? 'Tags: #$selectedTagsText'
                : 'Selección de tags:',
            border: const OutlineInputBorder(),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            prefixIcon: const Icon(
              Icons.tag,
              color: Colors.grey,
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          onChange: widget.onChange,
        ),
        const SizedBox(
          height: 15,
        ),
        TagSearchField(
          tags: widget.adTags,
          onSearch: handleSearch,
        ),
        const SizedBox(
          height: 15,
        ),
        if (selectedChips.isEmpty)
          const TextView(
            fontSize: 14,
            text: 'Sugerencias:',
            textAlign: TextAlign.center,
            color: Colors.white,
          ),
        if (tagsFilter != null && tagsFilter!.isEmpty)
          const TextView(
            fontSize: 14,
            text: 'Sorry! No tags found.',
            textAlign: TextAlign.center,
            color: Colors.white,
          ),
        Padding(
          padding: EdgeInsets.only(
              top: selectedChips.isEmpty ? 10 : 0, right: 10, left: 10),
          child: Wrap(
            spacing: 8,
            runSpacing: 2,
            children: buildFilterChips(),
          ),
        ),
      ],
    );
  }

  List<Widget> buildFilterChips() {
    final List<String> tagsToDisplay = tagsFilter ?? widget.adTags;

    return tagsToDisplay.map((tag) {
      return FilterChip(
        selectedColor: const Color(0xFFFF0000),
        backgroundColor: const Color.fromARGB(187, 247, 83, 83),
        label: Text(
          '#$tag',
          style: const TextStyle(color: Colors.white),
        ),
        selected: selectedChips.contains(tag),
        onSelected: (bool value) {
          handleChipSelection(value, tag);
        },
      );
    }).toList();
  }

  void handleSearch(String value) {
    setState(() {
      searchQuery = value.toLowerCase();
      tagsFilter = widget.adTags
          .where((tag) => tag.toLowerCase().contains(searchQuery!))
          .toList();
    });
  }

  void handleChipSelection(bool isSelected, String tag) {
    setState(() {
      if (isSelected) {
        selectedChips.add(tag);
      } else {
        selectedChips.remove(tag);
      }
      selectedTagsText = selectedChips.join(', ');
    });
  }
}
