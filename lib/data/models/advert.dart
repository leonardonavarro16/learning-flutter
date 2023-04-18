import 'dart:convert';
import 'dart:typed_data';

class Advert {
  Uint8List imageBytes;
  String name;
  int age;
  String phoneNumber;
  String description;

  Advert(
      {required this.phoneNumber,
      required this.age,
      required this.name,
      required this.imageBytes,
      required this.description});

  static Advert fromMap(Map<String, dynamic> advertData) {
    return Advert(
        imageBytes: base64.decode(advertData['image']),
        name: advertData['name'],
        age: advertData['age'],
        phoneNumber: advertData['phone'],
        description: advertData['description']);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'description': description,
      'phone': phoneNumber,
      'image': base64.encode(imageBytes),
    };
  }
}
