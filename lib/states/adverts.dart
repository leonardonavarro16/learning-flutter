import 'package:flutter/widgets.dart';
import '../models/advert.dart';
import '../models/user.dart';

class AdvertsState extends ChangeNotifier {
  List<Advert> adverts = [
    Advert(
        image: Image.network(
          'https://cdni.pornpics.de/460/7/518/39935848/39935848_050_0044.jpg',
        ),
        user:
            User(name: 'Rosa', desiredAge: 20, phoneNumber: '+57 301 345 6789'),
        description: 'soy una nena bien caliente'),
    Advert(
        image: Image.network(
          'https://cdni.pornpics.com/460/7/390/39177480/39177480_063_e13a.jpg',
        ),
        user:
            User(name: 'Rosa', desiredAge: 20, phoneNumber: '+57 301 345 6789'),
        description: 'soy una nena bien caliente'),
    Advert(
      image: Image.network(
        'https://cdni.pornpics.com/460/1/364/44027804/44027804_007_39de.jpg',
      ),
      user: User(name: 'Rosa', desiredAge: 20, phoneNumber: '+57 301 345 6789'),
      description: 'soy una nena bien caliente',
    ),
    Advert(
      image: Image.network(
        'https://cdni.pornpics.com/460/1/259/55374865/55374865_012_7c56.jpg',
      ),
      user: User(name: 'Rosa', desiredAge: 20, phoneNumber: '+57 301 345 6789'),
      description: 'soy una nena bien caliente',
    ),
    Advert(
      image: Image.network(
        'https://cdni.pornpics.com/460/7/167/83446716/83446716_114_1bdd.jpg',
      ),
      user: User(name: 'Rosa', desiredAge: 20, phoneNumber: '+57 301 345 6789'),
      description: 'soy una nena bien caliente',
    ),
    Advert(
      image: Image.network(
        'https://cdni.pornpics.com/460/7/548/11431620/11431620_054_75cb.jpg',
      ),
      user: User(name: 'Rosa', desiredAge: 20, phoneNumber: '+57 301 345 6789'),
      description: 'soy una nena bien caliente',
    ),
    Advert(
      image: Image.network(
        'https://cdni.pornpics.com/460/7/146/99594170/99594170_034_4876.jpg',
      ),
      user: User(name: 'Rosa', desiredAge: 20, phoneNumber: '+57 301 345 6789'),
      description: 'soy una nena bien caliente',
    ),
    Advert(
      image: Image.network(
        'https://plus.unsplash.com/premium_photo-1669868116752-acd4bc7bc6a2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
      ),
      user: User(name: 'Rosa', desiredAge: 20, phoneNumber: '+57 301 345 6789'),
      description: 'soy una nena bien caliente',
    ),
  ];

  void addAvert(Advert advert) {
    adverts.add(advert);
    notifyListeners();
  }
}
