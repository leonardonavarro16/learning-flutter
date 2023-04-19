import 'dart:convert';
import 'dart:typed_data';

class Advert {
  List<Uint8List> images;
  String name;
  int age;
  String phoneNumber;
  String description;

  Advert(
      {required this.phoneNumber,
      required this.age,
      required this.name,
      required this.images,
      required this.description});

  static Advert fromMap(Map<String, dynamic> advertData) {
    List<String> imagesBase64 = advertData['images'];
    List<Uint8List> decodedImagesBytes = imagesBase64
        .map((String imageBytes) => base64.decode(imageBytes))
        .toList();

    return Advert(
        images: decodedImagesBytes,
        name: advertData['name'],
        age: advertData['age'],
        phoneNumber: advertData['phone'],
        description: advertData['description']);
  }

  Map<String, dynamic> toMap() {
    List<String> encodedImageBytes =
        images.map((Uint8List image) => base64.encode(image)).toList();

    return {
      'name': name,
      'age': age,
      'description': description,
      'phone': phoneNumber,
      'images': encodedImageBytes,
    };
  }
}
