class CurrentUserAPI {
  final Map<String, dynamic> _user = {
    'name': 'pollo',
    'desiredAge': 19,
    'phoneNumber': '+57 301 323 7812',
  };

  Future<Map<String, dynamic>> fetch() async {
    return _user;
  }

  Future<Map<String, dynamic>> update(user) async {
    await Future.delayed(const Duration(seconds: 1));
    _user.addAll(user);
    return _user;
  }
}
