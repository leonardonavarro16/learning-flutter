import 'dart:convert';
import 'dart:typed_data';
import 'package:mime/mime.dart';

class Advert {
  List<Uint8List> images;
  String name;
  int age;
  String phoneNumber;
  String description;

  Advert({
    required this.phoneNumber,
    required this.age,
    required this.name,
    required this.images,
    required this.description,
  });

  static Advert fromMap(Map<String, dynamic> advertData) {
    List<Uint8List> imagesBytes = [];
    if (advertData['images'] != null && advertData['images'].isNotEmpty) {
      advertData['images'].forEach(
        (image) => imagesBytes.add(
          base64.decode(image),
        ),
      );
    }

    return Advert(
      images: imagesBytes,
      name: advertData['name'],
      age: advertData['age'],
      phoneNumber: advertData['phone'],
      description: advertData['description'],
    );
  }

  Map<String, dynamic> toMap() {
    List<String> imagesBase64 = images.map((Uint8List image) {
      String? mimeType = lookupMimeType('', headerBytes: image);
      String encodedImage = base64.encode(image);
      return "data:$mimeType;base64,$encodedImage";
    }).toList();

    return {
      'name': name,
      'age': age,
      'description': description,
      'phone': phoneNumber,
      'images': imagesBase64,
    };
  }
}
