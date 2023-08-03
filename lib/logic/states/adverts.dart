import '../../data/models/advert.dart';
import 'base.dart';

enum AdvertsStatus {
  initial,
  loading,
  indexSuccess,
  createSuccess,
  createFailure,
  indexFailure,
}

class AdvertsState extends BaseState {
  final List<Advert> adverts;
  final List<String> adTags;
  final String error;
  final AdvertsStatus status;
  final int currentPage;
  final int currentFavPage;
  final int currentMyAdsPage;

  AdvertsState(
      {required this.currentFavPage,
      required this.adverts,
      required this.adTags,
      required this.error,
      required this.status,
      required this.currentPage,
      required this.currentMyAdsPage});

  factory AdvertsState.initial() {
    return AdvertsState(
      adverts: [],
      error: '',
      status: AdvertsStatus.initial,
      currentPage: 1,
      currentFavPage: 1,
      adTags: [],
      currentMyAdsPage: 1,
    );
  }

  AdvertsState copyWith(
      {List<Advert>? adverts,
      String? error,
      AdvertsStatus? advertsStatus,
      int? currentPage,
      int? currentFavPage,
      List<String>? adTags,
      int? currentMyAdsPage}) {
    return AdvertsState(
      error: error ?? this.error,
      adverts: adverts ?? this.adverts,
      status: advertsStatus ?? this.status,
      currentPage: currentPage ?? this.currentPage,
      currentFavPage: currentFavPage ?? this.currentFavPage,
      adTags: adTags ?? this.adTags,
      currentMyAdsPage: currentMyAdsPage ?? this.currentMyAdsPage,
    );
  }
}
