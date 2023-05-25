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
  int index = 0;
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
        GridView.builder(
          shrinkWrap: true,
          itemCount: _pickedFiles.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 3,
            crossAxisSpacing: 3,
            childAspectRatio: 1.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18.5),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18.5),
                child: Image.memory(
                  _pickedFiles[index],
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
        if (_pickedFiles.isNotEmpty)
          Column(
            children: [
              _buildSelectFileBtn(),
              TextButton(
                onPressed: () => cleanFiles(),
                child: const TextView(
                    text: 'Limpiar selección', color: Colors.red),
              ),
              TextButton(
                onPressed: () => _removeCurrentImage(),
                child: const TextView(
                    text: 'Borrar esta imagen', color: Colors.red),
              ),
            ],
          ),
        if (_pickedFiles.isEmpty) _buildSelectFileBtn(),
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
      _pickedFiles.removeAt(index);
    });
  }

  Widget _buildSelectFileBtn() {
    return Center(
      child: TextButton(
        onPressed: () => pickFile(),
        child: const TextView(
            text: 'Selecciona un archivo',
            color: Color.fromARGB(255, 235, 91, 81)),
      ),
    );
  }
}
