import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
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
  Widget build(BuildContext context) {
    if (isLoading) return const CircularProgressIndicator();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (_pickedFiles.isNotEmpty)
          ImageCarousel(
            images: _pickedFiles,
            onChange: (newIndex) => index = newIndex,
          ),
        if (_pickedFiles.isNotEmpty)
          Row(
            children: [
              _buildSelectFileBtn(),
              TextButton(
                onPressed: () => cleanFiles(),
                child: const Text(
                  'Limpiar selección',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () => _removeCurrentImage(),
                child: const Text('Borrar esta imagen',
                    style: TextStyle(color: Colors.red)),
              )
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
        child: const Text(
          'Selecciona un archivo',
          style: TextStyle(color: Color.fromARGB(255, 235, 91, 81)),
        ),
      ),
    );
  }
}
