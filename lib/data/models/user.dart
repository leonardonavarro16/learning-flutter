class User {
  String name;
  int desiredAge;
  String phoneNumber;

  User(
      {required this.name,
      required this.desiredAge,
      required this.phoneNumber});

  static User fromMap(Map<String, dynamic> userData) {
    return User(
        name: userData['name'],
        desiredAge: userData['desiredAge'],
        phoneNumber: userData['phoneNumber']);
  }

  // Map<String, dynamic> toMap() {
  //   return {'name': name, 'desiredAge': desiredAge, 'phone': phoneNumber};
  // }
}
