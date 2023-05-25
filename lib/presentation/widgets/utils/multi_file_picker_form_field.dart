import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:swc_front/presentation/widgets/utils/indicator_progress.dart';
import 'package:swc_front/presentation/widgets/utils/text_view.dart';
import 'image_carousel.dart';

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
    if (isLoading) return const CustomIndicatorProgress();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (_pickedFiles.isNotEmpty)
          const TextView(
            text: 'Fotos del anuncio',
            color: Colors.white,
            fontSize: 14,
          ),
        const SizedBox(height: 15),
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 90),
              child: CarouselSlider(
                options: CarouselOptions(

                    // animateToClosest: true,
                    enableInfiniteScroll: false,
                    autoPlay: false,
                    enlargeCenterPage: true,
                    aspectRatio: 1.4,
                    viewportFraction: 0.5,

                    // enlargeStrategy: CenterPageEnlargeStrategy.height,
                    onPageChanged: (index, _) {
                      setState(() {
                        _currentImageIndex = index;
                      });
                    }),
                items: _pickedFiles.map((image) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18.5),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18.5),
                      child: Image.memory(
                        image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Positioned(
              top: 70,
              bottom: 0,
              left: 0.0,
              right: 0.0,
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
                  : SizedBox(), // Opcional: Si no hay imágenes seleccionadas, se muestra un SizedBox
            ),
            if (_pickedFiles.isEmpty) Center(child: _buildSelectFileBtn()),
            if (_pickedFiles.isNotEmpty)
              Positioned(
                top: 200,
                bottom: 0,
                right: 0,
                left: 0,
                child: Column(
                  children: [
                    _buildSelectFileBtn(),
                    const SizedBox(height: 5),
                    TextButton(
                      onPressed: () => cleanFiles(),
                      child: const TextView(
                          text: 'Limpiar selección', color: Colors.red),
                    ),
                    const SizedBox(height: 5),
                    TextButton(
                      onPressed: () => _removeCurrentImage(),
                      child: const TextView(
                          text: 'Borrar esta imagen', color: Colors.red),
                    ),
                  ],
                ),
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
        width: 40,
        height: 40,
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
          shadows: [
            BoxShadow(
                color: Colors.black, offset: Offset(0, 2), blurRadius: 5.0)
          ],
        ),
      ),
    );
  }
}
