import 'dart:typed_data';

class User {
  String name;
  int age;
  String phoneNumber;
  String email;
  int? id;
  Uint8List? avatarImage;

  User(
      {required this.name,
      required this.age,
      required this.phoneNumber,
      required this.email,
      this.avatarImage,
      this.id});

  static User fromMap(Map<String, dynamic> userData) {
    return User(
      id: userData['id'],
      name: userData['fullname'],
      age: userData['age'],
      phoneNumber: userData['phone'],
      email: userData['email'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id.toString(),
      'fullname': name,
      'age': age,
      'phone': phoneNumber,
      'email': email,
    };
  }
}
