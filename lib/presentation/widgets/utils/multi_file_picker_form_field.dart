import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:swc_front/presentation/widgets/utils/indicator_progress.dart';
import 'package:swc_front/presentation/widgets/utils/text_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MultiFilePickerField extends StatefulWidget {
  final void Function(List<Uint8List>) onChanged;

  const MultiFilePickerField({Key? key, required this.onChanged})
      : super(key: key);

  @override
  State<MultiFilePickerField> createState() => _MultiFilePickerField();
}

class _MultiFilePickerField extends State<MultiFilePickerField> {
  final FilePicker _filePicker = FilePicker.platform;
  FilePickerResult? result;
  bool isLoading = false;
  int _currentImageIndex = 0;
  final List<Uint8List> _pickedFiles = [];

  @override
  void dispose() async {
    if (!kIsWeb) await _filePicker.clearTemporaryFiles();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    AppLocalizations? t = AppLocalizations.of(context);
    if (t == null) throw Exception('AppLocalizations not found');
    if (isLoading) {
      return Column(
        children: const [
          SizedBox(height: 20),
          CustomIndicatorProgress(),
          SizedBox(height: 20),
        ],
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (_pickedFiles.isNotEmpty)
          TextView(
            text: t.advertPicturesLinkText,
            color: Colors.white,
            fontSize: 14,
          ),
        const SizedBox(height: 15),
        Stack(
          children: [
            Column(
              children: [
                if (_pickedFiles.isEmpty)
                  Column(children: [
                    _buildSelectFileBtn(),
                    const SizedBox(height: 10),
                    const TextView(
                      text: 'Selecciona una imagen para mostrar',
                      color: Color(0xFFFF0000),
                      fontWeight: FontWeight.bold,
                    )
                  ]),
                if (_pickedFiles.isNotEmpty)
                  CarouselSlider(
                    options: CarouselOptions(
                        // animateToClosest: true,
                        enableInfiniteScroll:
                            (_pickedFiles.length) >= 3 ? true : false,
                        autoPlay: false,
                        enlargeCenterPage: true,
                        aspectRatio: 1.4,
                        viewportFraction: 0.5,
                        onPageChanged: (index, _) {
                          setState(() {
                            _currentImageIndex = index;
                          });
                        }),
                    items: _pickedFiles.map((image) {
                      final int index = _pickedFiles.indexOf(image);
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(18.5),
                        child: index == 0
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(18.5),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Image.memory(
                                      image,
                                      fit: BoxFit.cover,
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        color: Colors.black.withOpacity(0.65),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        child: const Center(
                                            child: TextView(
                                          text: 'Portada del anuncio',
                                          color: Colors.white,
                                        )),
                                      ),
                                    ),
                                    const Positioned(
                                        top: 5,
                                        right: 5,
                                        child: Icon(
                                          shadows: [
                                            BoxShadow(
                                                color: Colors.black,
                                                offset: Offset(0, 2),
                                                blurRadius: 5.0)
                                          ],
                                          Icons.loyalty_rounded,
                                          color: Color(0xFFFF0000),
                                          size: 30,
                                        ))
                                  ],
                                ),
                              )
                            : Image.memory(
                                image,
                                fit: BoxFit.cover,
                              ),
                      );
                    }).toList(),
                  ),
                Positioned(
                  top: 50,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: _pickedFiles.isNotEmpty
                      ? DotsIndicator(
                          dotsCount: _pickedFiles.length,
                          position: _currentImageIndex,
                          decorator: DotsDecorator(
                            activeColor: Colors.white,
                            activeSize: const Size(7, 7),
                            color: Colors.grey[400]!,
                            size: const Size(4, 4),
                          ),
                        )
                      : const SizedBox(),
                ),
                const SizedBox(
                  height: 15,
                ),
                if (_pickedFiles.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildClearFileBtn(),
                      const SizedBox(width: 15),
                      _buildRemoveFileBtn(),
                      const SizedBox(width: 15),
                      _buildSelectFileBtn(),
                    ],
                  ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  void pickFile() async {
    try {
      setState(() {
        isLoading = true;
      });
      result = await _filePicker.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );
      Uint8List? bytes = result?.files.single.bytes;

      if (bytes != null) {
        _pickedFiles.add(bytes);
        widget.onChanged(_pickedFiles);
      }
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      print(error);
    }
  }

  void cleanFiles() {
    setState(() {
      _pickedFiles.clear();
    });
  }

  void _removeCurrentImage() {
    setState(() {
      _pickedFiles.removeAt(_currentImageIndex);
    });
  }

  Widget _buildSelectFileBtn() {
    return GestureDetector(
      onTap: pickFile,
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(50),
          ),
          color: const Color(0xFFFF0000),
          boxShadow: [
            BoxShadow(
              offset: const Offset(2, 4),
              color: Colors.black.withOpacity(0.3),
              blurRadius: 3,
            ),
          ],
        ),
        child: const Icon(
          CupertinoIcons.camera_fill,
          color: Colors.white,
          size: 30,
          shadows: [
            BoxShadow(
                color: Colors.black, offset: Offset(0, 2), blurRadius: 5.0)
          ],
        ),
      ),
    );
  }

  Widget _buildClearFileBtn() {
    return GestureDetector(
      onTap: cleanFiles,
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(50),
          ),
          color: const Color(0xFFFF0000),
          boxShadow: [
            BoxShadow(
              offset: const Offset(2, 4),
              color: Colors.black.withOpacity(0.3),
              blurRadius: 3,
            ),
          ],
        ),
        child: const Icon(
          CupertinoIcons.delete,
          color: Colors.white,
          size: 30,
          shadows: [
            BoxShadow(
                color: Colors.black, offset: Offset(0, 2), blurRadius: 5.0)
          ],
        ),
      ),
    );
  }

  Widget _buildRemoveFileBtn() {
    return GestureDetector(
      onTap: _removeCurrentImage,
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(50),
          ),
          color: const Color(0xFFFF0000),
          boxShadow: [
            BoxShadow(
              offset: const Offset(2, 4),
              color: Colors.black.withOpacity(0.3),
              blurRadius: 3,
            ),
          ],
        ),
        child: const Icon(
          CupertinoIcons.clear,
          size: 30,
          color: Colors.white,
          shadows: [
            BoxShadow(
                color: Colors.black, offset: Offset(0, 2), blurRadius: 5.0)
          ],
        ),
      ),
    );
  }
}
