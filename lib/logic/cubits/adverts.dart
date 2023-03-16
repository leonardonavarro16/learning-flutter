import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swc_front/data/repositories/advert_repository.dart';

import '../../data/models/advert.dart';
import '../states/adverts.dart';

class AdvertsCubit extends Cubit<AdvertsState> {
  final AdvertRepository _advertRepository = AdvertRepository();

  AdvertsCubit() : super(AdvertsInitial());

  Future<void> fetchAdverts() async {
    emit(AdvertsFetchInProgress());
    List<Advert> adverts = await _advertRepository.fetchAll();
    try {
      emit(AdvertsFetchSuccess(adverts));
    } catch (e) {
      emit(AdvertsFetchFailure('Error al traer los anuncios'));
    }
  }

  Future<void> createAdvert(Advert advert) async {
    emit(AdvertsCreateInProgress());
    try {
      Advert createdAdvert = await _advertRepository.create(advert);
      emit(AdvertsCreateSuccess(createdAdvert));
    } catch (e) {
      emit(AdvertsCreateFailure('Error al traer los anuncios'));
    }
  }
}
