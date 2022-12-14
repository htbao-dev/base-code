import 'package:dapass/data/datasource/live_datasource/live_datasource.dart';
import 'package:dapass/data/datasource/local_datasource/auth_local_datasource.dart';
import 'package:dapass/data/datasource/remote_datasource/auth_remote_datasource.dart';
import 'package:dapass/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDatasource;
  final LiveDataSource _liveDataSource = LiveDataSource();
  AuthRepositoryImpl(
      {required AuthRemoteDataSource authRemoteDataSource,
      required AuthLocalDataSource authLocalDatasource})
      : _authRemoteDataSource = authRemoteDataSource,
        _authLocalDatasource = authLocalDatasource;

  @override
  Future<String> login(String username, String password) async {
    try {
      final String token =
          await _authRemoteDataSource.login(username, password);
      _liveDataSource.setToken(token);
      _authLocalDatasource.saveToken(token);
      return token;
    } catch (_) {
      rethrow;
    }
  }
}
