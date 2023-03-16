class Advert {
  String imageUrl;
  String name;
  int desiredAge;
  String phoneNumber;
  String description;

  Advert(
      {required this.phoneNumber,
      required this.desiredAge,
      required this.name,
      required this.imageUrl,
      required this.description});

  static Advert fromMap(Map<String, dynamic> advertData) {
    return Advert(
        imageUrl: advertData['imageUrl'] ??
            'https://images.unsplash.com/photo-1525609004556-c46c7d6cf023?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=452&q=80',
        name: advertData['name'],
        desiredAge: advertData['age'],
        phoneNumber: advertData['phone'],
        description: advertData['description']);
  }

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'name': name,
      'age': desiredAge,
      'description': description,
      'phone': phoneNumber
    };
  }
}
