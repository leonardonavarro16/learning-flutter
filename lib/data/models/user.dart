import 'dart:typed_data';

import 'package:flutter/material.dart';

class User {
  String name;
  int age;
  String phoneNumber;
  String email;
  DateTime birthdate;
  Uint8List? image;
  int? id;

  User(
      {required this.name,
      required this.age,
      required this.phoneNumber,
      required this.email,
      required this.birthdate,
      this.image,
      this.id});

  static User fromMap(Map<String, dynamic> userData) {
    return User(
        id: userData['id'],
        name: userData['fullname'],
        age: userData['age'],
        phoneNumber: userData['phone'],
        email: userData['email'],
        birthdate: DateTime.parse(userData['birthdate']),
        image: userData['image']); //.cast<Uint8List>());
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id.toString(),
      'fullname': name,
      'age': age,
      'phone': phoneNumber,
      'email': email,
      'birthdate': birthdate.toString(),
      'image': image,
    };
  }
}
