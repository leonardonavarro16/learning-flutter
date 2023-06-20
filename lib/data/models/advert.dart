import 'dart:typed_data';

class Advert {
  String? id;
  List<Uint8List> images;
  String name;
  int age;
  String phoneNumber;
  String description;
  bool isFav;
  List<String>? adTags;

  Advert({
    this.adTags,
    this.id,
    this.isFav = false,
    required this.phoneNumber,
    required this.age,
    required this.name,
    required this.images,
    required this.description,
  });

  static Advert fromMap(Map<String, dynamic> advertData) {
    return Advert(
        id: advertData['id'].toString(),
        images:
            (advertData['images'] as List<dynamic>).cast<Uint8List>().toList(),
        name: advertData['name'],
        age: advertData['age'],
        phoneNumber: advertData['phone'],
        description: advertData['description'],
        isFav: advertData['is_fav'],
        adTags: advertData['adTags']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'description': description,
      'phone': phoneNumber,
      'images': images,
      'adTags': adTags,
    };
  }
}
