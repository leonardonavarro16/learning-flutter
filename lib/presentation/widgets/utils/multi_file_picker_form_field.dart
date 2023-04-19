import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class MultiFilePickerField extends StatefulWidget {
  final Function onChanged;

  const MultiFilePickerField({Key? key, required this.onChanged})
      : super(key: key);

  @override
  State<MultiFilePickerField> createState() => _MultiFilePickerField();
}

class _MultiFilePickerField extends State<MultiFilePickerField> {
  final FilePicker _filePicker = FilePicker.platform;
  FilePickerResult? result;
  bool isLoading = false;
  List<Uint8List> _pickedFiles = [];

  @override
  void dispose() async {
    await _filePicker.clearTemporaryFiles();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading) const CircularProgressIndicator(),
        if (!isLoading && _pickedFiles.isEmpty)
          Center(
            child: TextButton(
              onPressed: () => pickFile(),
              child: const Text(
                'Selecciona un archivo',
                style: TextStyle(color: Color.fromARGB(255, 235, 91, 81)),
              ),
            ),
          ),
        if (!isLoading && _pickedFiles.isNotEmpty)
          Column(
            children: [
              TextButton(
                onPressed: () => clearFile(),
                child: const Text(
                  'Limpiar archivos',
                  style: TextStyle(color: Color.fromARGB(255, 235, 91, 81)),
                ),
              ),
              SizedBox(
                  child: ListView.builder(
                      itemCount: _pickedFiles.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(title: Text("Imagen #$index"));
                      }))
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
        allowMultiple: true,
      );

      if (result != null) {
        print(result!.files.map((pickedFile) => pickedFile.bytes!));
        _pickedFiles.addAll(
            result!.files.map((pickedFile) => pickedFile.bytes!).toList());
        print(_pickedFiles);
        print(_pickedFiles[0]);
        widget.onChanged(_pickedFiles);
      }

      setState(() {
        isLoading = false;
      });
    } catch (error) {
      print(error);
    }
  }

  void clearFile() async {
    // tofix: call "await _filePicker.clearTemporaryFiles()" on mobile
    setState(() {
      _pickedFiles = [];
      widget.onChanged(null);
    });
  }
}
