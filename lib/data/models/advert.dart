import 'package:flutter/material.dart';
import 'package:swc_front/data/models/user.dart';

class Advert {
  Image image;
  User user;
  String description;

  Advert({required this.image, required this.user, required this.description});

  static fromJson(advertData) {}
}
