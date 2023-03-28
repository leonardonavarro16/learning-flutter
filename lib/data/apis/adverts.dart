import 'dart:convert';
import 'package:http/http.dart';

import 'base.dart';

class AdvertsAPI extends BaseAPI {
  final List<Map<String, dynamic>> _rawAdverts = [
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1525609004556-c46c7d6cf023?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=452&q=80',
      'name': 'Rosa',
      'desiredAge': 20,
      'phoneNumber': '+57 301 345 6789',
      'description': 'soy una nena bien caliente'
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1525609004556-c46c7d6cf023?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=452&q=80',
      'name': 'Rosa',
      'desiredAge': 20,
      'phoneNumber': '+57 301 345 6789',
      'description': 'soy una nena bien caliente',
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1525609004556-c46c7d6cf023?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=452&q=80',
      'name': 'Rosa',
      'desiredAge': 20,
      'phoneNumber': '+57 301 345 6789',
      'description': 'soy una nena bien caliente',
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1525609004556-c46c7d6cf023?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=452&q=80',
      'name': 'Rosa',
      'desiredAge': 20,
      'phoneNumber': '+57 301 345 6789',
      'description': 'soy una nena bien caliente',
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1525609004556-c46c7d6cf023?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=452&q=80',
      'name': 'Rosa',
      'desiredAge': 20,
      'phoneNumber': '+57 301 345 6789',
      'description': 'soy una nena bien caliente',
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1525609004556-c46c7d6cf023?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=452&q=80',
      'name': 'Rosa',
      'desiredAge': 20,
      'phoneNumber': '+57 301 345 6789',
      'description': 'soy una nena bien caliente',
    },
  ];

  Future<List<dynamic>> fetchAll() async {
    final response = await httpGet('$baseUrl/adverts');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load adverts');
    }
  }

  Future<Map<String, dynamic>> create(Map<String, dynamic> rawAdvert) async {
    String body = jsonEncode({'advert': rawAdvert});

    final Response response = await httpPost(
      '$baseUrl/adverts',
      body: body,
    );
    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create advert');
    }
  }
}
