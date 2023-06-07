import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import 'package:swc_front/data/apis/base.dart';

class AdvertsAPI extends BaseAPI {
  Future<Map<String, dynamic>> create(
    Map<String, dynamic> advert,
    String token,
  ) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('${baseUrl()}/adverts'),
    );
    request.headers['authorization'] = 'Bearer $token';

    // Add text fields to the request
    request.fields.addAll({
      'advert[name]': advert['name'],
      'advert[age]': advert['age'].toString(),
      'advert[phone]': advert['phone'],
      'advert[description]': advert['description'],
    });

    // Add image files to the request
    for (int i = 0; i < advert['images'].length; i++) {
      final bytes = advert['images'][i];
      final mimeType = lookupMimeType('', headerBytes: bytes);
      final multipartFile = http.MultipartFile.fromBytes(
        'advert[images][]',
        bytes,
        filename: 'image$i',
        contentType: MediaType.parse(mimeType!),
      );
      request.files.add(multipartFile);
    }

    final response = await request.send();

    if (response.statusCode == 201) {
      final responseBody = await response.stream.bytesToString();
      Map<String, dynamic> rawAdvert = jsonDecode(responseBody);

      await downloadAdvertImages(rawAdvert);

      return rawAdvert;
    } else {
      throw Exception('Failed to create advert');
    }
  }

  Future<List<dynamic>> fetchAll(String? token) async {
    final response = await httpGet('${baseUrl()}/adverts', token: token);
    if (response.statusCode == 200) {
      List<dynamic> rawAdverts = jsonDecode(response.body);
      return await Future.wait(
        rawAdverts.map((rawAdvert) async {
          await downloadAdvertImages(rawAdvert);
          return rawAdvert;
        }),
      );
    } else {
      final error = jsonDecode(response.body)['error'];
      throw Exception(error);
    }
  }

  Future<void> downloadAdvertImages(Map<String, dynamic> rawAdvert) async {
    bool downloadImages = rawAdvert['images'] != null &&
        rawAdvert['images'] is List &&
        rawAdvert['images'].isNotEmpty;
    if (downloadImages) {
      rawAdvert['images'] = await Future.wait(
        rawAdvert['images'].map(
          (imageUrl) async {
            return await getBytesFromUrl(imageUrl);
          },
        ).cast<Future<Uint8List>>(),
      );
    }
  }

// todo: en el metodo markAsFav** del api hacer un post a /adverts/:id/favorites

  Future<void> markAsFav(String advertId, String token) async {
    final response = await httpPost(
      '${baseUrl()}/adverts/$advertId/favorites',
      token: token,
    );

    if (response.statusCode != 200) {
      String? error = response.body.isEmpty
          ? 'Error: status code ${response.statusCode}'
          : jsonDecode(response.body)['error']['message'];
      throw Exception(error);
    }
  }

// todo: en el metodo unmarkAsFav** del api hacer un delete a /adverts/:id/favorites
// todo: crear el metodo httpDelete y usarlo

  Future<void> unmarkAsFav(String advertId, String token) async {
    final response = await httpDelete(
      '${baseUrl()}/adverts/$advertId/favorites',
      token: token,
    );

    if (response.statusCode != 200) {
      String? error = response.body.isEmpty
          ? 'Error: status code ${response.statusCode}'
          : jsonDecode(response.body)['error']['message'];
      throw Exception(error);
    }
  }
}
