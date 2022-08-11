import 'package:dapass/model/user.dart';

class LiveDataSource {
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
  LiveDataSource._internal();
  static final LiveDataSource _instance = LiveDataSource._internal();
  factory LiveDataSource() => _instance;
}
