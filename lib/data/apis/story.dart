import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import 'package:swc_front/data/apis/base.dart';

class StoryAPI extends BaseAPI {
  Future<Map<String, dynamic>> createStory(
    Map<String, dynamic> story,
    String? token,
  ) async {
    final url = Uri.parse('${baseUrl()}/users/${story['user_id']}/stories');
    final request = http.MultipartRequest(
      'POST',
      url,
    );
    request.headers['authorization'] = 'Bearer $token';

    // for (int i = 0; i < story['image'].length; i++) {
    final bytes = story['image'];
    final mimeType = lookupMimeType('', headerBytes: bytes);
    final multipartFile = http.MultipartFile.fromBytes(
      'story[image]',
      bytes,
      filename: 'image',
      contentType: MediaType.parse(mimeType!),
    );
    request.files.add(multipartFile);
    // }

    if (token != null) {
      request.headers['authorization'] = 'Bearer $token';
    }

    final response = await request.send();

    if (response.statusCode == 201) {
      final responseBody = await response.stream.bytesToString();
      Map<String, dynamic> rawStory = jsonDecode(responseBody);

      await downloadStoriesImages(rawStory);

      return rawStory;
    } else {
      throw Exception('Failed to create story');
    }
  }

  Future<List<dynamic>> fetchStories(String? token) async {
    final url = '${baseUrl()}/users/stories';

    final response = await httpGet(url, token: token);
    if (response.statusCode == 200) {
      List<dynamic> rawStories = jsonDecode(response.body);
      return await Future.wait(
        rawStories.map((rawStories) async {
          await downloadStoriesImages(rawStories);
          return rawStories;
        }),
      );
    } else {
      final error = jsonDecode(response.body)['error'];
      throw Exception(error);
    }
  }

  Future<void> downloadStoriesImages(Map<String, dynamic> rawStories) async {
    bool downloadImages = rawStories['images'] != null &&
        rawStories['images'] is List &&
        rawStories['images'].isNotEmpty;
    if (downloadImages) {
      rawStories['images'] = await Future.wait(
        rawStories['images'].map(
          (imageUrl) async {
            return await getBytesFromUrl(imageUrl);
          },
        ).cast<Future<Uint8List>>(),
      );
    }
  }
}
