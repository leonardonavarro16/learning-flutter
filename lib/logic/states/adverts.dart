import '../../data/models/advert.dart';

enum AdvertsStatus { initial, loading, success, failure }

class AdvertsState {
  final List<Advert> adverts;
  final String error;
  final AdvertsStatus advertsStatus;

  AdvertsState(
      {required this.adverts,
      required this.error,
      required this.advertsStatus});

  factory AdvertsState.initial() {
    return AdvertsState(
        adverts: [], error: '', advertsStatus: AdvertsStatus.initial);
  }

  AdvertsState copyWith(
      {AdvertsStatus? advertsStatus, String? error, List<Advert>? adverts}) {
    return AdvertsState(
      error: error ?? this.error,
      adverts: adverts ?? this.adverts,
      advertsStatus: advertsStatus ?? this.advertsStatus,
    );
  }
}
