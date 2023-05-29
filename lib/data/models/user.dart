import 'dart:typed_data';

class User {
  String? id;
  String name;
  String phoneNumber;
  String email;
  DateTime birthdate;
  Uint8List? image;

  User({
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.birthdate,
    this.image,
    this.id,
  });

  static User fromMap(Map<String, dynamic> userData) {
    return User(
      id: userData['id'].toString(),
      name: userData['fullname'],
      phoneNumber: userData['phone'],
      email: userData['email'],
      birthdate: DateTime.parse(userData['birthdate']),
      image: userData['image'],
    ); //.cast<Uint8List>());
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullname': name,
      'phone': phoneNumber,
      'email': email,
      'birthdate': birthdate.toString(),
      'image': image,
    };
  }
}
