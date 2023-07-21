import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swc_front/data/models/advert.dart';
import 'package:swc_front/presentation/widgets/utils/base_text_form_field.dart';
import 'package:swc_front/presentation/widgets/utils/custom_button.dart';
import 'package:swc_front/presentation/widgets/utils/tag_selector_field.dart';
import 'package:swc_front/presentation/widgets/utils/text_view.dart';
// import 'package:swc_front/presentation/widgets/utils/custom_range_slider.dart';

class FilterWidget extends StatefulWidget {
  final List<String> adTags;
  final List<Advert> adverts;

  const FilterWidget({
    Key? key,
    required this.adverts,
    required this.adTags,
  }) : super(key: key);

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  String? nameFilter;
  int? ageFilter;
  String? selectedTagsText;
  List<String> selectedChips = [];
  List<String>? tagsFilter;
  List<bool> isSelected = [
    true,
    false,
    false
  ]; // Valores iniciales predeterminados

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: const Row(
        children: [
          Icon(
            Icons.filter_alt_outlined,
            color: Colors.white,
            size: 30,
          ),
          SizedBox(
            width: 5,
          ),
          TextView(
            fontSize: 16,
            text: 'Filtrar',
            color: Colors.white,
            fontWeight: FontWeight.bold,
          )
        ],
      ),
      onTap: () => showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 76, 5, 0),
                  Color.fromARGB(255, 0, 0, 0),
                ],
                stops: [
                  0.2,
                  1,
                ],
                begin: Alignment.center,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(45),
              ),
            ),
            height: 500,
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            color: Colors.white,
                            CupertinoIcons.xmark,
                            size: 18,
                          )),
                      CustomButton(
                        width: 120,
                        height: 35,
                        text: 'Apply Filters',
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  const TextView(
                    fontSize: 18,
                    textAlign: TextAlign.left,
                    text: 'Sort adverts by',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: ToggleButtons(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      borderColor: Colors.white,
                      selectedBorderColor: Colors.white,
                      selectedColor: Colors.white,
                      fillColor: const Color(0xFFFF0000),
                      color: Colors.red[400],
                      constraints: const BoxConstraints(
                        minHeight: 40.0,
                        minWidth: 80.0,
                      ),
                      isSelected: isSelected,
                      onPressed: (int index) {
                        setState(() {
                          // The button that is tapped is set to true, and the others to false.
                          for (int i = 0; i < isSelected.length; i++) {
                            isSelected[i] = i == index;
                          }
                        });
                      },
                      children: const [
                        TextView(
                          fontWeight: FontWeight.bold,
                          text: 'Recent',
                          color: Colors.white,
                        ),
                        TextView(
                          fontWeight: FontWeight.bold,
                          text: 'Rating',
                          color: Colors.white,
                        ),
                        TextView(
                          fontWeight: FontWeight.bold,
                          text: 'Relevance',
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  BaseTextFormField(
                    onChange: (value, _) {
                      setState(() {
                        nameFilter = value!.isNotEmpty ? value : null;
                      });
                    },
                    decoration: const InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      prefixIcon: Icon(
                        CupertinoIcons.circle_grid_hex_fill,
                        color: Colors.grey,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Name',
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TagSelectorField(
                    adTags: widget.adTags,
                    onChange: (value, _) {
                      setState(() {
                        ageFilter = value!.isNotEmpty ? int.parse(value) : null;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
