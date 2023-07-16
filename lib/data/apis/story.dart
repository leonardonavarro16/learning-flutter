import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import 'package:swc_front/data/apis/base.dart';

class StoryAPI extends BaseAPI {
  Future<Map<String, dynamic>> createStory(
    Map<String, dynamic> story,
    String token,
  ) async {
    final url = Uri.parse('${baseUrl()}/users/${story['user_id']}/stories');
    final request = http.MultipartRequest('POST', url);
    request.headers['authorization'] = 'Bearer $token';

    final bytes = story['image'];
    final mimeType = lookupMimeType('', headerBytes: bytes);
    final multipartFile = http.MultipartFile.fromBytes(
      'story[image]',
      bytes,
      filename: 'image',
      contentType: MediaType.parse(mimeType!),
    );
    request.files.add(multipartFile);

    final response = await request.send();

    if (response.statusCode == 201) {
      final responseBody = await response.stream.bytesToString();
      Map<String, dynamic> rawStory = jsonDecode(responseBody);

      await downloadStoriesImages(rawStory);

      return rawStory;
    } else {
      throw Exception('XXX');
    }
  }

  Future<List<dynamic>> fetchStories(String? token, String? user_id) async {
    final url = '${baseUrl()}/stories/users?user_id=$user_id';
    final response = await httpGet(url, token: token);
    if (response.statusCode == 200) {
      List<dynamic> rawStories = jsonDecode(response.body);
      return await Future.wait(
        rawStories.map((rawStory) async {
          await downloadStoriesImages(rawStory);

          return rawStory;
        }),
      );
    } else {
      final error = jsonDecode(response.body)['error'];
      throw Exception(error);
    }
  }

  Future<List<dynamic>> fetchStoriesUsers(String? token) async {
    final url = '${baseUrl()}/users/stories';

    final response = await httpGet(url, token: token);
    if (response.statusCode == 200) {
      List<dynamic> rawStoriesUsers = jsonDecode(response.body);
      return await Future.wait(
        rawStoriesUsers.map((rawUser) async {
          await downloaUsersImages(rawUser);

          return rawUser;
        }),
      );
    } else {
      final error = jsonDecode(response.body)['error'];
      throw Exception(error);
    }
  }

  Future<void> downloadStoriesImages(Map<String, dynamic> rawStory) async {
    bool downloadImages =
        rawStory['image'] != null && rawStory['image'].isNotEmpty;
    if (downloadImages) {
      rawStory['image'] = await getBytesFromUrl(rawStory['image']);
    }
  }

  Future<void> downloaUsersImages(Map<String, dynamic> rawUser) async {
    bool downloadImages =
        rawUser['image'] != null && rawUser['image'].isNotEmpty;
    if (downloadImages) {
      rawUser['image'] = await getBytesFromUrl(rawUser['image']);
    }
  }
}
