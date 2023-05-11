import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:swc_front/presentation/widgets/utils/indicator_progress.dart';
import 'package:swc_front/presentation/widgets/utils/text_view.dart';

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

  @override
  void dispose() async {
    if (!kIsWeb) await _filePicker.clearTemporaryFiles();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading) const CustomIndicatorProgress(),
        if (!isLoading && _pickedFile == null)
          Center(
            child: TextButton(
              onPressed: () => pickFile(),
              child: const TextView(
                text: 'Selecciona un archivo',
                color: Color.fromARGB(255, 235, 91, 81),
              ),
            ),
          ),
        if (!isLoading && _pickedFile != null)
          Center(
            child: TextButton(
              onPressed: () => clearFile(),
              child: const TextView(
                  text: 'Limpiar archivo',
                  color: Color.fromARGB(255, 235, 91, 81)),
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
    // tofix: call "await _filePicker.clearTemporaryFiles()" on mobile
    setState(() {
      _pickedFile = null;
      widget.onChanged(null);
    });
  }
}
