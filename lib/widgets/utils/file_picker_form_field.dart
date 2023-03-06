import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class FilePickerField extends StatefulWidget {
  final Function onChanged;

  const FilePickerField({Key? key, required this.onChanged}) : super(key: key);

  @override
  State<FilePickerField> createState() => _FilePickerField();
}

class _FilePickerField extends State<FilePickerField> {
  final FilePicker _filePicker = FilePicker.platform;
  FilePickerResult? result;
  bool isLoading = false;
  PlatformFile? _pickedFile;

  // tofix: call clearTemporaryFiles on mobile
  // @override
  // void dispose() async {
  //   await _filePicker.clearTemporaryFiles();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading) const CircularProgressIndicator(),
        if (!isLoading && _pickedFile == null)
          Center(
            child: TextButton(
              onPressed: () => pickFile(),
              child: const Text(
                'Selecciona un archivo',
                style: TextStyle(color: Color.fromARGB(255, 235, 91, 81)),
              ),
            ),
          ),
        if (!isLoading && _pickedFile != null)
          Center(
            child: TextButton(
              onPressed: () => clearFile(),
              child: const Text(
                'Limpiar archivo',
                style: TextStyle(color: Color.fromARGB(255, 235, 91, 81)),
              ),
            ),
          ),
        if (!isLoading && _pickedFile != null)
          SizedBox(
              height: 100,
              width: 100,
              child: Image.memory(_pickedFile!.bytes!)),
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

      if (result != null) {
        _pickedFile = result!.files.single;
        Uint8List? a = _pickedFile!.bytes;
        widget.onChanged(_pickedFile!.bytes);
      }

      setState(() {
        isLoading = false;
      });
    } catch (error) {
      print(error);
    }
  }

  void clearFile() async {
    // tofix: call clearTemporaryFiles on mobile
    // await _filePicker.clearTemporaryFiles();
    setState(() {
      _pickedFile = null;
      widget.onChanged(null);
    });
  }
}
