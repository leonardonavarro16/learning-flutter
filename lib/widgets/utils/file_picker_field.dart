import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class FilePickerField extends StatefulWidget {
  const FilePickerField({super.key});

  @override
  State<StatefulWidget> createState() => _FilePickerField();
}

class _FilePickerField extends State<StatefulWidget> {
  PlatformFile? file;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles();
          bool fileSelectionCancelled = result == null;
          setState(() {
            if (fileSelectionCancelled) {
              file = null;
            } else {
              file = result.files.single;
            }
          });
        },
        child: Container(
          color: Colors.blue,
          height: 100,
          width: 100,
          child: Text(file == null ? 'No file selected' : file!.name),
        ));
  }
}
