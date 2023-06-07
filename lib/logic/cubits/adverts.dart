import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swc_front/data/repositories/advert_repository.dart';

import '../../data/models/advert.dart';
import '../states/adverts.dart';

class AdvertsCubit extends Cubit<AdvertsState> {
  final AdvertRepository _advertRepository = AdvertRepository();

  AdvertsCubit() : super(AdvertsState.initial());

  Future<void> fetchAdverts(String? token) async {
    emit(state.copyWith(advertsStatus: AdvertsStatus.loading));
    try {
      List<Advert> adverts = await _advertRepository.fetchAll(token);
      emit(state.copyWith(
        advertsStatus: AdvertsStatus.indexSuccess,
        adverts: adverts,
      ));
    } catch (error) {
      emit(state.copyWith(
          advertsStatus: AdvertsStatus.indexFailure, error: error.toString()));
    }
  }

  Future<void> createAdvert(Advert advert, String token) async {
    try {
      emit(state.copyWith(advertsStatus: AdvertsStatus.loading));
      Advert createdAdvert = await _advertRepository.create(advert, token);
      state.adverts.add(createdAdvert);
      emit(state.copyWith(
        advertsStatus: AdvertsStatus.indexSuccess,
        adverts: state.adverts,
      ));
    } catch (error) {
      emit(state.copyWith(
          advertsStatus: AdvertsStatus.indexFailure, error: error.toString()));
    }
  }

// todo: revisar si hay alguna manera de simplificar la condición
  Future<void> toggleAdvertFav(Advert advert, String token) async {
    try {
      emit(state.copyWith(advertsStatus: AdvertsStatus.loading));
      print('prueba de que entra en AdvertsStatus.loading');
      print(advert.isFav);
      advert.isFav = !advert.isFav;
      print(advert.isFav);
      (advert.isFav == true)
          ? _advertRepository.markAsFav(advert.id!, token)
          : _advertRepository.unmarkAsFav(advert.id!, token);
      List<Advert> adverts = state.adverts.map((Advert adv) {
        if (adv.id == advert.id) return advert;
        return adv;
      }).toList();
      emit(
        state.copyWith(
          adverts: adverts,
          advertsStatus: AdvertsStatus.indexSuccess,
        ),
      );
    } catch (error) {
      print('prueba de que entra en error');
      emit(state.copyWith(
          advertsStatus: AdvertsStatus.indexFailure, error: error.toString()));
    }
  }
}
