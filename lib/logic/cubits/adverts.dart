import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swc_front/data/repositories/advert_repository.dart';

import '../../data/models/advert.dart';
import '../../presentation/router/app_router.dart';
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
    } catch (e) {
      emit(state.copyWith(
          advertsStatus: AdvertsStatus.failure,
          error: 'Error al traer los anuncios'));
    }
  }

  Future<void> createAdvert(Advert advert) async {
    try {
      emit(state.copyWith(advertsStatus: AdvertsStatus.loading));
      Advert createdAdvert = await _advertRepository.create(advert);
      state.adverts.add(createdAdvert);
      emit(state.copyWith(
        advertsStatus: AdvertsStatus.success,
        adverts: state.adverts,
        nextRoute: Routes.indexPage,
      ));
    } catch (e) {
      emit(state.copyWith(
          advertsStatus: AdvertsStatus.failure,
          error: 'Error al crear el anuncios'));
    }
  }
}
