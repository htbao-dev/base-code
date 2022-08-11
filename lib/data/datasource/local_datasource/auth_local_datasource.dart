abstract class AuthLocalDataSource {
  Future<String?> getToken();
  Future<void> saveToken(String token);
  Future<void> deleteToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  Future<String?> getToken() async {
    // TODO: implement deleteToken
    throw UnimplementedError();
  }

  Future<void> saveToken(String token) async {
    // TODO: implement deleteToken
    throw UnimplementedError();
  }

  @override
  Future<void> deleteToken() {
    // TODO: implement deleteToken
    throw UnimplementedError();
  }
}
