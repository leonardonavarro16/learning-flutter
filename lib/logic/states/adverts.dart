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

class AdvertCreateInProgress extends AdvertsState {}

class AdvertCreateSuccess extends AdvertsState {
  Advert advert;

  AdvertCreateSuccess(this.advert);
}

class AdvertCreateFailure extends AdvertsState {}



// List<Advert> adverts = [
  //   Advert(
  //       image: Image.network(
  //         'https://cdni.pornpics.de/460/7/518/39935848/39935848_050_0044.jpg',
  //       ),
  //       user:
  //           User(name: 'Rosa', desiredAge: 20, phoneNumber: '+57 301 345 6789'),
  //       description: 'soy una nena bien caliente'),
  //   Advert(
  //       image: Image.network(
  //         'https://cdni.pornpics.com/460/7/390/39177480/39177480_063_e13a.jpg',
  //       ),
  //       user:
  //           User(name: 'Rosa', desiredAge: 20, phoneNumber: '+57 301 345 6789'),
  //       description: 'soy una nena bien caliente'),
  //   Advert(
  //     image: Image.network(
  //       'https://cdni.pornpics.com/460/1/364/44027804/44027804_007_39de.jpg',
  //     ),
  //     user: User(name: 'Rosa', desiredAge: 20, phoneNumber: '+57 301 345 6789'),
  //     description: 'soy una nena bien caliente',
  //   ),
  //   Advert(
  //     image: Image.network(
  //       'https://cdni.pornpics.com/460/1/259/55374865/55374865_012_7c56.jpg',
  //     ),
  //     user: User(name: 'Rosa', desiredAge: 20, phoneNumber: '+57 301 345 6789'),
  //     description: 'soy una nena bien caliente',
  //   ),
  //   Advert(
  //       'https://cdni.pornpics.com/460/7/167/83446716/83446716_114_1bdd.jpg',
  //     image: Image.network(
  //     ),
  //     user: User(name: 'Rosa', desiredAge: 20, phoneNumber: '+57 301 345 6789'),
  //     description: 'soy una nena bien caliente',
  //   ),
  //   Advert(
  //     image: Image.network(
  //       'https://cdni.pornpics.com/460/7/548/11431620/11431620_054_75cb.jpg',
  //     ),
  //     user: User(name: 'Rosa', desiredAge: 20, phoneNumber: '+57 301 345 6789'),
  //     description: 'soy una nena bien caliente',
  //   ),
  //   ];
  // }