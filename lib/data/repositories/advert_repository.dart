import '../apis/adverts.dart';
import '../models/advert.dart';

class AdvertRepository {
  final AdvertsAPI _api = AdvertsAPI();

  Future<List<Advert>> fetchAll() async {
    List<dynamic> rawAdverts = await _api.fetchAll();
    return rawAdverts.map<Advert>((dynamic rawAdvert) {
      return Advert.fromMap(rawAdvert);
    }).toList();
  }

  Future<Advert> create(Advert advert, String token) async {
    Map<String, dynamic> rawAdvert = await _api.create(advert.toMap(), token);
    return Advert.fromMap(rawAdvert);
  }
}
