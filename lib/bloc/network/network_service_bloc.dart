import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@Singleton()
class NetworkServiceBloc {
  Connectivity connectivity = Connectivity();

  final BehaviorSubject<bool> _connection = BehaviorSubject<bool>();

  BehaviorSubject<bool> get connection => _connection;

  void getConnectivityStatus() async {
    connectivity.onConnectivityChanged.listen((result) {
      _checkNetworkConnection(result);
    });
  }

  void _checkNetworkConnection(ConnectivityResult result) async {
    bool hasConnection = false;
    try {
      ConnectivityResult result = await connectivity.checkConnectivity();
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        hasConnection = true;
      }
    } on Exception catch (error) {
      hasConnection = false;
    }
    _connection.add(hasConnection);
  }
}
