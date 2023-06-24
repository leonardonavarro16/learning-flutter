import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swc_front/data/models/advert.dart';
import 'package:swc_front/logic/cubits/adverts.dart';
import 'package:swc_front/logic/cubits/authentication_cubit.dart';
import 'package:swc_front/presentation/widgets/utils/alert_dialog_custom.dart';
import 'package:swc_front/presentation/widgets/utils/base_text_form_field.dart';
import 'package:swc_front/presentation/widgets/utils/custom_button.dart';
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
  List<String>? tagsFilter;
  List<bool> isSelected = [
    true,
    false,
    false
  ]; // Valores iniciales predeterminados

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        children: const [
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
                  BaseTextFormField(
                    onChange: (value, _) {
                      setState(() {
                        ageFilter = value!.isNotEmpty ? int.parse(value) : null;
                      });
                    },
                    decoration: const InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      prefixIcon: Icon(
                        CupertinoIcons.tag_circle,
                        color: Colors.grey,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'tags',
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 1,
                      children: widget.adTags.map((tag) {
                        return Chip(
                          backgroundColor: const Color(0xFFFF0000),
                          label: TextView(
                            text: tag,
                            color: Colors.white,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    height: 30,
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

// Widget _buildFilterForm() {
//   return Column(
//     children: [
//       BaseTextFormField(
//         onChange: (value, _) {
//           setState(() {
//             nameFilter = value!.isNotEmpty ? value : null;
//           });
//         },
//         decoration: const InputDecoration(
//           floatingLabelBehavior: FloatingLabelBehavior.never,
//           prefixIcon: Icon(
//             CupertinoIcons.circle_grid_hex_fill,
//             color: Colors.grey,
//           ),
//           filled: true,
//           fillColor: Colors.white,
//           labelText: 'Name',
//         ),
//       ),
//       const SizedBox(
//         height: 15,
//       ),
//       // CustomRangeSlider(
//       //   onChanged: (value) {
//       //     setState(() {
//       //       ageFilter = value ? int.parse(value) : null;
//       //     });
//       //   },
//       // ),
//       // BaseTextFormField(
//       //   onChange: (value, _) {
//       //     setState(() {
//       //       ageFilter = value!.isNotEmpty ? int.parse(value) : null;
//       //     });
//       //   },
//       //   keyboardType: TextInputType.number,
//       //   decoration: const InputDecoration(
//       //     floatingLabelBehavior: FloatingLabelBehavior.never,
//       //     prefixIcon: Icon(
//       //       CupertinoIcons.person,
//       //       color: Colors.grey,
//       //     ),
//       //     filled: true,
//       //     fillColor: Colors.white,
//       //     labelText: 'Age',
//       //   ),
//       // ),
//       const SizedBox(
//         height: 15,
//       ),
//       BaseTextFormField(
//         onChange: (value, _) {
//           setState(() {
//             ageFilter = value!.isNotEmpty ? int.parse(value) : null;
//           });
//         },
//         decoration: const InputDecoration(
//           floatingLabelBehavior: FloatingLabelBehavior.never,
//           prefixIcon: Icon(
//             CupertinoIcons.tag_circle,
//             color: Colors.grey,
//           ),
//           filled: true,
//           fillColor: Colors.white,
//           labelText: 'tags',
//         ),
//       ),
//       const SizedBox(
//         height: 30,
//       ),
//       // Tags filter implementation goes here
//       CustomButton(
//         text: 'Apply Filters',
//         onPressed: () {
//           // Call the method to apply the filters and perform the search
//           _applyFilters();
//           Navigator.pop(context);
//         },
//       ),
//     ],
//   );
// }

//   void _applyFilters() {
//     // Call the method to fetch the filtered data using the filters (nameFilter, ageFilter, tagsFilter)
//     // For example:
//     List<Advert> filteredAdverts =
//         fetchFilteredAdverts(nameFilter, ageFilter, tagsFilter);

//     // Update the UI with the filtered data (e.g., using a callback function)
//     // For example:
//     widget.onFiltersApplied(filteredAdverts);
//   }
// }

// // Implement the fetchFilteredAdverts method according to your data source and filtering logic
// List<Advert> fetchFilteredAdverts(
//     String? nameFilter, int? ageFilter, List<String>? tagsFilter) {
//   // Retrieve the adverts based on the provided filters
//   // Apply the filters to your data source (e.g., API call or local list)

//   // Return the filtered list of adverts
//   // For example:
//   List<Advert> filteredAdverts = []; // Placeholder for filtered adverts
//   // Apply the filters to your data and populate filteredAdverts

//   return filteredAdverts;
// }
