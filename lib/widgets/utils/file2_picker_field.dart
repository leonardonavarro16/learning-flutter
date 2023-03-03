import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class FilePickerFieldTwo extends StatefulWidget {
  const FilePickerFieldTwo({Key? key}) : super(key: key);

  @override
  State<FilePickerFieldTwo> createState() => _FilePickerField();
}

class _FilePickerField extends State<FilePickerFieldTwo> {
  FilePickerResult? result;
  String? _FileName;
  PlatformFile? pickedFile;
  bool isLoading = false;
  File? fileToDisplay;

  void pickFile() async {
    try {
      setState(() {
        isLoading = true;
      });
      result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        // allowedExtensions: ['png', 'pdf', 'jpg'],
        allowMultiple: true,
      );

      if (result != null) {
        _FileName = result!.files.first.name;
        pickedFile = result!.files.first;
        fileToDisplay = File(pickedFile!.path.toString());

        print('Nombre de archivo $_FileName');
      }
      // Delay for one second to allow CircularProgressIndicator to display
      //await Future.delayed(const Duration(seconds: 1));

      setState(() {
        isLoading = false;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : TextButton(
                  onPressed: () {
                    pickFile();
                  },
                  child: const Text(
                    'Selecciona un archivo',
                    style: TextStyle(color: Color.fromARGB(255, 235, 91, 81)),
                  ),
                ),
        ),
        if (pickedFile != null)
          SizedBox(height: 300, width: 400, child: Image.file(fileToDisplay!)),
      ],
    );
  }
}
