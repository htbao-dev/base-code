import 'package:connectivity_plus/connectivity_plus.dart';

/// This class is used to handle network.

abstract class NetworkHelper {
  Future<bool> get isOnline;
  Stream<ConnectivityResult> get onConnectionChanged;
}

class NetworkHelperImpl implements NetworkHelper {
  final Connectivity connectivity = Connectivity();

  NetworkHelperImpl();

  @override
  Future<bool> get isOnline async {
    var result = await connectivity.checkConnectivity();
    return _isconnect(result);
  }

  @override
  Stream<ConnectivityResult> get onConnectionChanged =>
      connectivity.onConnectivityChanged;

  bool _isconnect(ConnectivityResult result) {
    return (result == ConnectivityResult.mobile) ||
        (result == ConnectivityResult.wifi);
  }
}
