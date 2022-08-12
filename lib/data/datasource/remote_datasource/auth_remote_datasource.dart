import 'package:dapass/core/data/base_api.dart';

abstract class AuthRemoteDataSource {
  Future<String> login(String username, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final BaseApi _baseApi;

  AuthRemoteDataSourceImpl({required BaseApi baseApi}) : _baseApi = baseApi;

  @override
  Future<String> login(String username, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }
}
