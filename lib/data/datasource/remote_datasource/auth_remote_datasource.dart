abstract class AuthRemoteDataSource {
  Future<String> login(String username, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<String> login(String username, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }
}
