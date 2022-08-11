import 'package:dapass/model/user.dart';

class LiveDatasource {
  String? _token;
  User? _currentUser;

  User? get currentUser => _currentUser;
  setCurrentUser(User user) {
    _currentUser = user;
  }

  String? get token => _token;
  void setToken(String token) {
    _token = token;
  }

  //singleton
  LiveDatasource._internal();
  static final LiveDatasource _instance = LiveDatasource._internal();
  factory LiveDatasource() => _instance;
}
