import 'package:flutter/services.dart';

class Story {
  String? id;
  Uint8List? image;

  Story({this.id, required this.image});

  static Story fromMap(Map<String, dynamic> storyData) {
    return Story(
      id: storyData['id'].toString(),
      image: (storyData['images']).cast<Uint8List>().toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
    };
  }
}
