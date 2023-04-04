class User {
  String name;
  int age;
  String phoneNumber;
  String email;

  User(
      {required this.name,
      required this.age,
      required this.phoneNumber,
      required this.email});

  static User fromMap(Map<String, dynamic> userData) {
    return User(
        name: userData['fullname'],
        age: userData['age'],
        phoneNumber: userData['phone'],
        email: userData['email']);
  }

  Map<String, dynamic> toMap() {
    return {'fullname': name, 'age': age, 'phone': phoneNumber, 'email': email};
  }
}
