import 'dart:convert';
import 'package:http/http.dart' as http;

import '../advert.dart';

class AdvertRepository {
//   Future<List<Advert>> fetchAdverts() async {
//     final response = await http.get(Uri.parse('$_baseUrl/adverts'));
//     if (response.statusCode == 200) {
//       List<dynamic> data = json.decode(response.body);
//       List<dynamic> adverts =
//           data.map((advertData) => Advert.fromJson(advertData)).toList();
//       return adverts;
//     } else {
//       throw Exception('Failed to load adverts');
//     }
//   }
// }

//todo: esto va en el data provider
  Future<List<Advert>> fetchAdverts() async {
    final http.Response response =
        await http.get(Uri.parse('http://localhost:3000/adverts'));
    print("response.statusCode = ${response.statusCode}");
    if (response.statusCode == 200) {
      var lis = json.decode(response.body);
      print("lis = $lis");
      var lis2 = lis.map((advertData) => Advert.fromJson(advertData));
      print("lis2 = $lis2");
      var lis3 = lis2.toList();
      print("lis3 = $lis3");
      final List<Advert> adverts = lis2;
      return adverts;
    } else {
      print("error");
      throw Exception('Failed to load adverts');
    }
  }
}
