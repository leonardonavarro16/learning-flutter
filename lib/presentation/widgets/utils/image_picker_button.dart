import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// todo: hay que refactorizar el código -> separar componente de botón y componente de foto de perfil, también aplicarlo en MultiFilePickerField

class ImagePickerButton extends StatefulWidget {
  final Function onChanged;

  const ImagePickerButton({Key? key, required this.onChanged})
      : super(key: key);

  @override
  State<ImagePickerButton> createState() => _ImagePickerButtonState();
}

class _ImagePickerButtonState extends State<ImagePickerButton> {
  final FilePicker _filePicker = FilePicker.platform;
  FilePickerResult? result;
  bool isLoading = false;
  PlatformFile? _pickedFile;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 150,
          height: 150,
          child: ClipOval(
            child: Image.asset('user_default1.jpg'),
          ),
        ),
        Positioned(
          bottom: 1,
          right: 1,
          child: GestureDetector(
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
                CupertinoIcons.switch_camera,
                color: Colors.white,
                shadows: [
                  BoxShadow(
                      color: Colors.black,
                      offset: Offset(0, 2),
                      blurRadius: 5.0)
                ],
              ),
            ),
          ),
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

      if (result != null) {
        _pickedFile = result!.files.single;
        widget.onChanged(_pickedFile!.bytes!);
      }

      setState(() {
        isLoading = false;
      });
    } catch (error) {
      print(error);
    }
  }
}
