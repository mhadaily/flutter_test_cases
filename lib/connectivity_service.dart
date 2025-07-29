import 'package:connectivity_plus/connectivity_plus.dart';

// The abstract contract
abstract class ConnectivityService {
  Future<List<ConnectivityResult>> checkConnectivity();
}

// The real implementation using the plugin
class AppConnectivityService implements ConnectivityService {
  final Connectivity _connectivity;
  AppConnectivityService(this._connectivity);

  @override
  Future<List<ConnectivityResult>> checkConnectivity() =>
      _connectivity.checkConnectivity();
}
