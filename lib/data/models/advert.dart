class Advert {
  String imageUrl;
  String name;
  int age;
  String phoneNumber;
  String description;

  Advert(
      {required this.phoneNumber,
      required this.age,
      required this.name,
      required this.imageUrl,
      required this.description});

  static Advert fromMap(Map<String, dynamic> advertData) {
    return Advert(
        imageUrl: advertData['imageUrl'] ??
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZNQZI9chyqtlvn6KNfid_ACsf4O-NiKn9Cw&usqp=CAU',
        name: advertData['name'],
        age: advertData['age'],
        phoneNumber: advertData['phone'],
        description: advertData['description']);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'description': description,
      'phone': phoneNumber
    };
  }
}
