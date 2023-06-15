import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swc_front/data/repositories/advert_repository.dart';

import '../../data/models/advert.dart';
import '../states/adverts.dart';

class AdvertsCubit extends Cubit<AdvertsState> {
  final AdvertRepository _advertRepository = AdvertRepository();
  final int perPage = 10; // Número de anuncios por página

  AdvertsCubit() : super(AdvertsState.initial());

  Future<void> fetchAdverts(String? token, {int page = 1}) async {
    emit(state.copyWith(advertsStatus: AdvertsStatus.loading));
    try {
      List<Advert> adverts =
          await _advertRepository.fetchAll(token, page: page, perPage: perPage);
      emit(state.copyWith(
        advertsStatus: AdvertsStatus.indexSuccess,
        adverts: adverts,
        currentPage: page,
      ));
    } catch (error) {
      emit(state.copyWith(
        advertsStatus: AdvertsStatus.indexFailure,
        error: error.toString(),
      ));
    }
  }

  Future<void> nextPage(String? token) async {
    int nextPage = state.currentPage + 1;
    await fetchAdverts(token, page: nextPage);
  }

  Future<void> previousPage(String? token) async {
    int previousPage = state.currentPage - 1;
    if (previousPage < 1) return;
    await fetchAdverts(token, page: previousPage);
  }

  Future<void> fetchFavAdverts(String? token, {int page = 1}) async {
    emit(state.copyWith(advertsStatus: AdvertsStatus.loading));
    try {
      List<Advert> adverts =
          await _advertRepository.fetchFav(token, page: page, perPage: perPage);
      emit(state.copyWith(
        advertsStatus: AdvertsStatus.indexSuccess,
        adverts: adverts,
        currentFavPage: page,
      ));
    } catch (error) {
      emit(state.copyWith(
          advertsStatus: AdvertsStatus.indexFailure, error: error.toString()));
    }
  }

  Future<void> nextFavPage(String? token) async {
    int nextFavPage = state.currentFavPage + 1;
    await fetchFavAdverts(token, page: nextFavPage);
  }

  Future<void> previousFavPage(String? token) async {
    int previousFavPage = state.currentFavPage - 1;
    if (previousFavPage < 1) return;
    await fetchFavAdverts(token, page: previousFavPage);
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

  Future<void> toggleAdvertFav(Advert advert, String token) async {
    try {
      emit(state.copyWith(advertsStatus: AdvertsStatus.loading));

      advert.isFav = !advert.isFav;

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
      emit(state.copyWith(
          advertsStatus: AdvertsStatus.indexFailure, error: error.toString()));
    }
  }
}
