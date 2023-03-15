import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/advert.dart';
import '../states/adverts.dart';

class AdvertsCubit extends Cubit<AdvertsState> {
  AdvertsCubit() : super(AdvertsInitial());

  Future<void> fetchAdverts() async {
    try {
      emit(AdvertsFetchInProgress());
      List<Advert> adverts = await repo.fetchAdverts();
      emit(AdvertsFetchSuccess(adverts));
    } catch (e) {
      emit(AdvertsFetchFailure('Error al traer los anuncios'));
    }
  }
}

//todo: esto va en el data provider
// Future<List<Advert>> fetchAdverts() async {
//   final http.Response response =
//       await http.get(Uri.parse('http://localhost:3000/adverts'));
//   print("response.statusCode = ${response.statusCode}");
//   if (response.statusCode == 200) {
//     var lis = json.decode(response.body);
//     print("lis = $lis");
//     var lis2 = lis.map((advertData) => Advert.fromJson(advertData));
//     print("lis2 = $lis2");
//     var lis3 = lis2.toList();
//     print("lis3 = $lis3");
//     final List<Advert> adverts = lis2;
//     return adverts;
//   } else {
//     print("error");
//     throw Exception('Failed to load adverts');
//   }
// }
