import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'package:swc_front/presentation/widgets/utils/text_view.dart';

class UploadStoryButton extends StatefulWidget {
  final void Function(Uint8List) onChanged;
  const UploadStoryButton({super.key, required this.onChanged});

  @override
  State<UploadStoryButton> createState() => _UploadStoryButtonState();
}

class _UploadStoryButtonState extends State<UploadStoryButton> {
  final FilePicker _filePicker = FilePicker.platform;
  FilePickerResult? result;
  bool isLoading = false;
  Uint8List? _pickedFile;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(width: 3),
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 76, 5, 0),
                Color(0xFFFF0000),
              ],
              stops: [
                0.1,
                1,
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(2),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: PhysicalModel(
                color: Colors.transparent,
                elevation: 6,
                shadowColor: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(50),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () => showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) => Container(
                              height: 200,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    // Color(0xFFFF0000),
                                    Color.fromARGB(255, 76, 5, 0),
                                    Color.fromARGB(255, 0, 0, 0),
                                  ],
                                  stops: [
                                    0.2,
                                    1,
                                  ],
                                  begin: Alignment.center,
                                  end: Alignment.bottomCenter,
                                ),
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(45),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 15, right: 15),
                                child: Wrap(
                                  children: [
                                    const Center(
                                      child: TextView(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        text: 'Select an option',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      color: Colors.transparent,
                                      child: ListTile(
                                        onTap: () => getImageAndPickFile(),
                                        leading: const Icon(
                                          weight: 100,
                                          Icons.camera,
                                          size: 30,
                                          color: Colors.white,
                                        ),
                                        title: const TextView(
                                          color: Colors.white,
                                          text: 'Open camera',
                                        ),
                                      ),
                                    ),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      color: Colors.transparent,
                                      child: ListTile(
                                        onTap: () => pickFile(),

                                        // showDialog(
                                        //     context: context,
                                        //     builder: (context) {
                                        //       return ClipRRect(
                                        //         child: Column(
                                        //           children: [
                                        //             if (_pickedFile!.isEmpty)
                                        //               TextButton(
                                        //                   onPressed: pickFile,
                                        //                   child: const TextView(
                                        //                       text:
                                        //                           'sube una historia man')),
                                        //           ],
                                        //         ),
                                        //       );
                                        //     }),
                                        leading: const Icon(
                                          weight: 100,
                                          color: Colors.white,
                                          Icons.cloud_upload,
                                          size: 30,
                                        ),
                                        title: const TextView(
                                          color: Colors.white,
                                          text: 'Upload image from device',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                    child: const Icon(
                      Icons.add,
                      size: 65,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        const TextView(
          textAlign: TextAlign.justify,
          text: 'Upload Story',
          fontSize: 12,
          color: Colors.white,
        ),
      ],
    );
  }

  void getImageAndPickFile() async {
    setState(() {
      isLoading = true;
    });

    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      final fileBytes = await pickedFile.readAsBytes();
      _pickedFile = Uint8List.fromList(fileBytes);
      widget.onChanged(_pickedFile!);
      // print('Picked file: $_pickedFile');
    }

    setState(() {
      isLoading = false;
    });
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
        if (widget.onChanged != null) widget.onChanged(_pickedFile!);
        // print('Picked file: $_pickedFile');
      }

      setState(() {
        isLoading = false;
      });
    } catch (error) {
      print(error);
    }
  }
}
