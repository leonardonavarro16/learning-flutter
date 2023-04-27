import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:swc_front/data/models/advert.dart';
import 'package:swc_front/data/apis/base.dart';

class AdvertsAPI extends BaseAPI {
  Future<Map<String, dynamic>> create(
    Advert advert,
    String token,
  ) async {
    final advertFormData = FormData();

    advertFormData.fields.addAll([
      MapEntry('name', advert.name),
      MapEntry('age', advert.age.toString()),
      MapEntry('phone', advert.phoneNumber),
      MapEntry('description', advert.description)
    ]);

    for (int i = 0; i < advert.images.length; i++) {
      final bytes = advert.images[i];
      final mimeType = lookupMimeType('', headerBytes: bytes);
      final multipartFile = await MultipartFile.fromBytes(
        bytes,
        filename: 'image$i',
        contentType: MediaType.parse(mimeType!),
      );
      advertFormData.files.add(MapEntry('image$i', multipartFile));
    }
    final formData = FormData();
    formData.fields.add(MapEntry('advert', jsonEncode(advertFormData)));

    final dio = Dio();
    dio.options.headers['authorization'] = 'Bearer $token';

    try {
      final response = await dio.post(
        '${baseUrl()}/adverts',
        data: formData,
      );

      if (response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception('Failed to create advert');
      }
    } catch (error) {
      throw Exception('Failed to create advert: ${error.toString()}');
    }
  }

  Future<List<dynamic>> fetchAll() async {
    final response = await httpGet('${baseUrl()}/adverts');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      final error = jsonDecode(response.body)['error'];
      throw Exception(error);
    }
  }
}
