import 'dart:typed_data';

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
    return Advert(
        images:
            (advertData['images'] as List<dynamic>).cast<Uint8List>().toList(),
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
      'images': images,
    };
  }
}
