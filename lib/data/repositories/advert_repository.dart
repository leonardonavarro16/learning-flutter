import '../apis/adverts.dart';
import '../models/advert.dart';

class AdvertRepository {
  final AdvertsAPI _api = AdvertsAPI();

  Future<List<Advert>> fetchAll(String? token,
      {int page = 1, int perPage = 10, String? searchText}) async {
    List<dynamic> rawAdverts = await _api.fetchAll(token,
        page: page, perPage: perPage, searchText: searchText);
    return rawAdverts.map<Advert>((dynamic rawAdvert) {
      return Advert.fromMap(rawAdvert);
    }).toList();
  }

  Future<List<Advert>> fetchMyAds(String? token) async {
    List<dynamic> myAdverts = await _api.fetchMyAds(token);
    return myAdverts.map<Advert>((dynamic rawAdvert) {
      return Advert.fromMap(rawAdvert);
    }).toList();
  }

  Future<List<Advert>> fetchFav(String? token,
      {int page = 1, int perPage = 10}) async {
    List<dynamic> rawAdverts =
        await _api.fetchFav(token, page: page, perPage: perPage);
    return rawAdverts.map<Advert>((dynamic rawAdvert) {
      return Advert.fromMap(rawAdvert);
    }).toList();
  }

  Future<List<String>> getAllAdTags(String? token) async {
    return _api.getAllAdTags(token);
  }

  Future<Advert> create(Advert advert, String token) async {
    Map<String, dynamic> rawAdvert = await _api.create(advert.toMap(), token);
    return Advert.fromMap(rawAdvert);
  }

  Future<void> markAsFav(String advertId, String token) async {
    await _api.markAsFav(advertId, token);
  }

  Future<void> unmarkAsFav(String advertId, String token) async {
    await _api.unmarkAsFav(advertId, token);
  }
}
