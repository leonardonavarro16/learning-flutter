import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class ImageGridView extends StatelessWidget {
  final List<Uint8List> images;
  final void Function(int) onDelete;

  const ImageGridView({
    Key? key,
    required this.images,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: images.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 1.0,
        crossAxisSpacing: 0.5,
        // childAspectRatio: 1.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Stack(
          children: [
            Image.memory(
              images[index],
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  onDelete(index);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
