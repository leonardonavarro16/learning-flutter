import '../../data/models/advert.dart';

abstract class AdvertsState {}

// name convetion = cubit name + action + action's state

class AdvertsInitial extends AdvertsState {}

class AdvertsFetchInProgress extends AdvertsState {}

class AdvertsFetchSuccess extends AdvertsState {
  List<Advert> adverts;

  AdvertsFetchSuccess(this.adverts);
}

class AdvertsFetchFailure extends AdvertsState {
  String message = 'error error man';

  AdvertsFetchFailure(this.message);
}

class AdvertsCreateInProgress extends AdvertsState {}

class AdvertsCreateSuccess extends AdvertsState {
  Advert advert;

  AdvertsCreateSuccess(this.advert);
}

class AdvertsCreateFailure extends AdvertsState {
  String message;

  AdvertsCreateFailure(this.message);
}
