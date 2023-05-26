import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swc_front/presentation/widgets/utils/indicator_progress.dart';

class ImagePickerButton extends StatefulWidget {
  final Function(Uint8List) onChanged;

  const ImagePickerButton({Key? key, required this.onChanged})
      : super(key: key);

  @override
  State<ImagePickerButton> createState() => _ImagePickerButtonState();
}

class _ImagePickerButtonState extends State<ImagePickerButton> {
  final FilePicker _filePicker = FilePicker.platform;
  FilePickerResult? result;
  bool isLoading = false;
  Uint8List? _pickedFile;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipOval(
          child: Stack(
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: (_pickedFile != null)
                    ? Image.memory(
                        _pickedFile!,
                        fit: BoxFit.cover,
                      )
                    : Image.asset('user_default1.jpg'),
              ),
              if (isLoading)
                const Positioned.fill(
                  child: Center(
                    child: CustomIndicatorProgress(),
                  ),
                ),
            ],
          ),
        ),
        if (!isLoading)
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
        _pickedFile = result!.files.single.bytes;
        // widget.onChanged(image!);
      }

      setState(() {
        isLoading = false;
      });
    } catch (error) {
      print(error);
    }
  }
}
