import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swc_front/data/repositories/advert_repository.dart';

import '../../data/models/advert.dart';
import '../states/adverts.dart';

class AdvertsCubit extends Cubit<AdvertsState> {
  final AdvertRepository _advertRepository = AdvertRepository();

  AdvertsCubit() : super(AdvertsState.initial());

  Future<void> fetchAdverts() async {
    emit(state.copyWith(advertsStatus: AdvertsStatus.loading));
    try {
      List<Advert> adverts = await _advertRepository.fetchAll();
      emit(state.copyWith(
        advertsStatus: AdvertsStatus.success,
        adverts: adverts,
      ));
    } catch (error) {
      emit(state.copyWith(
          advertsStatus: AdvertsStatus.failure, error: error.toString()));
    }
  }

  Future<void> createAdvert(Advert advert, String token) async {
    try {
      emit(state.copyWith(advertsStatus: AdvertsStatus.loading));
      Advert createdAdvert = await _advertRepository.create(advert, token);
      state.adverts.add(createdAdvert);
      emit(state.copyWith(
        advertsStatus: AdvertsStatus.success,
        adverts: state.adverts,
      ));
    } catch (error) {
      emit(state.copyWith(
          advertsStatus: AdvertsStatus.failure, error: error.toString()));
    }
  }
}
