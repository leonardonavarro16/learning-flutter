import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swc_front/widgets/advert_list.dart';
import 'package:swc_front/widgets/layout.dart';
import 'package:swc_front/models/advert.dart';
import 'package:http/http.dart' as http;

import '../states/adverts.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(
      content: FutureBuilder<List<Advert>>(
        future: fetchAdverts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Advert> adverts = snapshot.data as List<Advert>;
            return ListView(
              children: [
                const SizedBox(height: 20),
                AdverList(adverts: adverts)
              ],
            );
          } else if (snapshot.hasError) {
            print('snapshot.error');
            return Text(snapshot.error.toString(),
                style: const TextStyle(color: Colors.red));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

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

//todo: borrar el provider y el AdvertsState