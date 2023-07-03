import 'dart:typed_data';
import 'package:http/http.dart' as http;

class BaseRepository {
  Future<void> downloadUserImage(Map<String, dynamic> rawUser) async {
    bool downloadImage = rawUser['image'] != null;
    if (downloadImage) {
      rawUser['image'] = await getBytesFromUrl(rawUser['image']);
    }
  }

  Future<void> downloadStoryImage(Map<String, dynamic> rawStories) async {
    bool downloadImage = rawStories['image'] != null;
    if (downloadImage) {
      rawStories['image'] = await getBytesFromUrl(rawStories['image']);
    }
  }

  Future<Uint8List> getBytesFromUrl(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load image');
    }
  }
}
