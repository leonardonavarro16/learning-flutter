import '../../data/models/advert.dart';
import 'base.dart';

enum AdvertsStatus {
  initial,
  loading,
  indexSuccess,
  indexFailure,
}

class AdvertsState extends BaseState {
  final List<Advert> adverts;
  final String error;
  final AdvertsStatus status;
  final int currentPage;

  AdvertsState({
    required this.adverts,
    required this.error,
    required this.status,
    required this.currentPage,
  });

  factory AdvertsState.initial() {
    return AdvertsState(
      adverts: [],
      error: '',
      status: AdvertsStatus.initial,
      currentPage: 1,
    );
  }

  AdvertsState copyWith({
    List<Advert>? adverts,
    String? error,
    AdvertsStatus? advertsStatus,
    int? currentPage,
  }) {
    return AdvertsState(
      error: error ?? this.error,
      adverts: adverts ?? this.adverts,
      status: advertsStatus ?? this.status,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
