import '../../data/models/advert.dart';
import 'base.dart';

enum AdvertsStatus { initial, loading, success, failure }

class AdvertsState extends BaseState {
  final List<Advert> adverts;
  final String error;
  final AdvertsStatus status;

  AdvertsState({
    required this.adverts,
    required this.error,
    required this.status,
  });

  factory AdvertsState.initial() {
    return AdvertsState(adverts: [], error: '', status: AdvertsStatus.initial);
  }

  AdvertsState copyWith({
    AdvertsStatus? advertsStatus,
    String? error,
    List<Advert>? adverts,
  }) {
    return AdvertsState(
      error: error ?? this.error,
      adverts: adverts ?? this.adverts,
      status: advertsStatus ?? status,
    );
  }
}
