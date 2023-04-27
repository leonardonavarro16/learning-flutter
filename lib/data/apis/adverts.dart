import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:swc_front/data/apis/base.dart';

class AdvertsAPI extends BaseAPI {
  Future<Map<String, dynamic>> create(
    Map<String, dynamic> advert,
    String token,
  ) async {
    final advertFormData = FormData();

    advertFormData.fields.addAll([
      MapEntry('advert[name]', advert['name']),
      MapEntry('advert[age]', advert['age'].toString()),
      MapEntry('advert[phone]', advert['phone']),
      MapEntry('advert[description]', advert['description'])
    ]);

    for (int i = 0; i < advert['images'].length; i++) {
      final bytes = advert['images'][i];
      final mimeType = lookupMimeType('', headerBytes: bytes);
      final multipartFile = MultipartFile.fromBytes(
        bytes,
        filename: 'image$i',
        contentType: MediaType.parse(mimeType!),
      );
      advertFormData.files.add(MapEntry('advert[images[]]', multipartFile));
    }

    final dio = Dio();
    dio.options.headers['authorization'] = 'Bearer $token';

    final response = await dio.post(
      '${baseUrl()}/adverts',
      data: advertFormData,
    );

    if (response.statusCode == 201) {
      return response.data;
    } else {
      throw Exception('Failed to create advert');
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
